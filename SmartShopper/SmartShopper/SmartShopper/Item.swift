//
//  Item.swift
//  SmartShopper
//
//  Created by Cai Zhang on 2025-02-16.
//

import Foundation

enum Category: String, CaseIterable, Codable {
    case food = "🍎 Food"
    case clothing = "👕 Clothing"
    case medicine = "💊 Medicine"
    case gift = "🎁 Gift"
    case other = "❓ Other"

    var emoji: String {
        switch self {
        case .food: return "🍎"
        case .clothing: return "👕"
        case .medicine: return "💊"
        case .gift: return "🎁"
        case .other: return "❓"
        }
    }
}


struct Item: Codable {
    let id: UUID
    let name: String
    let price: Double
    let category: Category
    let dateAdded: Date
}

