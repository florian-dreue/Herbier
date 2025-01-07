//
//  GraphView.swift
//  Herbier
//
//  Created by Fréééédéric on 07/01/2025.
//

import SwiftUI
import SwiftData

struct GraphView: View {
    @Query() private var nodes: [Node]
    var nodeController: NodeController
    var body: some View {
        VStack() {
            Text("Node Graph")
            
            GraphCanva(nodeController: nodeController)
        }
    }
}
