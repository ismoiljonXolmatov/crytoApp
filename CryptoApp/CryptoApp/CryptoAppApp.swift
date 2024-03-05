//
//  CryptoAppApp.swift
//  CryptoApp
//
//  Created by Hasan Abdullah on 04.03.2024.
//

import SwiftUI

@main
struct CryptoAppApp: App {
    var body: some Scene {
        WindowGroup {
            NavigationStack {
                ContentView()
                    .toolbar(.hidden, for: .navigationBar)
            }

        }
    }
}
