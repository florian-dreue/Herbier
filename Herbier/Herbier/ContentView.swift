//
//  ContentView.swift
//  Herbier
//
//  Created by etudiant on 10/12/2024.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @State private var selectedTab = 1
    
    var body: some View {
        VStack() {
            Text("Herbier")
            Spacer()
                .frame(height: 30)
            TabView (selection: $selectedTab) {
                ParameterView()
                    .tabItem {
                        Image(systemName: "gearshape.fill")
                    }
                    .tag(0)
                AddPictureView()
                    .tabItem {
                        Image(systemName: "house.fill")
                    }
                    .tag(1)
                HistoryView()
                    .tabItem {
                        Image(systemName: "clock.fill")
                    }
                    .tag(2)
            }
        }
        .padding(.horizontal, 30.0)
    }
}

#Preview {
    ContentView()
        .modelContainer(for: Item.self, inMemory: true)
}
