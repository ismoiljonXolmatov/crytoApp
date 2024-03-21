//
//  MarketDataService.swift
//  CryptoApp
//
//  Created by Ismoiljon Xolmatov on 19.03.2024.
//

import SwiftUI
import Combine

class MarketDataService {
    @Published var marketDataModel: MarketDataModel? = nil
    var marketDataSubscription: AnyCancellable?
    
    init () {
        getData()
    }
    
    func getData() {
        guard let url = URL(string: "https://api.coingecko.com/api/v3/global") else {return}
        marketDataSubscription = NetworkingManager.download(url: url)
            .decode(type: GlobalData.self, decoder: JSONDecoder())
            .sink(receiveCompletion: NetworkingManager.handleCompletion, receiveValue: { [weak self] returnedData in
                self?.marketDataModel = returnedData.data
                self?.marketDataSubscription?.cancel()
            })

    }
}
