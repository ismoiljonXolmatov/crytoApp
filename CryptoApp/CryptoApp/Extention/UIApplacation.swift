//
//  UIApplacation.swift
//  CryptoApp
//
//  Created by Ismoiljon Xolmatov on 13.03.2024.
//

import SwiftUI

extension UIApplication {
    func endEtiting() {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
