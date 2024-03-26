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
            VStack {
                ChartView(coin: viewModel.coin)
                    .padding(.vertical)
                VStack(alignment: .leading) {
                    gridTitle("Overview")
                    Divider()
                    makeGrid(viewModel.overviewStatistics)
                    gridTitle("Additional Details")
                    Divider()
                    makeGrid(viewModel.additionalStatistics)
                }
                .padding()
            }
        }
        .navigationTitle(viewModel.coin.name)
        .toolbar(content: {
            ToolbarItem(placement: .topBarTrailing) {
                navBarTrailingItems
            }
        })
    }
    
    private func gridTitle(_ title: String) -> some View {
        Text(title)
            .font(.title2)
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

extension CoinDetailView {
    private var navBarTrailingItems: some View {
        HStack {
            Text(viewModel.coin.symbol.uppercased())
                .font(.headline)
                .foregroundStyle(Color.theme.secondaryText)
            CoinImageView(coin: viewModel.coin)
                .frame(width: 25, height: 25)
        }
    }
}

#Preview {
    NavigationStack {
        CoinDetailView(coin: DeveloperPreview.instance.coin)
    }
}
