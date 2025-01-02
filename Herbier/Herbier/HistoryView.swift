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
    @State private var temporaryTables: [TemporaryTable] = []
    
    var body: some View {
        GeometryReader { geometry in
            if(showDetails) {
                /*DetailView()*/
                VStack() {
                    Image(systemName: "xmark")
                        .onTapGesture {
                            showDetails = false
                        }
                    Image("PhotoTest")
                        .resizable()
                        .scaledToFit()
                        .frame(width: geometry.size.width * 0.75, height: geometry.size.height * 0.4)
                        .shadow(radius: 10)
                    Spacer()
                        .frame(height: 20)
                    Text("Date de la photo")
                        .frame(width: geometry.size.width * 0.75)
                    Text("Nom de la photo")
                    Text("Type de la photo")
                }
            }
            else {
                VStack(alignment: .center) {
                    ScrollView {
                        ForEach (0..<10) { table in
                            HStack {
                                Image("PhotoTest")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: geometry.size.width * 0.40, height: geometry.size.height * 0.20)
                                Spacer()
                                VStack {
                                    Text("Nom de la photo")
                                    Spacer()
                                    Text("Date")
                                }
                                .padding(.vertical, 20.0)
                                Spacer()
                                Text("Type")
                            }
                            .padding(.horizontal, 20.0)
                            .border(Color.black, width: 1)
                            .onTapGesture {
                                print("HStack cliqué!")
                                showDetails = true
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
