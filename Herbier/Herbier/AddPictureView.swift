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
    let currentDate = Date()

    var body: some View {
        VStack() {
            if let selectedImage = selectedImage {
                Image(uiImage: selectedImage)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 300, height: 300)
                    .shadow(radius: 10)
                    .background(Color.red)
            } else {
                Text("Aucune image sélectionnée")
                    .foregroundColor(.gray)
                    .multilineTextAlignment(.center)
                    .frame(width: 300, height: 300)
                    .background(Color.red)
            }
            Spacer()
                .frame(height: 20)
            Button("Choisir une photo") {
                isImagePickerPresented.toggle()
            }
            DatePicker(selection: /*@START_MENU_TOKEN@*/.constant(Date())/*@END_MENU_TOKEN@*/,
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
                
            }
        }
        .sheet(isPresented: $isImagePickerPresented) {
            ImagePicker(selectedImage: $selectedImage, isImagePickerPresented: $isImagePickerPresented)
        }
        .padding(.horizontal, 30.0)
    }
    
    private func addItem() {
        withAnimation {
            let newItem = Item(timestamp: Date(), name: "test")
            modelContext.insert(newItem)
        }
    }
    
}

#Preview {
    AddPictureView()
}
