//
//  HomeViewModel.swift
//  CryptoApp
//
//  Created by Hasan Abdullah on 08.03.2024.
//

import Foundation
import Combine

class HomeViewModel: ObservableObject {
    
    @Published var statistics: [StatisticModel] =  []
    
    @Published var allCoins: [CoinModel] = []
    @Published var portfolioCoins: [CoinModel] = []
    @Published var searchText: String = ""
    
    private let coinDataService = CoinDataService()
    private let marketDataService = MarketDataService()
    private var cancellables = Set<AnyCancellable>()
    init() {
        addSubscribers()
    }
    
    func addSubscribers() {
        
        //updates all coins
        coinDataService.$allCoins
            .sink { [weak self] returnedCoins in
                self?.allCoins = returnedCoins
            }
            .store(in: &cancellables)
        
        //updates based on search bar's search
        $searchText
            .combineLatest(coinDataService.$allCoins)
            .map(filterCoins)
            .sink { [weak self] returnedCoind in
                self?.allCoins = returnedCoind
            }
            .store(in: &cancellables)
        
        //updates market data
        marketDataService.$marketDataModel
            .map(transferMarketDataToStatModel)
            .sink(receiveValue: { [weak self] statistics in
                self?.statistics = statistics
            })
            .store(in: &cancellables)
        
    }
    
    private func filterCoins(text: String, coins: [CoinModel]) -> [CoinModel] {
        guard !text.isEmpty else { return coins }
        let lowercasedText = text.lowercased()
        return coins.filter { coin in
            return coin.name.lowercased().contains(lowercasedText) ||
            coin.symbol.lowercased().contains(lowercasedText) ||
            coin.id.lowercased().contains(lowercasedText)
        }
    }
    
    private func transferMarketDataToStatModel(marketData: MarketDataModel?) -> [StatisticModel] {
        var stats: [StatisticModel] = []
        guard let data = marketData else { return stats }
        let marketCap = StatisticModel(title: "Market Cap", value: data.marketCap, persentageChange: data.marketCapPercentageChange24HUsd)
        let volume = StatisticModel(title: "Total Volume", value: data.volume)
        let btcDominance = StatisticModel(title: "BTC Dominance", value: data.btcDominance)
        let portfolio = StatisticModel(title: "Portfoio Value", value: "$0.000", persentageChange: 0.000)
        stats.append(contentsOf: [marketCap, volume, btcDominance, portfolio])
        return stats
    }
}
