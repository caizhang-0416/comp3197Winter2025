//
//  EditItemVC.swift
//  SmartShopper
//
//  Created by Cai Zhang on 2025-02-16.
//
import UIKit

protocol ItemUpdateDelegate: AnyObject {
    func didUpdateItem(_ item: Item)
}

class EditItemVC: UIViewController {
    var item: Item!
    weak var delegate: ItemUpdateDelegate?
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var priceTextField: UITextField!
    @IBOutlet weak var categoryButton: UIButton!
    
    private var selectedCategory: Category? // Ensure `CategoryType` exists in your model

    override func viewDidLoad() {
        super.viewDidLoad()
        prefillFields()
    }
    
    private func prefillFields() {
        nameTextField.text = item.name
        priceTextField.text = String(format: "%.2f", item.price)
        categoryButton.setTitle(item.category.rawValue, for: .normal)
        selectedCategory = item.category
    }
    
    @IBAction func categoryTapped(_ sender: UIButton) {
        // Show category selection (e.g., UIAlertController)
        showCategorySelection()
    }
    
    @IBAction func saveTapped(_ sender: UIButton) {
        guard let name = nameTextField.text, !name.isEmpty,
              let priceText = priceTextField.text, let price = Double(priceText),
              let category = selectedCategory else {
            showAlert(title: "Error", message: "Invalid input. Please check all fields.")
            return
        }
        
        let updatedItem = Item(
            id: item.id,
            name: name,
            price: price,
            category: category,
            dateAdded: item.dateAdded
        )
        
        delegate?.didUpdateItem(updatedItem)
        navigationController?.popViewController(animated: true)
    }

    private func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }

    private func showCategorySelection() {
        let alert = UIAlertController(title: "Select Category", message: nil, preferredStyle: .actionSheet)
        for category in Category.allCases {
            alert.addAction(UIAlertAction(title: category.rawValue, style: .default) { _ in
                self.selectedCategory = category
                self.categoryButton.setTitle(category.rawValue, for: .normal)
            })
        }
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        present(alert, animated: true)
    }
}
