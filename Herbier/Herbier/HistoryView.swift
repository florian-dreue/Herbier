//
//  HistoryView.swift
//  Herbier
//
//  Created by etudiant on 26/12/2024.
//

import SwiftUI

struct HistoryView: View {
    
    @State private var showDetails : Bool = false;
    
    var body: some View {
        if(showDetails) {
            /*DetailView()*/
            VStack() {
                Image(systemName: "xmark")
                    .onTapGesture {
                        showDetails = false
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
        else {
            VStack {
                ScrollView {
                    ForEach (0..<10) { _ in
                        HStack {
                            Image("PhotoTest")
                                .resizable()
                                .scaledToFit()
                                .frame(width: (100), height: 100)
                            VStack {
                                Text("Nom de la photo")
                                Spacer()
                                Text("Date")
                            }
                            .padding(.vertical, 20.0)
                            Text("Type")
                        }
                        .padding(.horizontal, 20.0)
                        .border(Color.black, width: 1)
                        .onTapGesture {
                            print("HStack cliqué!")
                            showDetails = true
                        }
                    }
                }
            }
        }
    }
    private func test() {
    }
}

#Preview {
    HistoryView()
}
