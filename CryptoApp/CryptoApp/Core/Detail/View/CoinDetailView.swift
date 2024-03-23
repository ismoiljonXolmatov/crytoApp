//
//  CoinDetailView.swift
//  CryptoApp
//
//  Created by Ismoiljon Xolmatov on 23.03.2024.
//

import SwiftUI

struct LoadinfCoinDetailView: View {
    
    @Binding var coin: CoinModel?
    
    var body: some View {
        ZStack {
            if let coin = coin {
                CoinDetailView(coin: coin)
            }
        }
    }
}

struct CoinDetailView: View {
    
    let coin: CoinModel
    
    init(coin: CoinModel) {
        self.coin = coin
        print("Initializing Detail View for \(coin.name)")
    }
    
    var body: some View {
        Text(coin.name)
    }
}

#Preview {
    CoinDetailView(coin: DeveloperPreview.instance.coin)
}
