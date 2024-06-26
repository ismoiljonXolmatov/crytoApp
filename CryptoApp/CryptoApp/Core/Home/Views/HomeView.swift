//
//  HomeView.swift
//  CryptoApp
//
//  Created by Hasan Abdullah on 05.03.2024.
//

import SwiftUI

struct HomeView: View {
    @EnvironmentObject private var viewModel: HomeViewModel
    
    @State private var showPortfolio: Bool = false
    @State private var showPortfolioView: Bool = false
    @State private var showDetailView: Bool = false
    @State private var selectedCoin: CoinModel? = nil
    @State private var showSettingsView: Bool = false
    
    var body: some View {
        ZStack {
            //background layer
            Color.theme.background.ignoresSafeArea()
                .sheet(isPresented: $showPortfolioView) {
                    PortfolioView()
                        .environmentObject(viewModel)
                }
            // Content layer
            VStack {
                homeHeaderView
                HomeStatsView(showPortfolio: $showPortfolio)
                SearchBarView(searchText: $viewModel.searchText)
                coulmnTitles
                if !showPortfolio {
                    allCoinsList
                        .transition(.move(edge: .leading))
                } else {
                    ZStack(alignment: .top) {
                        if viewModel.portfolioCoins.isEmpty && viewModel.searchText.isEmpty {
                          portfolioListEmptyText
                        } else {
                            portfolioList
                        }
                    }
                    .transition(.move(edge: .trailing))
                }
                Spacer(minLength: 0)
            }
            .sheet(isPresented: $showSettingsView, content: {
                SettingsView()
            })
        }
        .navigationDestination(isPresented: $showDetailView) {
            LoadingCoinDetailView(coin: $selectedCoin)
        }
    }
    
    private func segue(coin: CoinModel) {
        selectedCoin = coin
        showDetailView.toggle()
    }
}

extension HomeView {
    private var homeHeaderView: some View {
        HStack {
            CircleButtonView(iconName: showPortfolio ? "plus" : "info")
                .animation(.none)
                .background(
                    CircleButtonAnimationView(animate: $showPortfolio)
                )
                .onTapGesture {
                    if showPortfolio {
                        showPortfolioView.toggle()
                    } else {
                        showSettingsView.toggle()
                    }
                }
            Spacer()
            Text(showPortfolio ? "Portfolio" : "Live Prices")
                .font(.headline)
                .fontWeight(.heavy)
                .foregroundStyle(Color.theme.accent)
            Spacer()
            CircleButtonView(iconName: "chevron.right")
                .rotationEffect(Angle(degrees: showPortfolio ? 180 : 0))
                .onTapGesture {
                    withAnimation {
                        showPortfolio.toggle()
                    }
                }
        }
        .padding(.horizontal)
    }
    
    private var coulmnTitles: some View {
        HStack {
            HStack(spacing: 4) {
                Text("Coin")
                Image(systemName: "chevron.down")
                    .opacity(viewModel.sortOption == .rank || viewModel.sortOption == .rankReversed ? 1 : 0)
                    .rotationEffect(Angle(degrees: viewModel.sortOption == .rank ? 180 : 0))
            }
            .onTapGesture {
                withAnimation {
                    viewModel.sortOption = viewModel.sortOption == .rank ? .rankReversed : .rank
                }
            }
            Spacer()
            if showPortfolio {
                HStack(spacing: 4) {
                    Text("Holdings")
                    Image(systemName: "chevron.down")
                        .opacity(viewModel.sortOption == .holdings || viewModel.sortOption == .holdingsReversed ? 1 : 0)
                        .rotationEffect(Angle(degrees: viewModel.sortOption == .holdings ? 180 : 0))
                }
                .onTapGesture {
                    withAnimation {
                        viewModel.sortOption = viewModel.sortOption == .holdings ? .holdingsReversed : .holdings
                    }
                }
            }
            HStack(spacing: 4) {
                Text("Price")
                Image(systemName: "chevron.down")
                    .opacity(viewModel.sortOption == .price || viewModel.sortOption == .priceReversed ? 1 : 0)
                    .rotationEffect(Angle(degrees: viewModel.sortOption == .price ? 180 : 0))
            }
            .frame(width: UIScreen.main.bounds.width / 3.5, alignment: .trailing)
            .onTapGesture {
                withAnimation {
                    viewModel.sortOption = viewModel.sortOption == .price ? .priceReversed : .price
                }
            }
            Button(action: {
                withAnimation(.linear(duration: 1.5)) {
                    viewModel.reloadData()
                }
            }, label: {
                Image(systemName: "goforward")
            })
            .rotationEffect(Angle(degrees: viewModel.isReloading ? 360 : 0), anchor: .center)
        }
        .font(.caption)
        .padding(.horizontal)
        .foregroundStyle(Color.theme.secondaryText)
    }
    
    private var allCoinsList: some View {
        List {
            ForEach(viewModel.allCoins) { coin in
                CoinRowView(coin: coin, showHoldingColumn: false)
                    .listRowInsets(EdgeInsets(top: 10, leading: 0, bottom: 10, trailing: 10))
                    .onTapGesture {
                        segue(coin: coin)
                    }
                    .listRowBackground(Color.theme.background)
            }
        }
        .listStyle(PlainListStyle())
    }
    
    private var portfolioList: some View {
        List {
            ForEach(viewModel.portfolioCoins) { coin in
                CoinRowView(coin: coin)
                    .listRowInsets(EdgeInsets(top: 10, leading: 0, bottom: 10, trailing: 10))
                    .onTapGesture {
                        segue(coin: coin)
                    }
                    .listRowBackground(Color.theme.background)
            }
        }
        .listStyle(PlainListStyle())
    }
    
    private var portfolioListEmptyText: some View {
        Text("You havn't added any coins to your portfolio yet. Click + button to get started! 🧐")
            .multilineTextAlignment(.center)
            .font(.callout)
            .fontWeight(.medium)
            .foregroundStyle(Color.theme.accent)
            .padding(50)
    }
    
}


/*
 #Preview {
 NavigationStack {
 HomeView()
 .toolbar(.hidden, for: .navigationBar)
 }
 .environmentObject(DeveloperPreview.instance.homeViewModel)
 }
 */
