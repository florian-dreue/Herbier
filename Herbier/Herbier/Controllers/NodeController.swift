//
//  NodeController.swift
//  Herbier
//
//  Created by Fréééédéric on 07/01/2025.
//

import SwiftData
import SwiftUICore

class NodeController {
    private var dataService: DatabaseService
    
    public init(dataService: DatabaseService) {
        self.dataService = dataService
    }
    
    func addNode(attribute: String, question: String, parentNode: Node?) {
        let newNode = Node(attributeName: attribute, questionForSons: question, father: nil, sons: nil)
        
        self.dataService.getModelContext().insert(newNode)
        
        if let parent = parentNode {
            newNode.father = parent
            parent.sons.append(newNode)
        }
        
        do {
            try self.dataService.getModelContext().save()
            print("Node ajouté avec succès")
        } catch {
            print ("Erreur lors de l'ajout de la Node : \(error.localizedDescription)")
        }
    }
}
