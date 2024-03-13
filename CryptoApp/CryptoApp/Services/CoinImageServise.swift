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
    private let fileManager = LocalFileManager.shared
    private let folderName = "coin_images"
    private var imageName: String?
    
    init(coin: CoinModel) {
        self.coin = coin
        self.imageName = coin.id
        getCoinImage()
    }
    
    private func getCoinImage() {
        if let savedImage = fileManager.getImage(imageName: imageName ?? "", folderName: folderName) {
            image = savedImage
        } else {
            downloadCoinImage()
        }
    }
    
    private func downloadCoinImage() {
        guard let url = URL(string: coin.image) else {return}
        imageSubscribtion = NetworkingManager.download(url: url)
            .tryMap({ data -> UIImage? in
                return UIImage(data: data)
            })
            .sink(receiveCompletion: NetworkingManager.handleCompletion,
                  receiveValue: { [weak self] image in
                guard let downloadedImage = image,
                      let self = self else {return}
                self.image = image
                self.imageSubscribtion?.cancel()
                self.fileManager.saveImage(image: downloadedImage,
                                           imageName: imageName ?? "",
                                           folderName: folderName)
            })
    }
}
