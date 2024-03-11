//
//  CoinRowView.swift
//  CryptoApp
//
//  Created by Hasan Abdullah on 08.03.2024.
//

import SwiftUI

struct CoinRowView: View {
    let coin: CoinModel
    @State var showHoldingColumn: Bool = true
    var body: some View {
        HStack(spacing: 0) {
            leftColumn
            Spacer()
            if showHoldingColumn {
                centerCoulmn
            }
            rightCoulmn
        }
    }
}

#Preview {
    Group {
        CoinRowView(coin: DeveloperPreview.instance.coin, showHoldingColumn: true)
            .previewLayout(.sizeThatFits)
        
        CoinRowView(coin: DeveloperPreview.instance.coin, showHoldingColumn: true)
            .previewLayout(.sizeThatFits)
            .colorScheme(.dark)
    }
}
 
extension CoinRowView {
    private var leftColumn: some View {
        HStack {
            Text("\(coin.rank)")
                .font(.caption)
                .foregroundStyle(Color.theme.secondaryText)
                .frame(minWidth: 30)
            CoinImageView(coin: coin)
                 .frame(maxWidth: 30, maxHeight: 30)
            Text(coin.symbol.uppercased())
                .font(.headline)
                .padding(.leading, 6)
                .foregroundStyle(Color.theme.accent)
        }
    }
    
    private var centerCoulmn: some View {
        VStack(alignment: .trailing, content: {
            Text(coin.currentHoldingsValue.asCurrencyWth2Decimals())
                .bold()
            Text(coin.currentHoldings?.asNumberString() ?? "")
        })
        .foregroundStyle(Color.theme.accent)
    }
    
    private var rightCoulmn: some View {
        VStack(alignment: .trailing, content: {
            Text(coin.currentPrice.asCurrencyWth2Decimals())
                .bold()
                .foregroundStyle(Color.theme.accent)
            Text(coin.priceChangePercentage24H?.asPercentString() ?? "")
                .foregroundStyle(
                    (coin.priceChangePercentage24H ?? 0) >= 0 ?
                    Color.theme.green :  Color.theme.red
                )
            
        })
        .frame(width: UIScreen.main.bounds.width / 3.5, alignment: .trailing)
        
    }
}
