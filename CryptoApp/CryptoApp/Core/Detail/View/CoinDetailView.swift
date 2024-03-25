//
//  CoinDetailView.swift
//  CryptoApp
//
//  Created by Ismoiljon Xolmatov on 23.03.2024.
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


struct CoinDetailView: View {
    
    @StateObject var viewModel: CoinDetailViewModel
    
    init(coin: CoinModel) {
        _viewModel = StateObject(wrappedValue: CoinDetailViewModel(coin: coin))
    }
    
    var body: some View {
        Text("Hello there")
    }
}

#Preview {
    CoinDetailView(coin: DeveloperPreview.instance.coin)
}
