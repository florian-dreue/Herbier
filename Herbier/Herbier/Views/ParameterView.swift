//
//  ParameterView.swift
//  Herbier
//
//  Created by etudiant on 26/12/2024.
//

import SwiftUI
import Photos

struct ParameterView: View {
    @State private var LibrairyAcces: Bool = false
    
    var body: some View {
        GeometryReader { screen in
            VStack {
                Text("Paramètres")
                Spacer()
                    .frame(height: screen.size.height * 0.2)
                //Switch button pour l'autorisation d'accès à la galerie photo
                Toggle("Autoriser l'accès à la galerie",isOn: $LibrairyAcces)
                    .onChange(of: LibrairyAcces) { newValue in
                        if newValue {
                            requestPhotoLibraryAccess()
                        }
                        else {
                            LibrairyAcces = false
                        }
                    }
            }
            .onAppear {
                checkAccess()
            }
        }
        
    }
    
    //Check l'autorisation actuelle
    private func checkAccess() {
        let status = PHPhotoLibrary.authorizationStatus(for: .readWrite)
        print("AccesActuel: \(status)")
        switch status {
            case .authorized, .limited:
            LibrairyAcces = true
            case .denied, .restricted, .notDetermined:
            LibrairyAcces = false
            @unknown default:
            LibrairyAcces = false
        }
    }
    
    //Demande l'accès à la galerie
    private func requestPhotoLibraryAccess() {
        PHPhotoLibrary.requestAuthorization { status in
            DispatchQueue.main.async {
                switch status {
                case .authorized, .limited:
                    //L'utilisateur autorise ou limite l'accès
                    LibrairyAcces = true
                case .denied, .restricted:
                    //L'utilisateur refuse
                    LibrairyAcces = false
                case .notDetermined:
                    // L'utilisateur n'a pas encore répondu
                    LibrairyAcces = false
                @unknown default:
                    LibrairyAcces = false
                }
            }
        }
    }
}

#Preview {
    ParameterView()
}
