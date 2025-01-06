//
//  HistoryView.swift
//  Herbier
//
//  Created by etudiant on 26/12/2024.
//

import SwiftUI
import SwiftData

struct HistoryView: View {
    
    @Environment(\.modelContext) private var modelContext
    @State private var showDetails : Bool = false;
    @State private var temporaryTables: [TemporaryTable] = [];
    @State private var temporaryTableDetails: TemporaryTable? = nil;
    private let dateFormatter: DateFormatter = {
            let formatter = DateFormatter()
            formatter.dateStyle = .medium
            formatter.timeStyle = .none
            return formatter
    }();
    
    var body: some View {
        GeometryReader { geometry in
            if(showDetails) {
                /*DetailView()*/
                VStack() {
                    Image(systemName: "xmark")
                        .onTapGesture {
                            showDetails = false
                        }
                    Image(uiImage: UIImage(data: temporaryTableDetails!.image)!)
                        .resizable()
                        .scaledToFit()
                        .frame(width: geometry.size.width * 0.75, height: geometry.size.height * 0.4)
                        .shadow(radius: 10)
                    Spacer()
                        .frame(height: 20)
                    Text(dateFormatter.string(from: temporaryTableDetails!.timestamp))
                        .frame(width: geometry.size.width * 0.75)
                    Text(temporaryTableDetails!.name)
                    Text(temporaryTableDetails!.type)
                }
            }
            else {
                VStack(alignment: .center) {
                    ScrollView {
                        ForEach (temporaryTables) { table in
                            HStack {
                                Image(uiImage: UIImage(data: table.image)!)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: geometry.size.width * 0.40, height: geometry.size.height * 0.20)
                                Spacer()
                                VStack {
                                    Text(table.name)
                                    Spacer()
                                    Text(dateFormatter.string(from: table.timestamp))
                                }
                                .padding(.vertical, 20.0)
                                Spacer()
                                Text(table.type)
                            }
                            .padding(.horizontal, 20.0)
                            .border(Color.black, width: 1)
                            .onTapGesture {
                                print("HStack cliqué!")
                                showDetails = true;
                                temporaryTableDetails = table;
                            }
                        }
                    }
                }
                .onAppear {
                    fetchTemporaryTables()
                }
            }
        }
    }
    
    // Fonction pour récupérer les données de TemporaryTable
    private func fetchTemporaryTables() {
        Task {
            do {
                print("Recup Data")
                let fetchDescriptor = FetchDescriptor<TemporaryTable>()
                
                let tables: [TemporaryTable] = try modelContext.fetch(fetchDescriptor)
                
                temporaryTables = tables
                print("Final Data ", temporaryTables)
            } catch {
                print("Erreur lors de la récupération des données: \(error)")
            }
        }
    }
}

#Preview {
    HistoryView()
}
