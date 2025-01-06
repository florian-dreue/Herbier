//
//  ContentView.swift
//  Herbier
//
//  Created by etudiant on 10/12/2024.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @State private var selectedTab = 1 //Page sélectionnée
    
    var body: some View {
        VStack() {
            Text("Herbier") //Titre de l'application
            Spacer() //Espace entre le titre et la BottomBar
            TabView (selection: $selectedTab) { //BottomBar
                ParameterView()
                    .tabItem {
                        Image(systemName: "gearshape.fill")
                    }
                    .tag(0) //Premiere page pour les parametres
                AddPictureView()
                    .tabItem {
                        Image(systemName: "house.fill")
                    }
                    .tag(1) //Deuxieme page pour l'ajout d'enregistrement
                HistoryView()
                    .tabItem {
                        Image(systemName: "clock.fill")
                    }
                    .tag(2) //Troisieme page pour l'historique
            }
        }
        .padding(.horizontal, 30.0)
    }
}

#Preview {
    ContentView()
}
