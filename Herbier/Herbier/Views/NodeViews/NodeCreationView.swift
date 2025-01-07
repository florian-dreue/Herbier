//
//  NodeCreationView.swift
//  Herbier
//
//  Created by Fréééédéric on 07/01/2025.
//

import SwiftUI

struct NodeCreationView: View {
    @Environment(\.dismiss) private var dismiss
    
    private var nodeController: NodeController
    private var parentNode: Node?
    
    @State private var attribute: String = ""
    @State private var questionForSons: String = ""
    
    public init(nodeController: NodeController, parentNode: Node?) {
        self.nodeController = nodeController
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
                nodeController.addNode(attribute: attribute, question: questionForSons, parentNode: parentNode)
                dismiss()
            }
        }
    }
}
