//
//  HerbierApp.swift
//  Herbier
//
//  Created by etudiant on 10/12/2024.
//

import SwiftUI
import SwiftData

@main
struct HerbierApp: App {
    var sharedModelContainer: ModelContainer = {
        let schema = Schema([
            Item.self,
            Node.self,
            TemporaryTable.self
        ])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)

        do {
            return try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()

    var body: some Scene {
        WindowGroup {
            ContentView(itemController: ItemController(modelContext: ModelContext(sharedModelContainer)), nodeController: NodeController(modelContext: ModelContext(sharedModelContainer)))
        }
        .modelContainer(sharedModelContainer)
    }
}
