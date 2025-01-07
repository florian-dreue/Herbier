//
//  Item.swift
//  Herbier
//
//  Created by etudiant on 10/12/2024.
//

import Foundation
import SwiftData

@Model
class Item: Identifiable {
    @Attribute(.unique) var id: UUID
    @Attribute(.unique) var name: String
    var creationDate: Date
    var imageData: Data
    
    init(name: String, creationDate: Date = .now, imageData: Data) {
        self.id = UUID()
        self.creationDate = creationDate
        self.name = name
        self.imageData = imageData
    }
}
