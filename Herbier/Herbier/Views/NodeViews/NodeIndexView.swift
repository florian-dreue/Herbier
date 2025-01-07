import SwiftData
import SwiftUI

struct NodeIndexView: View {
    @Query() private var nodes: [Node] = []
    
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
            VStack {
                ForEach(nodes) { node in
                    NavigationLink(destination: NodeDetailView(nodeController: nodeController, node: node)) {
                        NodeIndexItem(node: node)
                    }
                }
                
                if (nodes.isEmpty) {
                    NavigationLink(destination: NodeCreationView(nodeController: self.nodeController, parentNode: nil)) {
                        Text("Ajouter une node de base")
                    }
                }
            }
                
        }
        
    }
}
