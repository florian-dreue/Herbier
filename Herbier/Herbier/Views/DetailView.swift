//
//  DetailView.swift
//  Herbier
//
//  Created by etudiant on 27/12/2024.
//

import SwiftUI

struct DetailView: View {
    var item: Item
    
    private let dateFormatter: DateFormatter = {
                let formatter = DateFormatter()
                formatter.dateStyle = .medium
                formatter.timeStyle = .none
                return formatter
    }();
    
    var body: some View {
        GeometryReader { geometry in
            VStack() {
                Image(uiImage: UIImage(data: item.imageData)!)
                    .resizable()
                    .scaledToFit()
                    .frame(width: geometry.size.width * 0.75, height: geometry.size.height * 0.4)
                    .shadow(radius: 10)
                Spacer()
                    .frame(height: 20)
                Text("Photo prise le: \(dateFormatter.string(from: item.creationDate))")
                    .frame(width: geometry.size.width * 0.75)
                Text(item.name)
                Text(item.node.attributeName)
            }
            .frame(width: geometry.size.width)
        }
    }
}
