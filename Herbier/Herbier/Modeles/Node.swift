//
//  Node.swift
//  Herbier
//
//  Created by etudiant on 10/12/2024.
//

import Foundation
import SwiftData

@Model
final class Node {
    var attributeName: String
    var sons: [Node]
    
    init(attributeName: String) {
        self.attributeName = attributeName
        self.sons = []
    }
}
