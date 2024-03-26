//
//  LoadingCoinDetailView.swift
//  CryptoApp
//
//  Created by Ismoiljon Xolmatov on 25.03.2024.
//

import SwiftUI


struct LoadingCoinDetailView: View {
    @Binding var coin: CoinModel?
    var body: some View {
        ZStack {
            if let coin = coin {
                CoinDetailView(coin: coin)
            }
        }
    }
}
