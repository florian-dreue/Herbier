//
//  ListItemView.swift
//  Herbier
//
//  Created by Fréééédéric on 06/01/2025.
//

import SwiftUI

struct ListItem: View {
    @State var item: Item
    
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
                Text(item.creationDate.description)
            }
        }
    }
}
