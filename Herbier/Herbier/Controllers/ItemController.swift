//
//  ItemController.swift
//  Herbier
//
//  Created by Fréééédéric on 06/01/2025.
//

import SwiftData
import SwiftUI

public class ItemController {
    private let dataService: DatabaseService
    
    init(dataService: DatabaseService) {
        self.dataService = dataService
    }
    
    func addItem(_ selectedImage: UIImage, _ selectedDate: Date, _ pictureName: String, _ node: Node) {
        let imageData = selectedImage.jpegData(compressionQuality: 1.0)
        let nouvelItem = Item(name: pictureName, creationDate: selectedDate, imageData: imageData!, node: node)
        
        node.items.append(nouvelItem)
        
        self.dataService.getModelContext().insert(nouvelItem)

        do {
            try self.dataService.getModelContext().save()
            //Sauvegarde l'enregistrement
            print("Item sauvegardé avec succès !")
            
        } catch {
            print("Erreur lors de la sauvegarde de l'item : \(error.localizedDescription)")
        }
    }
}