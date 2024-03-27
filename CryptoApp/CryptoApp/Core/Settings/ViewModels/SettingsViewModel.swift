//
//  SettingsViewModel.swift
//  CryptoApp
//
//  Created by Ismoiljon Xolmatov on 27.03.2024.
//

import Foundation

class SettingsViewModel: ObservableObject {
    var googleUrl: URL? = nil
    var githubUrl: URL? = nil
    var linkedInUrl: URL? = nil
    var coinGeckoUrl: URL? = nil
    var coinGeckoFreeAPI: URL? = nil
    var swiftfullThinkingUrl: URL? = nil
    var telegramUrl: URL? = nil
    var emailUrl: URL? = nil
    
    init() {
        setUrls()
    }
    
    private func setUrls() {
        guard let googleUrl = URL(string: "https://google.com") else {return}
        self.googleUrl = googleUrl
        githubUrl  = URL(string: "https://github.com/ismoiljonXolmatov") ?? googleUrl
        linkedInUrl = URL(string: "https://www.linkedin.com/in/ismoil-xolmatov-4442a8271/") ?? googleUrl
        coinGeckoUrl = URL(string: "https://www.coingecko.com/") ?? googleUrl
        swiftfullThinkingUrl = URL(string: "https://www.youtube.com/playlist?list=PLwvDm4Vfkdphbc3bgy_LpLRQ9DDfFGcF") ?? googleUrl
        telegramUrl = URL(string: "https://t.me/ismoil_xolmatov") ?? googleUrl
        emailUrl = URL(string: "https://mail.google.com/mail/u/0/?fs=1&to=ismoiljonxolmatov637@gmail.com&tf=cm") ?? googleUrl
        coinGeckoFreeAPI = URL(string: "https://www.coingecko.com/api/documentation") ?? googleUrl
    }
    
}
