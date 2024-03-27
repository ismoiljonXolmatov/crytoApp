//
//  CoinDetailView.swift
//  CryptoApp
//
//  Created by Ismoiljon Xolmatov on 23.03.2024.
//

import SwiftUI

struct CoinDetailView: View {
    
    @StateObject var viewModel: CoinDetailViewModel
    @State var showFullDescription: Bool = false
    
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
            if viewModel.additionalStatistics.isEmpty,
               viewModel.overviewStatistics.isEmpty {
                ProgressView {
                    Text("Details are loading...")
                }
            } else {
                VStack {
                    ChartView(coin: viewModel.coin)
                        .padding(.vertical)
                    VStack(alignment: .leading) {
                        gridTitle("Overview")
                        Divider()
                        descriptionSection
                        makeGrid(viewModel.overviewStatistics)
                        gridTitle("Additional Details")
                        Divider()
                        makeGrid(viewModel.additionalStatistics)
                        websiteSection
                    }
                    .padding()
                }
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
    
    private var descriptionSection: some View {
        ZStack {
            if let description = viewModel.description, !description.isEmpty {
                VStackLayout(alignment: .leading) {
                    Text(description)
                        .animation(showFullDescription ? Animation.easeInOut : .none, value: showFullDescription)
                        .lineLimit(showFullDescription ? nil : 3)
                        .font(.callout)
                        .foregroundStyle(Color.theme.secondaryText)
                    Button {
                        showFullDescription.toggle()
                    } label: {
                        Text(showFullDescription ? "Less" : "Read more")
                            .font(.caption)
                            .fontWeight(.medium)
                            .padding(.vertical, 3)
                    }
                    .tint(.blue)
                    
                }
                .frame(maxWidth: .infinity, alignment: .leading)
            }
        }
    }
    
    private var websiteSection: some View {
        HStack(alignment: .center, spacing: 20) {
            if let websiteUrlString = viewModel.websiteUrl,
               let url = URL(string: websiteUrlString) {
                Link(destination: url, label: {
                    HStack {
                        Text("Website")
                            .tint(.blue)
                        Image(systemName: "globe")
                            .frame(width: 20, height: 20)
                    }
                })
            }
            
            if let websiteUrlString = viewModel.websiteUrl,
               let url = URL(string: websiteUrlString) {
                Link(destination: url, label: {
                    HStack {
                        Text("Rettid")
                            .tint(.blue)
                        Image("rettidIcon")
                            .resizable()
                            .frame(width: 20, height: 20)
                    }
                })
            }
        }
        .font(.headline)
        .padding()
    }
}

#Preview {
    NavigationStack {
        CoinDetailView(coin: DeveloperPreview.instance.coin)
    }
}
