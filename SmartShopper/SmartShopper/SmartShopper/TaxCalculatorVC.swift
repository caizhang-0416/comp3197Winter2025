//
//  TaxCalculatorVC.swift
//  SmartShopper
//
//  Created by Cai Zhang on 2025-02-16.
//

import UIKit

// TaxCalculatorVC.swift
class TaxCalculatorVC: UIViewController {
    @IBOutlet weak var subtotalLabel: UILabel!
    @IBOutlet weak var taxLabel: UILabel!
    @IBOutlet weak var totalLabel: UILabel!

    var items: [Item] = []
    let taxRate: Double = 0.08 // 8% tax
    
   
    func calculateTotals() {
        let subtotal = items.reduce(0) { $0 + $1.price }
        let tax = subtotal * taxRate
        let total = subtotal + tax
        
        subtotalLabel.text = String(format: "$%.2f", subtotal)
        taxLabel.text = String(format: "$%.2f", tax)
        totalLabel.text = String(format: "$%.2f", total)
    }
}
