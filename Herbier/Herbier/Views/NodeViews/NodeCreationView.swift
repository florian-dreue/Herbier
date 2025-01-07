//
//  NodeCreationView.swift
//  Herbier
//
//  Created by Fréééédéric on 07/01/2025.
//

import SwiftUI

struct NodeCreationView: View {
    @Environment(\.dismiss) private var dismiss
    @Environment(\.modelContext) private var modelContext
    
    private var nodeController: NodeController
    private var parentNode: Node?
    
    @State private var attribute: String = ""
    @State private var questionForSons: String = ""
    
    public init(nodeController: NodeController, parentNode: Node?) {
        self.nodeController = nodeController
        self.parentNode = parentNode
    }
    
    var body: some View {
        VStack {
            HStack {
                Text("Attribut : ")
                TextField("Attribut", text: $attribute)
                    .padding()
                    .textFieldStyle(RoundedBorderTextFieldStyle())
            }
            
            HStack {
                Text("Question pour les enfants : ")
                TextField("Question", text: $questionForSons)
                    .padding()
                    .textFieldStyle(RoundedBorderTextFieldStyle())
            }
            
            Button("Ajouter") {
                addNode()
                dismiss()
            }
        }
    }
    
    private func addNode() {
        let newNode = Node(attributeName: attribute, questionForSons: questionForSons, father: parentNode, sons: nil)
        
        modelContext.insert(newNode)
        
        if let parent = parentNode {
            newNode.father = parent
            parent.sons.append(newNode)
        }
        
        do {
            try modelContext.save()
            print("Node ajouté avec succès")
        } catch {
            print ("Erreur lors de l'ajout de la Node : \(error.localizedDescription)")
        }
    }
}
