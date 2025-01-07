//
//  NodeController.swift
//  Herbier
//
//  Created by Fréééédéric on 07/01/2025.
//

import SwiftData
import SwiftUICore

class NodeController {
    private var modelContext: ModelContext
    
    public init(modelContext: ModelContext) {
        self.modelContext = modelContext
    }
    
    func addNode(attribute: String, question: String, parentNode: Node?) {
        let newNode = Node(attributeName: attribute, questionForSons: question, father: parentNode, sons: nil)
        if (parentNode != nil) {
            parentNode!.sons.append(newNode)
        }
        
        modelContext.insert(newNode)
        
        do {
            try modelContext.save()
            print("Node ajouté avec succès")
        } catch {
            print ("Erreur lors de l'ajout de la Node : \(error.localizedDescription)")
        }
    }
}
