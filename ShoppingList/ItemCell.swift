//
//  ItemCell.swift
//  ShoppingList
//
//  Created by Claudia Dinu on 20/01/2021.
//

import UIKit
import CoreData

class ItemCell: UITableViewCell {
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    var delegate: ShoppingListViewController?
    var tableViewReference: UITableView?
    var indexReference: Int?

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var quantityLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func fetchItems(with name: String) -> [Item] {
        do {
            let request = Item.fetchRequest() as NSFetchRequest<Item>
            request.predicate = NSPredicate(format: "name CONTAINS %@", name)
            
            let items = try context.fetch(request)
            return items
        }
        catch {
            print("Error while fetching item with given name.")
        }
        return [Item]()
    }
    
    @IBAction func editButtonPressed(_ sender: UIButton) {
        let alert = UIAlertController(title: "Edit Item", message: "Change the name and quantity of the item", preferredStyle: .alert)
        var nameTextField = UITextField()
        var quantityTextField = UITextField()
        
        alert.addTextField { (textField) in
            textField.text = self.nameLabel.text
            nameTextField = textField
        }
        alert.addTextField { (textField) in
            textField.text = self.quantityLabel.text
            quantityTextField = textField
        }
        
        alert.addAction(UIAlertAction(title: "Add", style: .default, handler: { (action) in
            if let newName = nameTextField.text, let quantity = quantityTextField.text, let newQuantity = Int(quantity), let index = self.indexReference {
                let item = self.delegate?.items[index]
                item?.name = newName
                item?.quantity = Int64(newQuantity)
                do {
                    try self.context.save()
                }
                catch {
                    print("Error while updating item.")
                }
                self.delegate?.fetchItems()
            }
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        delegate?.present(alert, animated: true, completion: nil)
    }
    
    
}
