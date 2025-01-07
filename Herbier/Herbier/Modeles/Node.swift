//
//  Node.swift
//  Herbier
//
//  Created by etudiant on 10/12/2024.
//

import Foundation
import SwiftData

@Model
class Node: Identifiable {
    @Attribute(.unique) var id: UUID
    @Attribute(.unique) var attributeName: String
    var questionForSons: String
    var sons: [Node]
    var father: Node?
    
    init(attributeName: String, questionForSons: String, father: Node?, sons: [Node]?) {
        self.id = UUID()
        self.attributeName = attributeName
        self.questionForSons = questionForSons
        self.father = father
        self.sons = []
        if (sons != nil) {
            self.sons = sons!
        }
    }
}
