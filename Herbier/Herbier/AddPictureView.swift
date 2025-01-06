//
//  AddPictureView.swift
//  Herbier
//
//  Created by etudiant on 26/12/2024.
//

import SwiftUI
import SwiftData
import Photos

struct AddPictureView: View {
    @Environment(\.modelContext) private var modelContext
    
    @State private var selectedImage: UIImage? = nil
    @State private var ImagePickerVisible: Bool = false
    @State private var selectedCategory: String = ""
    private var currentDate = Date()
    @State private var selectedDate: Date = Date()
    @State private var pictureName: String = ""
    @State private var LibrairyAcces: Bool = false

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
                    if LibrairyAcces {
                        ImagePickerVisible.toggle()
                    }
                    else{
                        
                    }
                }
                Spacer()
                    .frame(height: screen.size.height * 0.05)
                DatePicker(selection: $selectedDate,
                           in: ...currentDate,
                           displayedComponents: [.date],
                           label: { /*@START_MENU_TOKEN@*/Text("Date")/*@END_MENU_TOKEN@*/ })
                .frame(width: 300)
                Spacer()
                    .frame(height: screen.size.height * 0.05)
                TextField("Nom de la photo", text: $pictureName)
                    .multilineTextAlignment(TextAlignment.center)
                Spacer()
                    .frame(height: screen.size.height * 0.05)
                Picker(selection: $selectedCategory, label: Text("Catégorie")) {
                    Text("Sélectionner une catégorie").tag("")
                    Text("Animal").tag("animal")
                    Text("Végétal").tag("vegetal")
                    Text("Fongieux").tag("fongieux")
                }
                Spacer()
                    .frame(height: screen.size.height * 0.05)
                Button("Ajouter") {
                    addItem()
                }
            }
            .sheet(isPresented: $ImagePickerVisible) {
                ImagePicker(selectedImage: $selectedImage, ImagePickerVisible: $ImagePickerVisible)
            }//Selection d'image de la galerie
        }
        .onAppear {
            checkAccess()
        }
    }
    
    //Fonction pour l'ajout d'un item
    private func addItem() {
        if(selectedImage != nil){
            let imageData = selectedImage!.jpegData(compressionQuality: 1.0)

            let newItem = Record(timestamp: selectedDate, name: pictureName,image: imageData!, type: selectedCategory)
            modelContext.insert(newItem)

            do {
                try modelContext.save()
                print("Image sauvegardée avec succès !")
            } catch {
                print("Erreur lors de la sauvegarde de l'image : \(error.localizedDescription)")
            }
        }
        else {
            print("Aucune image sélectionnée")
        }
    }
    
    //Check l'autorisation actuelle
    private func checkAccess() {
        let status = PHPhotoLibrary.authorizationStatus(for: .readWrite)
        switch status {
            case .authorized, .limited:
            LibrairyAcces = true
            case .denied, .restricted, .notDetermined:
            LibrairyAcces = false
            @unknown default:
            LibrairyAcces = false
        }
    }
    
    //Demande l'accès à la galerie
    private func requestPhotoLibraryAccess() {
        PHPhotoLibrary.requestAuthorization { status in
            DispatchQueue.main.async {
                switch status {
                case .authorized, .limited:
                    //L'utilisateur autorise ou limite l'accès
                    LibrairyAcces = true
                case .denied, .restricted:
                    //L'utilisateur refuse
                    LibrairyAcces = false
                case .notDetermined:
                    // L'utilisateur n'a pas encore répondu
                    LibrairyAcces = false
                @unknown default:
                    LibrairyAcces = false
                }
            }
        }
    }
    
}

#Preview {
    AddPictureView()
}
