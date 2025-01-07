//
//  Node.swift
//  Herbier
//
//  Created by Fréééédéric on 07/01/2025.
//

import SwiftUI
struct NodeDetailView: View {
    @Environment(\.dismiss) private var dismiss
    
    private var node: Node
    private var father: Node?
    private var sons: [Node]
    private var nodeController: NodeController
    
    public init(nodeController: NodeController, node: Node) {
        self.node = node
        self.father = node.father
        self.sons = node.sons
        self.nodeController = nodeController
    }
    
    var body: some View {
        VStack {
            HStack {
                if (father != nil) {
                    Text(father!.questionForSons)
                }
                Text(node.attributeName)
            }
            
            VStack() {
                HStack {
                    Text(node.questionForSons)
                    NavigationLink(destination: NodeCreationView(nodeController: nodeController, parentNode: self.node)) {
                        Text("Ajouter un fils")
                    }
                }
                
                ForEach(sons) { son in
                    NavigationLink(destination: NodeDetailView(nodeController: self.nodeController, node: son)) {
                        Text(son.attributeName)
                    }
                }
                
                ForEach(node.items) { item in
                    ListItem(item: item)
                }
            }
            
            Spacer()
        }
    }
}
