//
//  TemporaryTable.swift
//  Herbier
//
//  Created by etudiant on 27/12/2024.
//

import Foundation
import SwiftData

@Model
final class Record {
    var timestamp: Date
    var name: String
    @Attribute(.externalStorage) var image: Data
    var type: String
    
    init(timestamp: Date, name: String, image: Data, type: String) {
        self.timestamp = timestamp
        self.name = name
        self.image = image
        self.type = type
    }
}

