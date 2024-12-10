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
    var father: Node?
    
    init(attributeName: String, father: Node?) {
        self.attributeName = attributeName
        self.sons = []
        self.father = father
    }
}
