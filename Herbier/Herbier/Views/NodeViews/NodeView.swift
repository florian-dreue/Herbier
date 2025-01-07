//
//  Node.swift
//  Herbier
//
//  Created by Fréééédéric on 07/01/2025.
//

import SwiftUI

struct NodeView: View {
    public let relativeNode: Node
    public let color: Color
    
    var body: some View {
        Circle()
            .fill(self.color)
            .frame(width: 80, height: 80)
            .overlay(
                Text("\(relativeNode.attributeName)")
                    .foregroundColor(.black)
                    .font(.headline)
            )
    }
}

struct EdgeView {
    public let parentNode: NodeView
    public let childNode: NodeView
}
