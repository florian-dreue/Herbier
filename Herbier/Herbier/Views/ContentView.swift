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
    var itemController: ItemController
    var nodeController: NodeController
    
    var body: some View {
        VStack() {
            Text("Herbier") //Titre de l'application
            Spacer() //Espace entre le titre et la BottomBar
            TabView (selection: $selectedTab) { //BottomBar
                GraphView(nodeController: nodeController)
                    .tabItem {
                        Image(systemName: "gearshape.fill")
                    }
                    .tag(0) //Premiere page pour les parametres
                AddItemView(itemsController: self.itemController)
                    .tabItem {
                        Image(systemName: "house.fill")
                    }
                    .tag(1) //Deuxieme page pour l'ajout d'enregistrement
                HistoryListView()
                    .tabItem {
                        Image(systemName: "clock.fill")
                    }
                    .tag(2) //Troisieme page pour l'historique
            }
        }
        .padding(.horizontal, 30.0)
    }
}
