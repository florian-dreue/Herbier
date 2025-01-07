//
//  AddPictureView.swift
//  Herbier
//
//  Created by etudiant on 26/12/2024.
//

import SwiftUI
import SwiftData
import Photos

struct AddItemView: View {
    //Requête de récupération des différents node
    @Query() private var nodes: [Node]
    
    @Environment(\.modelContext) private var modelContext
    
    @State private var selectedImage: UIImage? = nil
    @State private var ImagePickerVisible: Bool = false
    @State private var selectedNode: Node = Node(attributeName: "Sélectionner une catégorie", questionForSons: "", father: nil, sons: nil, items: [])
    @State private var selectedDate: Date = Date()
    @State private var pictureName: String = ""
    @State private var libraryAccess: Bool = false

    var body: some View {
        GeometryReader { screen in //Container pour recuperer la taille de l'ecran
            VStack() {
                if let selectedImage = selectedImage {
                    Image(uiImage: selectedImage)
                        .resizable()
                        .scaledToFit()
                        .frame(width: screen.size.width * 0.75, height: screen.size.height * 0.4)
                        .shadow(radius: 10) //Si on as selectionne une image on l'affiche
                } else {
                    Text("Aucune image sélectionnée")
                        .foregroundColor(.gray)
                        .multilineTextAlignment(.center)
                        .frame(width: screen.size.width * 0.75, height: screen.size.height * 0.4) //Texte si pas d'image selectionnee
                }
                
                Spacer()
                    .frame(height: screen.size.height * 0.01)
                
                Button("Choisir une photo") {
                    if (libraryAccess) {
                        ImagePickerVisible.toggle()
                    } else {
                        requestPhotoLibraryAccess()
                    }
                }
                
                Spacer()
                    .frame(height: screen.size.height * 0.05)
                
                DatePicker(selection: $selectedDate,
                           in: ...Date.now,
                           displayedComponents: [.date],
                           label: { /*@START_MENU_TOKEN@*/Text("Date")/*@END_MENU_TOKEN@*/ })
                .frame(width: 300)
                
                Spacer()
                    .frame(height: screen.size.height * 0.05)
                
                TextField("Nom de la photo", text: $pictureName)
                    .multilineTextAlignment(TextAlignment.center)
                
                Spacer()
                    .frame(height: screen.size.height * 0.05)
                
                Picker(selection: $selectedNode, label: Text("Catégorie")) {
                    Text(selectedNode.attributeName).tag(selectedNode)
                    ForEach(nodes) { node in
                        Text(node.attributeName).tag(node)
                    }
                }
                
                Spacer()
                    .frame(height: screen.size.height * 0.05)
                
                Button("Ajouter") {
                    addItem()
                    resetSelection()
                }
            }
            .sheet(isPresented: $ImagePickerVisible) {
                ImagePicker(selectedImage: $selectedImage, ImagePickerVisible: $ImagePickerVisible)
            }//Selection d'image de la galerie
        }
        .onAppear() {
            checkAccess()
        }
    }
    
    //Remets les différents champs à leur valeur par défaut
    private func resetSelection() {
        selectedDate = Date()
        selectedImage = nil
        pictureName = ""
        selectedNode = Node(attributeName: "Sélectionner une catégorie", questionForSons: "", father: nil, sons: nil, items: [])
    }
    
    func addItem() {
        let imageData = selectedImage!.jpegData(compressionQuality: 1.0)
        let nouvelItem = Item(name: pictureName, creationDate: selectedDate, imageData: imageData!, node: selectedNode)
        
        selectedNode.items.append(nouvelItem)
        
        modelContext.insert(nouvelItem)

        do {
            try modelContext.save()
            //Sauvegarde l'enregistrement
            print("Item sauvegardé avec succès !")
            
        } catch {
            print("Erreur lors de la sauvegarde de l'item : \(error.localizedDescription)")
        }
    }
    
    //Check l'autorisation actuelle
    private func checkAccess() {
        let status = PHPhotoLibrary.authorizationStatus(for: .readWrite)
        switch status {
            case .authorized, .limited:
            libraryAccess = true
            case .denied, .restricted, .notDetermined:
            libraryAccess = false
            @unknown default:
            libraryAccess = false
        }
    }

    //Demande l'accès à la galerie
    private func requestPhotoLibraryAccess() {
        PHPhotoLibrary.requestAuthorization { status in
            DispatchQueue.main.async {
                switch status {
                case .authorized, .limited:
                    //L'utilisateur autorise ou limite l'accès
                    libraryAccess = true
                case .denied, .restricted:
                    //L'utilisateur refuse
                    libraryAccess = false
                case .notDetermined:
                    // L'utilisateur n'a pas encore répondu
                    libraryAccess = false
                @unknown default:
                    libraryAccess = false
                }
            }
        }
    }
}
