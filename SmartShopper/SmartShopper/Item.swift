//
//  Item.swift
//  SmartShopper
//
//  Created by Cai Zhang on 2025-02-16.
//

import Foundation

@MainActor class ShoppingData: ObservableObject {
    @Published var items: [Item] = []
    @Published var categories: [Category] = [
        Category(name: "Food", taxRate: 13, icon: "🍎"),
        Category(name: "Clothing", taxRate: 13, icon: "👕"),
        Category(name: "Medicine", taxRate: 13, icon: "💊"),
        Category(name: "Gift", taxRate: 13, icon: "🎁"),
        Category(name: "Other", taxRate: 13, icon: "❓")
    ]
}

struct Category: Identifiable {
    let id = UUID()
    var name: String
    var taxRate: Double
    var icon: String
}

struct Item: Identifiable {
    let id: UUID
    let name: String
    let price: Double
    let quantity: Int
    let category: Category
    let dateAdded: Date
    let categoryId: UUID
}

