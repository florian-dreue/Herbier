//
//  HistoryView.swift
//  Herbier
//
//  Created by } on 26/12/2024.
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
        NavigationView {
            ScrollView() {
                ForEach (items) { item in
                    NavigationLink(destination: DetailView(item: item)) {
                        ListItem(item: item)
                    }
                }
            }
        }
    }
}
