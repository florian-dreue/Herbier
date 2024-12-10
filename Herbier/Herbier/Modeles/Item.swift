//
//  Item.swift
//  Herbier
//
//  Created by etudiant on 10/12/2024.
//

import Foundation
import SwiftData

@Model
final class Item {
    var timestamp: Date
    var name: String
    //@Attribute(.externalStorage) var image: Data
    
    init(timestamp: Date, name: String) {
        self.timestamp = timestamp
        self.name = name
    }
}
