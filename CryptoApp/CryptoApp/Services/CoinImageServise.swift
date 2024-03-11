//
//  CoinImageServise.swift
//  CryptoApp
//
//  Created by Ismoiljon Xolmatov on 11.03.2024.
//

import Foundation
import SwiftUI
import Combine

class CoinImageServise {
    @Published var image: UIImage? = nil
    var imageSubscribtion: AnyCancellable?
    private let coin: CoinModel
    
    init(coin: CoinModel) {
        self.coin = coin
        getCoinImage()
    }
    
    private func getCoinImage() {
        guard let url = URL(string: coin.image) else {return}
        imageSubscribtion = NetworkingManager.download(url: url)
            .tryMap({ data -> UIImage? in
                return UIImage(data: data)
            })
            .sink(receiveCompletion: NetworkingManager.handleCompletion,
                  receiveValue: { [weak self] image in
                self?.image = image
            })
    }
}
