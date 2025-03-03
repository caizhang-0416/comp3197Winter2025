//
//  ShoppingListVC.swift
//  SmartShopper
//
//  Created by Cai Zhang on 2025-02-16.
//

import UIKit

class ShoppingListVC: UIViewController, UITableViewDataSource, UITableViewDelegate {
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var totalLabel: UILabel!
    
    var items: [Item] = [] {
        didSet {
            saveItems()
            updateTotal()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        loadItems()
    }
    
    private func setupTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.tableFooterView = UIView() // Hide empty cells
    }
    
    // MARK: - Table View Data Source
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ItemCell", for: indexPath)
        let item = items[indexPath.row]
        cell.textLabel?.text = "\(item.category.rawValue) \(item.name)"
        cell.detailTextLabel?.text = String(format: "$%.2f", item.price)
        return cell
    }
    
    // MARK: - Table View Delegate
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            items.remove(at: indexPath.row)
            tableView.reloadData()
        }
    }
    
    // MARK: - Actions
    @IBAction func addItemTapped(_ sender: UIBarButtonItem) {
        performSegue(withIdentifier: "showAddItem", sender: self)
    }
    
    @IBAction func totalsTapped(_ sender: UIBarButtonItem) {
        performSegue(withIdentifier: "showTaxCalculator", sender: self)
    }
    
    // MARK: - Data Management
    private func updateTotal() {
        let total = items.reduce(0) { $0 + $1.price }
        totalLabel.text = String(format: "Total: $%.2f", total)
    }
    
    private func saveItems() {
        if let encoded = try? JSONEncoder().encode(items) {
            UserDefaults.standard.set(encoded, forKey: "shoppingItems")
        }
    }
    
    private func loadItems() {
        if let data = UserDefaults.standard.data(forKey: "shoppingItems"),
           let savedItems = try? JSONDecoder().decode([Item].self, from: data) {
            items = savedItems
            tableView.reloadData()
        }
    }

    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showAddItem" {
            let nav = segue.destination as! UINavigationController
            let addVC = nav.topViewController as! AddItemVC
            addVC.delegate = self
        }
    }
}

// MARK: - AddItemDelegate
extension ShoppingListVC: AddItemDelegate {
    func didSaveItem(_ item: Item) {
        items.append(item)
        tableView.reloadData()
    }
}

