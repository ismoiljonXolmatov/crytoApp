//
//  Color.swift
//  CryptoApp
//
//  Created by Hasan Abdullah on 05.03.2024.
//

import SwiftUI

extension Color {
   static let theme = ColorTheme()
    static let launch = LaunchTheme()
}

struct ColorTheme {
    let accent = Color("AccentColor")
    let background = Color("BackgroundColor")
    let green = Color("Green")
    let red = Color("Red")
    let secondaryText = Color("SecondaryTextColor")
}

struct LaunchTheme {
    let accent = Color("LaunchAccentColor")
    let background = Color("LaunchBackgroundColor")
}
