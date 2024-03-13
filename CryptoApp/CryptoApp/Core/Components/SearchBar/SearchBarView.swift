//
//  SearchBarView.swift
//  CryptoApp
//
//  Created by Ismoiljon Xolmatov on 13.03.2024.
//

import SwiftUI

struct SearchBarView: View {
    @Binding var searchText: String
    var body: some View {
        HStack {
            Image(systemName: "magnifyingglass")
                .foregroundStyle(
                    searchText.isEmpty ?
                    Color.theme.secondaryText : Color.theme.accent
                )
            TextField("Search by name or symbol...", text: $searchText)
                .foregroundStyle(Color.theme.accent)
                .autocorrectionDisabled()
                .overlay(
                    Image(systemName: "xmark.app.fill")
                        .padding()
                        .offset(x: 10)
                        .foregroundStyle(Color.theme.accent)
                        .opacity(searchText.isEmpty ? 0 : 1)
                        .onTapGesture {
                            UIApplication.shared.endEtiting()
                            searchText = ""
                        }
                    , alignment: .trailing
                )
        }
        .font(.headline)
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 20)
                .fill(Color.theme.background)
                .shadow(color: Color.theme.accent.opacity(0.15),
                        radius: 10,
                        x: 0,
                        y: 0
                       )
        )
        .padding()
    }
}

#Preview {
    SearchBarView(searchText: .constant(""))
}
