//
//  DetailView.swift
//  Herbier
//
//  Created by etudiant on 27/12/2024.
//

import SwiftUI

struct DetailView: View {
    var body: some View {
        VStack() {
            Image(systemName: "xmark")
                .onTapGesture {
                    /*showDetails = false*/
                }
            Image("PhotoTest")
                .resizable()
                .scaledToFit()
                .frame(width: 300, height: 300)
                .shadow(radius: 10)
            Spacer()
                .frame(height: 20)
            Text("Date de la photo")
            .frame(width: 300)
            Text("Nom de la photo")
            Text("Type de la photo")
        }
    }
}

#Preview {
    DetailView()
}
