//
//  HomeViewModel.swift
//  CryptoApp
//
//  Created by Hasan Abdullah on 08.03.2024.
//

import Foundation
import Combine

class HomeViewModel: ObservableObject {
    @Published var statistics: [StatisticModel] =  [
        StatisticModel(title: "Market Cup", value: "$12.5Bn", persentageChange: 12.65),
        StatisticModel(title: "Total Volume", value: "$1.43Tr"),
        StatisticModel(title: "Weekly revenue", value: "$439.6k", persentageChange: -11.98),
        StatisticModel(title: "Mounth", value: "$2.43Tr")
    ]
    @Published var allCoins: [CoinModel] = []
    @Published var portfolioCoins: [CoinModel] = []
    @Published var searchText: String = ""
    private let dataService = CoinDataService()
    private var cancellables = Set<AnyCancellable>()
    init() {
        addSubscribers()
    }
    
    func addSubscribers() {
        dataService.$allCoins
            .sink { [weak self] returnedCoins in
                self?.allCoins = returnedCoins
            }
            .store(in: &cancellables)
        
        $searchText
            .combineLatest(dataService.$allCoins)
            .map(filterCoins)
            .sink { [weak self] returnedCoind in
                self?.allCoins = returnedCoind
            }
            .store(in: &cancellables)
    }
    
    func filterCoins(text: String, coins: [CoinModel]) -> [CoinModel] {
        guard !text.isEmpty else { return coins }
        let lowercasedText = text.lowercased()
        return coins.filter { coin in
            return coin.name.lowercased().contains(lowercasedText) ||
            coin.symbol.lowercased().contains(lowercasedText) ||
            coin.id.lowercased().contains(lowercasedText)
        }
    }
    
    
}
