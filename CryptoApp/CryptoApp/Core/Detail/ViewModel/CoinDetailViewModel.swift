//
//  CoinDetailViewModel.swift
//  CryptoApp
//
//  Created by Ismoiljon Xolmatov on 25.03.2024.
//

import SwiftUI
import Combine

class CoinDetailViewModel: ObservableObject {
    
    @Published var coinDetails: CoinDetailModel? = nil
    @Published var overviewStatistics: [StatisticModel] = []
    @Published var additionalStatistics: [StatisticModel] = []
    @Published var coin: CoinModel
    private let coinDetailService: CoinDetaildataService
    private var cancellables = Set<AnyCancellable>()
    
    init(coin: CoinModel) {
        self.coin = coin
        self.coinDetailService = CoinDetaildataService(coin: coin)
        addSubscribers()
    }
    
    private func addSubscribers() {
        coinDetailService.$coinDetails
            .combineLatest($coin)
            .map(mapCoinModelsIntoStatisticArray)
            .sink { [weak self] arrays in
                self?.overviewStatistics = arrays.overiew
                self?.additionalStatistics = arrays.additional
            }
            .store(in: &cancellables)
    }
    
    private func mapCoinModelsIntoStatisticArray(coinDetailModel: CoinDetailModel?, coinModel: CoinModel) -> (overiew: [StatisticModel], additional: [StatisticModel]) {
        let overviewArray = makeOverviewArray(coinModel: coinModel)
        let additionalArray = makeAdditionalDetailArray(coinModel: coinModel, coinDetailModel: coinDetailModel)
        return (overviewArray, additionalArray)
    }
    
    private func makeOverviewArray(coinModel: CoinModel) -> [StatisticModel] {
        // overView
        let price = coinModel.currentPrice.asCurrencyWth6Decimals()
        let pricePercentageChange = coinModel.priceChangePercentage24H
        let priceStat = StatisticModel(title: "Current Price", value: price, persentageChange: pricePercentageChange)
        
        let marketCap = "$" + (coinModel.marketCap?.formattedWithAbbreviations() ?? "")
        let marketCapPercentageChange = coinModel.marketCapChangePercentage24H
        let marketStat = StatisticModel(title: "Market Capitalization", value: marketCap, persentageChange: marketCapPercentageChange)
        
        let rank = "\(coinModel.rank)"
        let rankStat = StatisticModel(title: "Rank", value: rank)
        
        let volume = "$" + (coinModel.totalVolume?.formattedWithAbbreviations() ?? "")
        let volumeStat = StatisticModel(title: "Total Volume", value: volume)
        
        return [priceStat, marketStat, rankStat, volumeStat]
    }
    
    private func makeAdditionalDetailArray(coinModel: CoinModel, coinDetailModel: CoinDetailModel?) -> [StatisticModel] {
        // additional
        let high = coinModel.high24H?.asCurrencyWth6Decimals() ?? "n/a"
        let highStat = StatisticModel(title: "24h High", value: high)
        
        let low = coinModel.low24H?.asCurrencyWth6Decimals() ?? "n/2"
        let lowStat = StatisticModel(title: "24h Low", value: low)
        
        let priceChange = (coinModel.priceChange24H?.asCurrencyWth6Decimals() ?? "")
        let priceChangePercentage2 = coinModel.priceChangePercentage24H
        let priceChangeStat = StatisticModel(title: "24h Price Change", value: priceChange, persentageChange: priceChangePercentage2)
        
        let marketCapChange = "$" + (coinModel.marketCapChange24H?.formattedWithAbbreviations() ?? "")
        let marketCapPercentageChange2 = coinModel.marketCapChangePercentage24H
        let marketCapChangeStat = StatisticModel(title: "24h Market Cap Change", value: marketCapChange, persentageChange: marketCapPercentageChange2)
        
        let blockTime = coinDetailModel?.blockTimeInMinutes ?? 0
        let blocktimeString = blockTime == 0 ? "n/a" : "\(blockTime)"
        let blockStat = StatisticModel(title: "Block Time", value: blocktimeString)
        
        let hashing = coinDetailModel?.hashingAlgorithm ?? "n/a"
        let hasingStat = StatisticModel(title: "Hashing Algorithm", value: hashing)
        
        return [highStat, lowStat, priceChangeStat, marketCapChangeStat, blockStat, hasingStat]
    }
}
