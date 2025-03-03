//
//  Edit Item Screen.swift
//  SmartShopper
//
//  Created by Cai Zhang on 2025-02-16.
//

import Foundation
class EditItemVC: UIViewController {
    var item: Item!
    weak var delegate: ItemUpdateDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        prefillFields()
    }
    
    private func prefillFields() {
        nameTextField.text = item.name
        priceTextField.text = String(format: "%.2f", item.price)
        categoryButton.setTitle(item.category.rawValue, for: .normal)
    }
    
    @IBAction func saveTapped(_ sender: UIButton) {
        guard let name = nameTextField.text, !name.isEmpty,
              let price = Double(priceTextField.text ?? "") else {
            showAlert(title: "Error", message: "Invalid input")
            return
        }
        
        let updatedItem = Item(
            id: item.id,
            name: name,
            price: price,
            category: selectedCategory,
            dateAdded: item.dateAdded
        )
        
        delegate?.didUpdateItem(updatedItem)
        navigationController?.popViewController(animated: true)
    }
}
