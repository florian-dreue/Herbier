//
//  ListItemView.swift
//  Herbier
//
//  Created by Fréééédéric on 06/01/2025.
//

import SwiftUI

struct ListItem: View {
    @State var item: Item
    
    private let dateFormatter: DateFormatter = {
                let formatter = DateFormatter()
                formatter.dateStyle = .medium
                formatter.timeStyle = .none
                return formatter
    }();
    
    var body: some View {
        HStack() {
            Image(uiImage: UIImage(data: item.imageData) ?? UIImage())
                .resizable()
                .clipped()
                .frame(width: 128, height: 80)
                .cornerRadius(8)
                .scaledToFit()
            
            VStack(alignment: .leading, spacing: 8) {
                Text(item.name)
                HStack {
                    Text(dateFormatter.string(from: item.creationDate))
                    Text(item.node.attributeName)
                }
            }
        }
    }
}
