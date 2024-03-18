//
//  StatisticModel.swift
//  CryptoApp
//
//  Created by Ismoiljon Xolmatov on 18.03.2024.
//

import SwiftUI

struct StatisticModel: Identifiable {
    let id = UUID().uuidString
    let title: String
    let value: String
    let persentageChange: Double?
    
    init(title: String, value: String, persentageChange: Double? = nil) {
        self.title = title
        self.value = value
        self.persentageChange = persentageChange
    }
}
