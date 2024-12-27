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
    @Query private var items: [Item]
    
    @State private var selectedImage: UIImage? = nil
    @State private var isImagePickerPresented: Bool = false
    @State private var selectedCategory: String = ""
    @State private var currentDate = Date()
    @State private var selectedDate: Date = Date()

    var body: some View {
        VStack() {
            if let selectedImage = selectedImage {
                Image(uiImage: selectedImage)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 300, height: 300)
                    .shadow(radius: 10)
            } else {
                Text("Aucune image sélectionnée")
                    .foregroundColor(.gray)
                    .multilineTextAlignment(.center)
                    .frame(width: 300, height: 300)
            }
            Spacer()
                .frame(height: 20)
            Button("Choisir une photo") {
                isImagePickerPresented.toggle()
            }
            DatePicker(selection: $selectedDate,
                       in: ...currentDate,
                       displayedComponents: [.date],
                       label: { /*@START_MENU_TOKEN@*/Text("Date")/*@END_MENU_TOKEN@*/ })
            .frame(width: 300)
            TextField("Nom de la photo", text: /*@START_MENU_TOKEN@*//*@PLACEHOLDER=Value@*/.constant("")/*@END_MENU_TOKEN@*/)
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
        .sheet(isPresented: $isImagePickerPresented) {
            ImagePicker(selectedImage: $selectedImage, isImagePickerPresented: $isImagePickerPresented)
        }
        .padding(.horizontal, 30.0)
    }
    
    private func addItem() {
        if(selectedImage != nil){
            let imageData = selectedImage!.jpegData(compressionQuality: 1.0)

            let newItem = TemporaryTable(timestamp: Date(), name: "test",image: imageData!, type: selectedCategory)
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
