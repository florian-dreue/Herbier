//
//  GraphCanva.swift
//  Herbier
//
//  Created by Fréééédéric on 07/01/2025.
//

import SwiftData
import SwiftUI

struct GraphCanva: View {
    @Query() private var nodes: [Node] = []
    @State private var actualNode: Node? = nil
    
    private var nodeController: NodeController
    private var circleRadius: CGFloat = 100
    private var numberOfNode: Int = 0
    
    public init(nodeController: NodeController) {
        self.nodeController = nodeController
        self.circleRadius = 100
        self.numberOfNode = 0
    }
    
    var body: some View {
        NavigationView {
            ZStack {
                Canvas { context, size in
                    // Pour mettre les liens entre les nodes plus tard
                }
                
                if nodes.isEmpty {
                    nodePlus(nil)
                } else {
                    if let actualNode = actualNode {
                        NodeView(relativeNode: actualNode, color: Color.cyan)
                            .offset(getPosition(for: actualNode))
                        
                        ForEach(actualNode.sons) { node in
                            NodeView(relativeNode: node, color: Color.red)
                                .gesture(
                                    TapGesture()
                                        .onEnded {
                                            self.actualNode = node // Met à jour le nœud actuel
                                        }
                                )
                                .offset(getPosition(for: node))
                        }
                        
                        nodePlus(actualNode)

                        if let father = actualNode.father {
                            NodeView(relativeNode: father, color: Color.green)
                                .gesture(
                                    TapGesture()
                                        .onEnded {
                                            self.actualNode = father // Met à jour le nœud actuel avec son père
                                        }
                                )
                                .offset(getPosition(for: father))
                        }
                    }
                }
            }
            .onAppear {
                // Assurez-vous de charger la première node disponible dès l'apparition de la vue
                if !nodes.isEmpty {
                    actualNode = nodes[0] // On assigne la première node si elle existe
                }
            }
        }
    }
    
    // Fonction pour obtenir la position des fils en cercle autour du nœud actuel
    private func getPosition(for node: Node) -> CGSize {
        let totalCount = self.actualNode!.sons.count
        let index = node == self.actualNode ? 0 : calculateIndex(node)
        
        let angle = CGFloat(index) * (2 * .pi / CGFloat(totalCount)) // Calcul de l'angle pour chaque fils
        
        let x = circleRadius * cos(angle) // Coordonnée X en fonction du cercle
        let y = circleRadius * sin(angle) // Coordonnée Y en fonction du cercle
        return CGSize(width: x, height: y)
    }
    
    private func calculateIndex(_ node: Node) -> Int {
        if (node.father == nil) {
            return 0
        }
        
        var index = 1
        
        node.father?.sons.forEach { son in
            if (son == node) {
                return
            }
            print("on recherche la node \(node.attributeName) position : \(index)")
            index += 1
        }
        
        return index
    }
    
    private func nodePlus(_ nodeParent: Node?) -> some View {
        return NavigationLink(destination: NodeCreationView(nodeController: self.nodeController, parentNode: nodeParent)) {
            Text("+")
                .padding()
                .background(Color.gray)
                .foregroundColor(Color.black)
                .clipShape(Circle())
        }
    }
}
