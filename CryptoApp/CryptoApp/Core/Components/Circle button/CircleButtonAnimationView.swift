//
//  CircleButtonAnimationView.swift
//  CryptoApp
//
//  Created by Hasan Abdullah on 05.03.2024.
//

import SwiftUI

struct CircleButtonAnimationView: View {
    @Binding var animate: Bool
    var body: some View {
            Circle()
            .stroke(lineWidth: 5.0)
            .scale(animate ? 1.0 : 0.0)
            .opacity(animate ? 0.0 : 1)
            .animation(animate ? .easeIn(duration: 1) : .none)
    }
}

#Preview {
    CircleButtonAnimationView(animate: .constant(false))
        .frame(width: 100, height: 100)
        .foregroundStyle(Color.theme.red)
}
