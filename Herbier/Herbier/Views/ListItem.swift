//
//  ListItemView.swift
//  Herbier
//
//  Created by Fréééédéric on 06/01/2025.
//

import SwiftUI

//Affichage de chaque Item formatter pour la liste
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
                .scaledToFit()
                .frame(width: 128, height: 80)
                .cornerRadius(8)
            
            VStack(alignment: .leading, spacing: 8) {
                Text(item.name)
                    .foregroundColor(.black)
                HStack {
                    Text(dateFormatter.string(from: item.creationDate))
                        .foregroundColor(.black)
                    Text(item.node.attributeName)
                        .foregroundColor(.black)
                }
            }
        }
    }
}
