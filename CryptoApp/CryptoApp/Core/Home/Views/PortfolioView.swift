//
//  PortfolioView.swift
//  CryptoApp
//
//  Created by Ismoiljon Xolmatov on 19.03.2024.
//

import SwiftUI

struct PortfolioView: View {
    
    @EnvironmentObject var homeViewModel: HomeViewModel
    @State private var selectedCoin: CoinModel? = nil
    @State private var quentityText: String = ""
    @State private var showCheckmark: Bool = false
    
    var body: some View {
        NavigationStack{
            ScrollView {
                VStack(alignment: .leading, spacing: 0) {
                    SearchBarView(searchText: $homeViewModel.searchText)
                    coinLogoList
                    if selectedCoin != nil {
                        portFolioInputSection
                    }
                }
            }
            .toolbar(content: {
                ToolbarItem(placement: .topBarLeading) {
                    XMarkButton()
                }
                ToolbarItem(placement: .topBarTrailing) {
                    navBarTrailingButton
                }
            })
            .navigationTitle("Portfolio View")
            .onChange(of: homeViewModel.searchText) { value in
                if value == "" {
                    removeSelectedCoin()
                }
            }
        }
    }
}


extension PortfolioView {
    
    private var navBarTrailingButton: some View {
        HStack(spacing: 10) {
            Image(systemName: "checkmark")
                .opacity(showCheckmark ? 1 : 0)
            Button(action: {
                saveCoin()
            }, label: {
                Text("Save".uppercased())
            })
            .opacity(
                selectedCoin != nil && selectedCoin?.currentHoldings != Double(quentityText) ?
                1 : 0
            )
        }
        .font(.headline)
    }
    
    private var portFolioInputSection: some View {
        VStack(spacing: 20) {
            HStack {
                Text("Current price of \(selectedCoin?.symbol.uppercased() ?? ""): ")
                Spacer()
                Text(selectedCoin?.currentPrice.asCurrencyWth6Decimals() ?? "")
            }
            Divider()
            HStack {
                Text("Amount holding: ")
                Spacer()
                TextField("Ex: 1.4", text: $quentityText)
                    .multilineTextAlignment(.trailing)
                    .keyboardType(.decimalPad)
            }
            Divider()
            HStack {
                Text("Current value: ")
                Spacer()
                Text(getCurrentValue().asCurrencyWth2Decimals())
            }
        }
        .padding()
        .animation(.none)
        .font(.headline)
    }
    
    private var coinLogoList: some View {
        ScrollView(.horizontal, showsIndicators: false, content: {
            LazyHStack(content: {
                ForEach(homeViewModel.searchText.isEmpty ? homeViewModel.portfolioCoins : homeViewModel.allCoins) { coin in
                    CoinLogoView(coin: coin)
                        .frame(width: 75)
                        .padding(4)
                        .onTapGesture {
                            withAnimation {
                                updateSelectedCoin(coin: coin)
                            }
                        }
                        .background(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(
                                    selectedCoin?.id == coin.id ? Color.theme.green : Color.clear,
                                    lineWidth: 1)
                        )
                }
            })
            .frame(height: 120)
            .padding(.leading)
        })
    }
    
    private func getCurrentValue() -> Double {
        if let quentity = Double(quentityText) {
            return quentity * (selectedCoin?.currentPrice ?? 0)
        }
        return 0
    }
    
    private func updateSelectedCoin(coin: CoinModel) {
        selectedCoin = coin
        if let coin = homeViewModel.portfolioCoins.first(where: {$0.id == coin.id}),
           let amount = coin.currentHoldings {
            quentityText = String(amount)
        } else {
            quentityText = ""
        }
    }
    
    private func saveCoin() {
        guard let coin = selectedCoin else {return}
        
        //save to portfolio
        homeViewModel.updatePortfolio(coin: coin, amount: Double(quentityText) ?? 0)
        
        withAnimation(.easeIn) {
            showCheckmark = true
            removeSelectedCoin()
        }
        
        // dismiss keyboard
        UIApplication.shared.endEtiting()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            withAnimation(.easeIn) {
                showCheckmark = false
            }
        }
    }
    
    private func removeSelectedCoin() {
        selectedCoin = nil
        homeViewModel.searchText = ""
    }
}

