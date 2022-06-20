//
//  ViewController.swift
//  ShoppingList
//
//  Created by Claudia Dinu on 19/12/2020.
//

import UIKit
import Foundation
import CoreData

class ShoppingListViewController: UIViewController {
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    @IBOutlet weak var shoppingListTableView: UITableView!
    
    var items: [Item] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        shoppingListTableView.delegate = self
        shoppingListTableView.dataSource = self
        
        //navigationItem.leftBarButtonItem = editButtonItem
        shoppingListTableView.register(UINib(nibName: "ItemCell", bundle: .main), forCellReuseIdentifier: "itemCell")
        
        fetchItems()
    }
    
    func fetchItems() {
        do {
            self.items = try context.fetch(Item.fetchRequest())
            DispatchQueue.main.async {
                self.shoppingListTableView.reloadData()
            }
        }
        catch {
            print("Error while fetching items...")
        }
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
                let newItem = Item(context: self.context)
                newItem.name = newName
                newItem.quantity = Int64(newQuantity)
                newItem.color = "orange"
                do {
                    try self.context.save()
                }
                catch {
                    print("Error while saving data.")
                }
                self.fetchItems()
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
        let cell = tableView.dequeueReusableCell(withIdentifier: "itemCell", for: indexPath) as! ItemCell
        cell.nameLabel.text = items[indexPath.row].name
        cell.quantityLabel.text = String(items[indexPath.row].quantity)
        cell.contentView.backgroundColor = UIColor.colorWith(name: items[indexPath.row].color ?? "red")
        cell.delegate = self
        cell.tableViewReference = shoppingListTableView
        cell.indexReference = indexPath.row
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
            let itemToRemove = items[indexPath.row]
            self.context.delete(itemToRemove)
            do {
                try self.context.save()
            }
            catch {
                print("Error while saving data.")
            }
            fetchItems()
        }
    }
}

extension UIColor {

    static func colorWith(name:String) -> UIColor? {
        let selector = Selector("\(name)Color")
        if UIColor.self.responds(to: selector) {
            let color = UIColor.self.perform(selector).takeUnretainedValue()
            return (color as? UIColor)
        } else {
            return nil
        }
    }
}

//data source struct
//delete - remove data source si apoi remove din table view
//button de bar button item - o alerta cu un text field in care scriu ceva si dau add apoi adaug ce am scris in table view ul meu

