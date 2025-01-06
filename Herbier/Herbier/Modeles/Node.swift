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
    @Attribute(.unique) var attributeName: String
    var sons: [Node]?
    var father: Node?
    
    init(attributeName: String, father: Node?, sons: [Node]?) {
        self.attributeName = attributeName
        self.sons = sons
        self.father = father
    }
}
