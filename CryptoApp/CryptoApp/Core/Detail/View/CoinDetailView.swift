//
//  CoinDetailView.swift
//  CryptoApp
//
//  Created by Ismoiljon Xolmatov on 23.03.2024.
//

import SwiftUI

struct CoinDetailView: View {
    
    @StateObject var viewModel: CoinDetailViewModel
    private let spacing: CGFloat = 30
    private let columns: [GridItem] = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    
    init(coin: CoinModel) {
        _viewModel = StateObject(wrappedValue: CoinDetailViewModel(coin: coin))
    }
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                Text("")
                    .frame(height: 250)
                gridTitle("Overview")
                Divider()
                makeGrid(viewModel.overviewStatistics)
                gridTitle("Additional Details")
                Divider()
                makeGrid(viewModel.additionalStatistics)
            }
            .padding()
        }
        .navigationTitle(viewModel.coin.name)
    }
    
    private func gridTitle(_ title: String) -> some View {
        Text(title)
            .font(.title)
            .bold()
            .foregroundStyle(Color.theme.accent)
            .frame(maxWidth: .infinity, alignment: .leading)
    }
    
    private func makeGrid(_ array: [StatisticModel]) -> some View {
        LazyVGrid(
            columns: columns,
            alignment: .leading,
            spacing: spacing,
            content: {
                ForEach(array) { stat in
                    StatisticView(stat: stat)
                }
            })
    }
}

#Preview {
    NavigationStack {
        CoinDetailView(coin: DeveloperPreview.instance.coin)
    }
}
