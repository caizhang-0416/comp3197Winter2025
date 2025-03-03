//
//  ContentView.swift
//  SmartShopper
//
//  Created by Cai Zhang on 2025-03-02.
//

import SwiftUI
import CoreData

struct ShoppingListView: View {
    @EnvironmentObject private var shoppingData: ShoppingData
    @State private var showingAddItem = false
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(shoppingData.categories) { category in
                    Section(header: Text("\(category.icon) \(category.name)")) {
                        ForEach(itemsInGroup(category)) { item in
                            HStack {
                                VStack(alignment: .leading) {
                                    Text(item.name)
                                    Text("\(item.quantity)    \(item.price.formatted(.currency(code: "CAD")))")
                                        .font(.caption)
                                        .foregroundStyle(.secondary)
                                }
                                
                                Spacer()
                                
                            }
                        }
                    }
                }
            }
            .navigationTitle("Shopping List")
            .toolbar {
                Button("Add Item") {
                    showingAddItem.toggle()
                }
            }
            .sheet(isPresented: $showingAddItem) {
                AddItemView().environmentObject(shoppingData)
            }
        }
    }
    
    private func itemsInGroup(_ category: Category) -> [Item] {
        shoppingData.items.filter { $0.categoryId == category.id }
    }
}
