//
//  LaunchView.swift
//  CryptoApp
//
//  Created by Ismoiljon Xolmatov on 28.03.2024.
//

import SwiftUI

struct LaunchView: View {
    
    @State private var loadingTextArray: [String] = "Loading your portfolio...".map({ String($0) })
    @State private var showLoadingText: Bool = false
    @State private var counter: Int = 0
    @State private var loops: Int = 0
    @Binding var showLaunchView: Bool
    
    private let timer = Timer.publish(every: 0.1, on: .main, in: .common).autoconnect()
    
    var body: some View {
        ZStack {
            Color.launch.background
                .ignoresSafeArea()
            Image("logo-transparent")
                .resizable()
                .frame(width: 100, height: 100)
            ZStack {
                if showLoadingText {
                    HStack(spacing: 2) {
                    ForEach(loadingTextArray.indices) { index in
                            Text(loadingTextArray[index])
                                .offset(y: counter == index ? -7 : 0)
                            
                        }
                    }
                    .foregroundStyle(Color.launch.accent)
                    .font(.system(size: 18, weight: .medium, design: .rounded))
                    .transition(AnyTransition.scale.animation(.easeIn))
                }
            }
            .offset(y: 70)
        }
        .onAppear(perform: {
            showLoadingText.toggle()
        })
        .onReceive(timer, perform: { _ in
            withAnimation(.easeInOut) {
                if counter == loadingTextArray.count - 1 {
                    counter = 0
                    loops += 1
                    if loops >= 2 {
                        showLaunchView = false
                    }
                } else {
                    counter += 1
                }
            }
        })
    }
}

#Preview {
    LaunchView(showLaunchView: .constant(true))
}
