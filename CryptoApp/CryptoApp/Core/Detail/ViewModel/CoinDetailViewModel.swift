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
    private let coinDetailService: CoinDetaildataService
    private var cancellables = Set<AnyCancellable>()
    
    init(coin: CoinModel) {
        self.coinDetailService = CoinDetaildataService(coin: coin)
        addSubscribers()
    }
    
    private func addSubscribers() {
        coinDetailService.$coinDetails
            .sink { [weak self] returnedCoinDetais in
                self?.coinDetails = returnedCoinDetais
                print("COIN DETAIL DOWNLOADED")
                print("\(returnedCoinDetais)")
            }
            .store(in: &cancellables)
    }
}
