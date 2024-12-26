//
//  ContentView.swift
//  Herbier
//
//  Created by etudiant on 10/12/2024.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @Environment(\.modelContext) private var modelContext
    @Query private var items: [Item]
    
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

    private func addItem() {
        withAnimation {
            let newItem = Item(timestamp: Date(), name: "test")
            modelContext.insert(newItem)
        }
    }

    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            for index in offsets {
                modelContext.delete(items[index])
            }
        }
    }
}

#Preview {
    ContentView()
        .modelContainer(for: Item.self, inMemory: true)
}
