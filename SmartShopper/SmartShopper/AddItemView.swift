//
//  AddItemView.swift
//  SmartShopper
//
//  Created by Cai Zhang on 2025-03-02.
//

import SwiftUI

struct AddItemView: View {
    @EnvironmentObject private var shoppingData: ShoppingData
    @Environment(\.dismiss) private var dismiss
    
    @State private var name = ""
    @State private var price = 0.0
    @State private var quantity = 1
    @State private var selectedCategoryID: UUID?
    
    var body: some View {
        NavigationStack {
            Form {
                TextField("Item name", text: $name)
                
                TextField("Price", value: $price, format: .number)

                
                Stepper("Quantity: \(quantity)", value: $quantity, in: 1...100)
                
                Picker("Category", selection: $selectedCategoryID) {
                    ForEach(shoppingData.categories) { category in
                        Text("\(category.icon) \(category.name)").tag(category.id as UUID?)
                    }
                }
            }
            .navigationTitle("New Item")
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") { dismiss() }
                }
                ToolbarItem(placement: .primaryAction) {
                    Button("Save") {
                        if let categoryId = selectedCategoryID {
                            if let category = shoppingData.categories.first(where: { $0.id == selectedCategoryID }) {
                                let newItem = Item(
                                    id: UUID(),
                                    name: name,
                                    price: price,
                                    quantity: quantity,
                                    category: category,
                                    dateAdded: Date.now,
                                    categoryId: categoryId
                                )
                                shoppingData.items.append(newItem)
                                dismiss()
                            }
                        }
                    }
                    .disabled(name.isEmpty || selectedCategoryID == nil)
                }
            }
        }
    }
}

struct AddItemView_Previews: PreviewProvider {
    static var previews: some View {
        AddItemView()
    }
}
