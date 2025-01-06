//
//  Item.swift
//  Herbier
//
//  Created by etudiant on 10/12/2024.
//

import Foundation
import SwiftUI
import SwiftData

@Model
public final class Item {
    @Attribute(.unique) var name: String
    var creationDate: Date
    var imageData: Data
    
    init(name: String, creationDate: Date = .now, imageData: Data) {
        self.creationDate = creationDate
        self.name = name
        self.imageData = imageData
    }
}
