//
//  CoinImageViewModel.swift
//  CryptoApp
//
//  Created by Ismoiljon Xolmatov on 11.03.2024.
//

import Foundation
import SwiftUI
import Combine

class CoinImageViewModel: ObservableObject {
    @Published var image: UIImage? = nil
    @Published var isLoading: Bool = false
    private let imageServise: CoinImageServise
    private var cancellables = Set<AnyCancellable>()
    
    init(coin: CoinModel) {
        self.imageServise = CoinImageServise(coin: coin)
        self.addSubscribtions()
        self.isLoading = true
    }
    
    private func addSubscribtions() {
        imageServise.$image
            .sink { [weak self] _ in
                self?.isLoading = false
            } receiveValue: { [weak self] returnedImage in
                self?.image = returnedImage
            }
            .store(in: &cancellables)
    }
}
