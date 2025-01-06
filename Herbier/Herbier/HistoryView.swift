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
    @State private var fetchedRecord: [Record] = [];
    @State private var recordDetails: Record? = nil;
    private let dateFormatter: DateFormatter = {
            let formatter = DateFormatter()
            formatter.dateStyle = .medium
            formatter.timeStyle = .none
            return formatter
    }();
    
    var body: some View {
        GeometryReader { geometry in
            if(showDetails) {
                VStack() {
                    Image(systemName: "xmark")
                        .onTapGesture {
                            showDetails = false;
                            recordDetails = nil;
                        }
                    Image(uiImage: UIImage(data: recordDetails!.image)!)
                        .resizable()
                        .scaledToFit()
                        .frame(width: geometry.size.width * 0.75, height: geometry.size.height * 0.4)
                        .shadow(radius: 10)
                    Spacer()
                        .frame(height: 20)
                    Text("Photo prise le: \(dateFormatter.string(from: recordDetails!.timestamp))")
                        .frame(width: geometry.size.width * 0.75)
                    Text(recordDetails!.name)
                    Text(recordDetails!.type)
                }
                .frame(width: geometry.size.width)
            }
            else {
                VStack(alignment: .center) {
                    ScrollView {
                        ForEach (fetchedRecord) { table in
                            HStack {
                                Image(uiImage: UIImage(data: table.image)!)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: geometry.size.width * 0.40, height:
                                            geometry.size.width < geometry.size.height ? geometry.size.height * 0.15 : geometry.size.height * 0.30)
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
                                showDetails = true;
                                recordDetails = table;
                            }
                        }
                    }
                }
                .onAppear {
                    //A la génération on récupère le contenu
                    fetchTemporaryTables()
                }
            }
        }
    }
    
    // Fonction pour récupérer les données de Record
    private func fetchTemporaryTables() {
        Task {
            do {
                print("Recup Data")
                var fetchDescriptor = FetchDescriptor<Record>()
                
                let sortDescriptor = SortDescriptor<Record>(\.timestamp)
                
                fetchDescriptor.sortBy = [sortDescriptor]
                
                let tables: [Record] = try modelContext.fetch(fetchDescriptor)
                
                fetchedRecord = tables
                print("Final Data ", fetchedRecord)
            } catch {
                print("Erreur lors de la récupération des données: \(error)")
            }
        }
    }
}

#Preview {
    HistoryView()
}
