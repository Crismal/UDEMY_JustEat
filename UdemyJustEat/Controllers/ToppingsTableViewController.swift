//
//  ToppingsTableViewController.swift
//  UdemyJustEat
//
//  Created by Cristian Misael Almendro Lazarte on 12/12/18.
//  Copyright © 2018 Cristian Misael Almendro Lazarte. All rights reserved.
//

import UIKit

class ToppingsTableViewController: UITableViewController {
 
    var cupcake: Product?;
    var selectedToppings = Set<Product>();
    
    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Añadir decoracion";
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Pedir ahora", style: UIBarButtonItem.Style.plain, target: self, action: #selector(placeOrder))
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1;
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return ProductsFactory.shared().toppings.count;
    }

   
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "toppingCell", for: indexPath)

        let topping = ProductsFactory.shared().toppings[indexPath.row];
        
        cell.textLabel?.text = "\(topping.name) - \(topping.price)$"
        cell.detailTextLabel?.text = topping.description;
        
        return cell
    }
 
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let cell = tableView.cellForRow(at: indexPath) else {
            fatalError("No se hay podido recuperar la celda");
        }
        
        let topping = ProductsFactory.shared().toppings[indexPath.row];
        
        if selectedToppings.contains(topping) {
            cell.accessoryType = .none;
            selectedToppings.remove(topping);
        }
        else {
            cell.accessoryType = .checkmark;
            selectedToppings.insert(topping);
        }
        
        tableView.deselectRow(at: indexPath, animated: true);
    }
    
    @objc func placeOrder()
    {
        guard let orderVC =  storyboard?.instantiateViewController(withIdentifier: "OrderVC") as? OrderViewController else {
            fatalError("No se ha podido cargar el view controller del pedido desde el storyboard");
        }
        
        orderVC.cupcake = self.cupcake;
        orderVC.toppings = self.selectedToppings;
        
        navigationController?.pushViewController(orderVC, animated: true);
    }
    
}
