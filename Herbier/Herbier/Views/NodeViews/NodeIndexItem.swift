//
//  Node.swift
//  Herbier
//
//  Created by Fréééédéric on 07/01/2025.
//

import SwiftUI

struct NodeIndexItem: View {
    private var node: Node
    private var father: Node?
    private var sons: [Node]
    
    public init(node: Node) {
        self.node = node
        self.father = node.father
        self.sons = node.sons
    }
    
    var body: some View {
        VStack {
            HStack {
                if (father != nil) {
                    Text(father!.attributeName)
                }
                Text(node.attributeName)
            }
        }
    }
}
