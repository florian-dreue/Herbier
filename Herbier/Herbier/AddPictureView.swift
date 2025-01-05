//
//  AddPictureView.swift
//  Herbier
//
//  Created by etudiant on 26/12/2024.
//

import SwiftUI
import SwiftData

struct AddPictureView: View {
    @Environment(\.modelContext) private var modelContext
    
    @State private var selectedImage: UIImage? = nil
    @State private var ImagePickerVisible: Bool = false
    @State private var selectedCategory: String = ""
    private var currentDate = Date()
    @State private var selectedDate: Date = Date()
    @State private var pictureName: String = ""

    var body: some View {
        GeometryReader { screen in
            VStack() {
                if let selectedImage = selectedImage {
                    Image(uiImage: selectedImage)
                        .resizable()
                        .scaledToFit()
                        .frame(width: screen.size.width * 0.75, height: screen.size.height * 0.4)
                        .shadow(radius: 10)
                } else {
                    Text("Aucune image sélectionnée")
                        .foregroundColor(.gray)
                        .multilineTextAlignment(.center)
                        .frame(width: screen.size.width * 0.75, height: screen.size.height * 0.4)
                }
                Spacer()
                    .frame(height: screen.size.height * 0.01)
                Button("Choisir une photo") {
                    ImagePickerVisible.toggle()
                }
                DatePicker(selection: $selectedDate,
                           in: ...currentDate,
                           displayedComponents: [.date],
                           label: { /*@START_MENU_TOKEN@*/Text("Date")/*@END_MENU_TOKEN@*/ })
                .frame(width: 300)
                TextField("Nom de la photo", text: $pictureName)
                    .multilineTextAlignment(TextAlignment.center)
                Picker(selection: $selectedCategory, label: Text("Catégorie")) {
                    Text("Sélectionner une catégorie").tag("")
                    Text("Animal").tag("animal")
                    Text("Végétal").tag("vegetal")
                    Text("Fongieux").tag("fungieux")
                }
                Button("Ajouter") {
                    addItem()
                }
            }
            .sheet(isPresented: $ImagePickerVisible) {
                ImagePicker(selectedImage: $selectedImage, ImagePickerVisible: $ImagePickerVisible)
            }
        }
    }
    
    private func addItem() {
        if(selectedImage != nil){
            let imageData = selectedImage!.jpegData(compressionQuality: 1.0)

            let newItem = TemporaryTable(timestamp: Date(), name: pictureName,image: imageData!, type: selectedCategory)
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
    
}

#Preview {
    AddPictureView()
}
