//
//  CustomItemCell.swift
//  ShoppingList
//
//  Created by Claudia Dinu on 19/12/2020.
//

import UIKit

class CustomSupermarketCell: UITableViewCell {

    @IBOutlet weak var supermarketPhoto: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var distanceLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
