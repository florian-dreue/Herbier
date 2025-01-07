//
//  DatabaseService.swift
//  Herbier
//
//  Created by Fréééédéric on 07/01/2025.
//

import SwiftData

class DatabaseService {
    private let modelContext: ModelContext
    
    init(modelContext: ModelContext) {
        self.modelContext = modelContext
    }
    
    public func getModelContext() -> ModelContext {
        return self.modelContext
    }
}
