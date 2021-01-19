//
//  ItemDetailsViewController.swift
//  ShoppingList
//
//  Created by Claudia Dinu on 20/12/2020.
//

import UIKit

class ItemDetailsViewController: UIViewController {
    
    var selectedItem: Item?

    @IBOutlet weak var itemImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        nameLabel.text = selectedItem?.name
        itemImageView.image = UIImage(named: "\(selectedItem?.name ?? "Shopping")")
    }

}
