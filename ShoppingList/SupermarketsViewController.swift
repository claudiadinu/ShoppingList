//
//  SupermarketsViewController.swift
//  ShoppingList
//
//  Created by Claudia Dinu on 21/12/2020.
//

import UIKit

struct Supermarket {
    let name: String
    let distance: Double
    let imageName: String
}

class SupermarketsViewController: UIViewController {

    @IBOutlet weak var supermarketsTableView: UITableView!
    
    var supermarkets: [Supermarket] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        supermarketsTableView.delegate = self
        supermarketsTableView.dataSource = self
        
        //!!NU mai am nevoie de table view cell in storyboard daca am custom cell in xib
        supermarketsTableView.register(UINib(nibName: "CustomSupermarketCell", bundle: .main), forCellReuseIdentifier: "customSupermarketCell")
        createData()
        configureTableView()
    }
    
    func createData() {
        let lidl = Supermarket(name: "Lidl", distance: 4.5, imageName: "lidl")
        let kaufland = Supermarket(name: "Kaufland", distance: 3, imageName: "kaufland")
        let carrefour = Supermarket(name: "Carrefour", distance: 2.2, imageName: "carrefour")
        supermarkets.append(lidl)
        supermarkets.append(kaufland)
        supermarkets.append(carrefour)
        supermarkets.append(lidl)
        supermarkets.append(kaufland)
        supermarkets.append(carrefour)
        supermarkets.append(lidl)
        supermarkets.append(kaufland)
        supermarkets.append(carrefour)
    }
    
    func configureTableView() {
        supermarketsTableView.rowHeight = 120.0
    }
    
}

extension SupermarketsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return supermarkets.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "customSupermarketCell", for: indexPath) as? CustomSupermarketCell {
            cell.nameLabel.text = supermarkets[indexPath.row].name
            cell.distanceLabel.text = "\(supermarkets[indexPath.row].distance) km"
            cell.supermarketPhoto.image = UIImage(named: supermarkets[indexPath.row].imageName)
            return cell
        }
        return UITableViewCell()
    }
}

extension SupermarketsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            supermarkets.remove(at: indexPath.row)
            supermarketsTableView.deleteRows(at: [indexPath], with: .automatic)
        }
    }
}
