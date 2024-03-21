//
//  HapticManager.swift
//  CryptoApp
//
//  Created by Ismoiljon Xolmatov on 21.03.2024.
//

import SwiftUI

class HapticManager {
    
   private static let generator = UINotificationFeedbackGenerator()
    
    static func notification(type: UINotificationFeedbackGenerator.FeedbackType) {
        generator.notificationOccurred(type)
    }
}
