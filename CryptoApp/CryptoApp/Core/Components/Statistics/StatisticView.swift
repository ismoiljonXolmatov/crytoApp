//
//  StatisticView.swift
//  CryptoApp
//
//  Created by Ismoiljon Xolmatov on 18.03.2024.
//

import SwiftUI

struct StatisticView: View {
    
    let stat: StatisticModel
    
    var body: some View {
        VStack(alignment: .leading ,spacing: 6) {
            Text(stat.title)
                .font(.caption)
                .foregroundStyle(Color.secondaryText)
            Text(stat.value)
                .font(.headline)
                .foregroundStyle(Color.theme.accent)
            HStack(spacing: 4) {
                Image(systemName: "triangle.fill")
                    .font(.caption2)
                    .rotationEffect(
                        Angle(degrees: (stat.persentageChange ?? 0) >= 0 ? 0 : 180)
                    )
                Text(stat.persentageChange?.asPercentString() ?? "")
                    .font(.caption)
                    .bold()
            }
            .foregroundStyle((stat.persentageChange ?? 0) >= 0 ? Color.theme.green : Color.theme.red)
            .opacity(stat.persentageChange == nil ? 0 : 1)
         }
    }
}

#Preview {
    Group {
        StatisticView(stat: DeveloperPreview.instance.stat1)
            .previewLayout(.sizeThatFits)
        StatisticView(stat: DeveloperPreview.instance.stat2)
            .previewLayout(.sizeThatFits)
        StatisticView(stat: DeveloperPreview.instance.stat3)
            .previewLayout(.sizeThatFits)
    }
}
