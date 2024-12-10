//
//  Photo.swift
//  Herbier
//
//  Created by etudiant on 10/12/2024.
//

import Foundation
import SwiftData

@Model
final class Photo {
    var name: String
    var timestamp: Date
    //var image: Data
    var format: String
    
    /*init(name: String, timestamp: Date, image: Data, format: String) {
        self.name = name
        self.timestamp = timestamp
        self.image = image
        self.format = format
    }*/
    
    init(name: String, timestamp: Date, format: String) {
        self.name = name
        self.timestamp = timestamp
        self.format = format
    }
}
