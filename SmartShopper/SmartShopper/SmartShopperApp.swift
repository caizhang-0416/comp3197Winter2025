//
//  SmartShopperApp.swift
//  SmartShopper
//
//  Created by Cai Zhang on 2025-03-02.
//

import SwiftUI

@main
struct SmartShopperApp: App {
    @State private var showLaunchScreen = true
    var body: some Scene {
        WindowGroup {
            ZStack {
                if showLaunchScreen {
                    WelcomeView()
                        .transition(.opacity)
                } else {
                    ContentView()
                }
            }
                .onAppear {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 8) {
                        withAnimation {
                            showLaunchScreen = false
                            
                        }
                    }
                }
        }
    }
}
