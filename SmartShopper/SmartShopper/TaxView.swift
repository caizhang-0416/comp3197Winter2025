//
//  TaxView.swift
//  SmartShopper
//
//  Created by Cai Zhang on 2025-03-02.
//

import SwiftUI

struct TaxView: View {
    @EnvironmentObject var shoppingData: ShoppingData
    
    var body: some View {
        let calculation = calculateTotal()
        
        NavigationView {
            Form {
                Section(header: Text("Summary")) {
                    HStack {
                        Text("Subtotal")
                        Spacer()
                        Text(formatCurrency(calculation.subtotal))
                    }
                    
                    HStack {
                        Text("Total Tax")
                        Spacer()
                        Text(formatCurrency(calculation.totalTax))
                    }
                    
                    HStack {
                        Text("Total")
                            .fontWeight(.bold)
                        Spacer()
                        Text(formatCurrency(calculation.grandTotal))
                            .fontWeight(.bold)
                    }
                }
                
                Section(header: Text("Tax Details")) {
                    ForEach(calculation.taxBreakdown.sorted(by: { $0.key < $1.key }), id: \.key) { group, tax in
                        HStack {
                            Text(group)
                            Spacer()
                            Text(formatCurrency(tax))
                        }
                    }
                }
            }
            .navigationTitle("Tax Calculator")
        }
    }
    
    private func calculateTotal() -> (subtotal: Double, totalTax: Double, grandTotal: Double, taxBreakdown: [String: Double]) {
        var subtotal = 0.0
        var taxBreakdown: [String: Double] = [:]
        
        for item in shoppingData.items {
            guard let category = shoppingData.categories.first(where: { $0.id == item.categoryId }) else { continue }
            let itemTotal = item.price * Double(item.quantity)
            subtotal += itemTotal
            let tax = itemTotal * (category.taxRate / 100)
            taxBreakdown[category.name] = (taxBreakdown[category.name] ?? 0) + tax
        }
        
        let totalTax = taxBreakdown.values.reduce(0, +)
        let grandTotal = subtotal + totalTax
        
        return (subtotal, totalTax, grandTotal, taxBreakdown)
    }
    
    private func formatCurrency(_ value: Double) -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        return formatter.string(from: NSNumber(value: value)) ?? "$0.00"
    }
}

struct TaxView_Previews: PreviewProvider {
    static var previews: some View {
        TaxView()
    }
}
