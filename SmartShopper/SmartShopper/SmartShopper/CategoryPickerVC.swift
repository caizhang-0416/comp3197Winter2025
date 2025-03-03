//
//  CategoryPickerVC.swift
//  SmartShopper
//
//  Created by Cai Zhang on 2025-02-16.
//

import UIKit

protocol CategoryPickerDelegate: AnyObject {
    func didSelectCategory(_ category: Category)
}

class CategoryPickerVC: UITableViewController {
    weak var delegate: CategoryPickerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "CategoryCell")
    }
    
    // MARK: - Table View Data Source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Category.allCases.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath)
        let category = Category.allCases[indexPath.row]
        cell.textLabel?.text = category.rawValue
        return cell
    }
    
    // MARK: - Table View Delegate
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedCategory = Category.allCases[indexPath.row]
        delegate?.didSelectCategory(selectedCategory)
        dismiss(animated: true)

    }
}
