//
//  CupcakesTableViewController.swift
//  UdemyJustEat
//
//  Created by Cristian Misael Almendro Lazarte on 12/12/18.
//  Copyright © 2018 Cristian Misael Almendro Lazarte. All rights reserved.
//

import UIKit

class CupcakesTableViewController: UITableViewController {

    
    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Cupcakes Just eat";
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return ProductsFactory.shared().cupcakes.count;
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CupcakeCell", for: indexPath);
        let cupcake = ProductsFactory.shared().cupcakes[indexPath.row];
        cell.textLabel?.text = "\(cupcake.name) - \(cupcake.price)$"
        cell.detailTextLabel?.text = cupcake.description;

        return cell;
    }
 
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        guard let toppingsVC = storyboard?.instantiateViewController(withIdentifier: "ToppingsVC") as? ToppingsTableViewController else {
            fatalError("No hemos podido instanciar");
        }
        
        toppingsVC.cupcake = ProductsFactory.shared().cupcakes[indexPath.row];
        
        navigationController?.pushViewController(toppingsVC, animated: true);
    }
}
