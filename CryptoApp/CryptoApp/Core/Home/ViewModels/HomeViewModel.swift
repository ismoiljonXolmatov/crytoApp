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
    @Published var isReloading: Bool = false
    
    private let coinDataService = CoinDataService()
    private let marketDataService = MarketDataService()
    private let portfolioDataService = PortfolioDataService()
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        addSubscribers()
    }
    
    func updatePortfolio(coin: CoinModel, amount: Double) {
        portfolioDataService.updatePortfolio(coin: coin, amount: amount)
    }
    
    func reloadData() {
        isReloading = true
        HapticManager.notification(type: .success)
        coinDataService.getCoins()
        marketDataService.getData()
    }
    
    // MARK: Private
    private func addSubscribers() {
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
            .combineLatest($portfolioCoins)
            .map(transferMarketDataToStatModel)
            .sink(receiveValue: { [weak self] statistics in
                self?.statistics = statistics
            })
            .store(in: &cancellables)
        
        // updates portfolio
        $allCoins
            .combineLatest(portfolioDataService.$savedEntities)
            .map(mapAllCoinsToPortfolioCoins)
            .sink { [weak self] returnedCoins in
                self?.portfolioCoins = returnedCoins
                self?.isReloading = false
            }
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
    
    private func mapAllCoinsToPortfolioCoins(allCoins: [CoinModel], savedEntities: [PortfolioItem]) -> [CoinModel] {
        allCoins.compactMap { coin in
            guard let entity = savedEntities.first(where: { $0.coinID == coin.id}) else {
                return nil
            }
            return coin.updateHoldings(amount: entity.holdingAmount)
        }
    }
    
    private func transferMarketDataToStatModel(marketData: MarketDataModel?, portfolioCoins: [CoinModel]) -> [StatisticModel] {
        var stats: [StatisticModel] = []
        guard let data = marketData else { return stats }
        let marketCap = StatisticModel(title: "Market Cap", value: data.marketCap, persentageChange: data.marketCapPercentageChange24HUsd)
        let volume = StatisticModel(title: "Total Volume", value: data.volume)
        let btcDominance = StatisticModel(title: "BTC Dominance", value: data.btcDominance)
        let portfolioValue = portfolioCoins
            .map({$0.currentHoldingsValue})
            .reduce(0, +)
        let previousValue = portfolioCoins
                .map { coin -> Double in
                    let currentValue = coin.currentHoldingsValue
                    let precentChange = coin.priceChangePercentage24H ?? 0 * 100
                    return  currentValue / (1 + precentChange)
                }
                .reduce(0, +)
        let precentageChange = ((portfolioValue - previousValue) / previousValue)
        let portfolio = StatisticModel(
            title: "Portfoio Value",
            value:  "$" + portfolioValue.formattedWithAbbreviations(),
            persentageChange: precentageChange)
        stats.append(contentsOf: [marketCap, volume, btcDominance, portfolio])
        return stats
    }
}
