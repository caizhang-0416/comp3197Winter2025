//
//  AddItemVC.swift
//  SmartShopper
//
//  Created by Cai Zhang on 2025-02-16.
//

import UIKit

protocol AddItemDelegate: AnyObject {
    func didSaveItem(_ item: Item)
}

class AddItemVC: UIViewController {
    
    // MARK: - IBOutlets
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var priceTextField: UITextField!
    @IBOutlet weak var categoryPicker: UIPickerView!
    
    // MARK: - Properties
    weak var delegate: AddItemDelegate?
    var categories = Category.allCases
    var selectedCategory: Category = Category.allCases[0]
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        selectedCategory = categories[0]
    }
    
    // MARK: - IBActions
    @IBAction func cancelTapped(_ sender: UIBarButtonItem) {
        dismiss(animated: true)
    }
    
    @IBAction func saveTapped(_ sender: UIBarButtonItem) {
        guard let item = createNewItem() else { return }
        delegate?.didSaveItem(item)
        dismiss(animated: true)
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return categories.count
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> Category? {
        return categories[row]
    }

    // Get selected value
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedCategory = categories[row]
    }

    
    private func validateInputs() -> Bool {
        guard let name = nameTextField.text, !name.isEmpty,
              let priceText = priceTextField.text, !priceText.isEmpty,
              Double(priceText) != nil else {
            showAlert(title: "Error", message: "Please enter valid item name and price.")
            return false
        }
        return true
    }
    
    private func createNewItem() -> Item? {
        guard validateInputs(),
              let name = nameTextField.text,
              let price = Double(priceTextField.text ?? "") else { return nil }
        
        return Item(
            id: UUID(),
            name: name,
            price: price,
            category: selectedCategory,
            dateAdded: Date()
        )
    }
    
    private func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
    
}

