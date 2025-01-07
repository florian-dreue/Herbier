//
//  HistoryView.swift
//  Herbier
//
//  Created by etudiant on 26/12/2024.
//

import SwiftUI
import SwiftData

struct HistoryListView: View {
    @Query(sort: \Item.creationDate, order: .reverse) private var items: [Item]
    
    private let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .none
        return formatter
    }();
    
    var body: some View {
        VStack() {
            ScrollView() {
                ForEach (items) { item in
                    ListItem(item: item)
                }
            }
        }
    }
}
