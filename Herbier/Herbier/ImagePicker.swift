//
//  ImagePicker.swift
//  Herbier
//
//  Created by etudiant on 26/12/2024.
//

import SwiftUI
import UIKit

struct ImagePicker: UIViewControllerRepresentable {
    //Binding permet de renvoyé la valeur au parent
    @Binding var selectedImage: UIImage?
    @Binding var ImagePickerVisible: Bool
    
    //Contient la logique de sélection d'image et d'annulation
    class Coordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
        @Binding var selectedImage: UIImage?
        @Binding var ImagePickerVisible: Bool
        
        //Initialiser
        init(selectedImage: Binding<UIImage?>, ImagePickerVisible: Binding<Bool>) {
            _selectedImage = selectedImage
            _ImagePickerVisible = ImagePickerVisible
        }
        
        //Fonction lorsque l'utilisateur séléctionne une image
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            if let image = info[.originalImage] as? UIImage {
                selectedImage = image
            }
            ImagePickerVisible = false
        }
        
        //Fonction lorsque l'utilisateur appuie sur anuller
        func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
            ImagePickerVisible = false
        }
    }
    
    //Fonction permettant d'initialiser le Coordinator
    func makeCoordinator() -> Coordinator {
        return Coordinator(selectedImage: $selectedImage, ImagePickerVisible: $ImagePickerVisible)
    }
    
    //Fonction qui créer et retourne le picker
    func makeUIViewController(context: Context) -> UIImagePickerController {
        let picker = UIImagePickerController()
        picker.delegate = context.coordinator
        picker.allowsEditing = false //Désactive l'édition avant sélection
        picker.sourceType = .photoLibrary //Sélection dans la bibliothèque de photo
        return picker
    }
    
    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {}
}

