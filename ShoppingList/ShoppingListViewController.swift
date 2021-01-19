//
//  ViewController.swift
//  ShoppingList
//
//  Created by Claudia Dinu on 19/12/2020.
//

import UIKit
import Foundation

struct Item {
    var name: String
    var quantity: Int
    var color: UIColor
}

class ShoppingListViewController: UIViewController {
    
    @IBOutlet weak var shoppingListTableView: UITableView!
    
    var items: [Item] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        shoppingListTableView.delegate = self
        shoppingListTableView.dataSource = self
        
        navigationItem.leftBarButtonItem = editButtonItem
        
        createData()
    }
    
    func createData() {
        let bread = Item(name: "Bread", quantity: 7, color: .red)
        let chocolate = Item(name: "Chocolate", quantity: 2, color: .brown)
        let cookies = Item(name: "Cookies", quantity: 4, color: .cyan)
        let flowers = Item(name: "Flowers", quantity: 5, color: .systemPink)
        let oil = Item(name: "Oil", quantity: 1, color: .yellow)
        let milk = Item(name: "Milk", quantity: 3, color: .white)
        
        items.append(bread)
        items.append(chocolate)
        items.append(cookies)
        items.append(flowers)
        items.append(oil)
        items.append(milk)
        items.append(bread)
        items.append(chocolate)
        items.append(cookies)
        items.append(flowers)
        items.append(oil)
        items.append(milk)
        items.append(bread)
        items.append(chocolate)
        items.append(cookies)
        items.append(flowers)
        items.append(oil)
        items.append(milk)
    }
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        let alert = UIAlertController(title: "New Item", message: "Add name and quantity for the new item:", preferredStyle: .alert)
        var nameTextField = UITextField()
        var quantityTextField = UITextField()
        alert.addTextField { (textField) in
            textField.placeholder = "Name"
            nameTextField = textField
        }
        alert.addTextField { (textField) in
            textField.placeholder = "Quantity"
            quantityTextField = textField
        }
        alert.addAction(UIAlertAction(title: "Add", style: .default, handler: { (action) in
            if let newName = nameTextField.text, let quantity = quantityTextField.text, let newQuantity = Int(quantity) {
                let newItem = Item(name: newName, quantity: newQuantity, color: .orange)
                self.items.append(newItem)
                self.shoppingListTableView.reloadData()
            }
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}

extension ShoppingListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "itemCell", for: indexPath)
        cell.textLabel?.text = items[indexPath.row].name
        cell.detailTextLabel?.text = String(items[indexPath.row].quantity)
        cell.contentView.backgroundColor = items[indexPath.row].color
//        if indexPath.row % 2 == 0 {
//            cell.contentView.backgroundColor = .red
//        }
//        else {
//            cell.contentView.backgroundColor = .clear
//        }
        return cell
    }
}

extension ShoppingListViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let itemDetailsVC = self.storyboard?.instantiateViewController(identifier: "ItemDetailsViewController") as? ItemDetailsViewController {
            itemDetailsVC.selectedItem = items[indexPath.row]
            present(itemDetailsVC, animated: true, completion: nil)
        }
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            items.remove(at: indexPath.row)
            shoppingListTableView.deleteRows(at: [indexPath], with: .automatic)
        }
        else if editingStyle == .insert {
            items.append(Item(name: "test", quantity: 1, color: .orange))
            shoppingListTableView.insertRows(at: [indexPath], with: .automatic)
        }
    }
}

//data source struct
//delete - remove data source si apoi remove din table view
//button de bar button item - o alerta cu un text field in care scriu ceva si dau add apoi adaug ce am scris in table view ul meu

