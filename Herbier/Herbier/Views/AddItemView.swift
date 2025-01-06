//
//  AddPictureView.swift
//  Herbier
//
//  Created by etudiant on 26/12/2024.
//

import SwiftUI
import SwiftData

struct AddItemView: View {
    var itemsController: ItemController
    
    @State private var selectedImage: UIImage? = nil
    @State private var ImagePickerVisible: Bool = false
    @State private var selectedCategory: String = ""
    @State private var selectedDate: Date = Date()
    @State private var pictureName: String = ""

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
                    ImagePickerVisible.toggle()
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
                
                Picker(selection: $selectedCategory, label: Text("Catégorie")) {
                    Text("Sélectionner une catégorie").tag("")
                    Text("Animal").tag("animal")
                    Text("Végétal").tag("vegetal")
                    Text("Fungieux").tag("fungieux")
                }
                
                Spacer()
                    .frame(height: screen.size.height * 0.05)
                
                Button("Ajouter") {
                    self.itemsController.addItem(selectedImage!, selectedDate, selectedCategory, pictureName)
                    resetSelection()
                }
            }
            .sheet(isPresented: $ImagePickerVisible) {
                ImagePicker(selectedImage: $selectedImage, ImagePickerVisible: $ImagePickerVisible)
            }//Selection d'image de la galerie
        }
    }
    
    private func resetSelection() {
        selectedDate = Date()
        selectedImage = nil
        selectedCategory = ""
    }
}
