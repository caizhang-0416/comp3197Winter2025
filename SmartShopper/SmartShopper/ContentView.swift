//
//  ContentView.swift
//  SmartShopper
//
//  Created by Cai Zhang on 2025-03-02.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @StateObject var shoppingData = ShoppingData()
    
    var body: some View {
        TabView {
            ShoppingListView()
                .environmentObject(shoppingData)
                .tabItem { Label("List", systemImage: "list.bullet") }
            
            TaxView()
                .environmentObject(shoppingData)
                .tabItem { Label("Tax", systemImage: "percent") }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
