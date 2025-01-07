//
//  GraphView.swift
//  Herbier
//
//  Created by Fréééédéric on 07/01/2025.
//

import SwiftUI
import SwiftData

struct GraphView: View {
    @Query() private var nodes: [Node] = []
    
    var node: Node? = nil
    var nodeController: NodeController
    var body: some View {
        VStack() {
            if (nodes.isEmpty) {
                
            }
        }
    }
}
