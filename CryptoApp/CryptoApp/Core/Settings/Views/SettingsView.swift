//
//  Settings.swift
//  CryptoApp
//
//  Created by Ismoiljon Xolmatov on 27.03.2024.
//

import SwiftUI

struct SettingsView: View {
    
    @StateObject var viewModel = SettingsViewModel()
    
    var body: some View {
        NavigationStack {
            List {
                coinGeckoSection
                developerSection
                swiftfullThinkingSection
                applicationSection
            }
            .listStyle(.automatic)
            .tint(.blue)
            .toolbar(content: {
                ToolbarItem(placement: .topBarLeading) {
                    XMarkButton()
                }
            })
        }
    }
}

extension SettingsView {
    private var coinGeckoSection: some View {
        Section(header: Text("CoinChecko").font(.headline)) {
            VStack(alignment: .leading) {
                Image("coingecko")
                    .resizable()
                    .scaledToFit()
                    .frame(height: 100)
                    .clipShape(RoundedRectangle(cornerRadius: 15))
                Text("The cryptocurrency data is used in this app comes from a free(30 times in a minut) API from CoinGecko! Prices may be slightly deleyed.")
                    .font(.callout)
                    .fontWeight(.medium)
                    .foregroundStyle(Color.theme.accent)
            }
            .padding(.vertical)
            
            Link(destination: viewModel.coinGeckoUrl!, label: {
                Text("Visit CoinGecko 🌐")
            })
            Link(destination: viewModel.coinGeckoFreeAPI!, label: {
                Text("Check free API 🔍")
            })
        }
    }
    
    private var developerSection: some View {
        Section(header: Text("Developer").font(.headline)) {
            VStack(alignment: .leading) {
                Image("xcode")
                    .resizable()
                    .scaledToFit()
                    .frame(height: 100)
                    .clipShape(RoundedRectangle(cornerRadius: 15))
                Text("This app was developed by Ismoil Xolmatov. It fully uses SwiftUI and is written in Swift. The project benifits from multi-threading, publishers, subscriber, and data persistence")
                    .font(.callout)
                    .fontWeight(.medium)
                    .foregroundStyle(Color.theme.accent)
            }
            .padding(.vertical)
            Text("Follow developer via links below")
            Link(destination: viewModel.githubUrl!, label: {
                HStack {
                    Text("Visit Github 🌐")
                    Image("github")
                        .resizable()
                        .scaledToFit()
                        .frame(height: 20)
                }
            })
            Link(destination: viewModel.linkedInUrl!, label: {
                Text("Check LinkedIn 🚀")
            })
            Link(destination: viewModel.emailUrl!, label: {
                Text("Email for any questions 📧")
            })
            Link(destination: viewModel.telegramUrl!, label: {
                Text("Chat by telegram 💭")
            })

        }
    }
    
    private var swiftfullThinkingSection: some View {
        Section(header: Text("Swiftfull Thinking").font(.headline)) {
            VStack(alignment: .leading) {
                Image("logo")
                    .resizable()
                    .scaledToFit()
                    .frame(height: 100)
                    .clipShape(RoundedRectangle(cornerRadius: 15))
                Text("App made by following Nick on you tube. It uses MVVM Architecture, Combine, CoreData!")
                    .font(.callout)
                    .fontWeight(.medium)
                    .foregroundStyle(Color.theme.accent)
            }
            .padding(.vertical)
            
            Link(destination: viewModel.swiftfullThinkingUrl!, label: {
                    Text("Look at Crypto Tracker App Playlist 🔥")
            })
        }
    }
    
    private var applicationSection: some View {
        Section(header: Text("Application").font(.headline)) {
            Link("Terms of Service", destination: viewModel.googleUrl!)
            Link("Privacy Policy", destination: viewModel.googleUrl!)
            Link("Company Website", destination: viewModel.googleUrl!)
            Link("Learn More", destination: viewModel.googleUrl!)
         }
    }
}

#Preview {
    SettingsView()
}

