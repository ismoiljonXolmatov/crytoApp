//
//  CircleButtonView.swift
//  CryptoApp
//
//  Created by Hasan Abdullah on 05.03.2024.
//

import SwiftUI

struct CircleButtonView: View {
    
    let iconName: String
    
    var body: some View {
        Image(systemName: iconName)
            .foregroundStyle(Color.theme.accent)
            .font(.headline)
            .frame(width: 50, height: 50)
            .background(
            Circle().foregroundStyle(Color.theme.background)
            )
            .shadow(color: .theme.accent.opacity(0.25), radius: 10, x: 0, y: 0)
            .padding()
    }
}

#Preview {
    Group {
        CircleButtonView(iconName: "info")
        
        CircleButtonView(iconName: "plus")
            .colorScheme(.dark)
    }
}
