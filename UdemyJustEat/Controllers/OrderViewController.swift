//
//  ViewController.swift
//  UdemyJustEat
//
//  Created by Cristian Misael Almendro Lazarte on 12/11/18.
//  Copyright © 2018 Cristian Misael Almendro Lazarte. All rights reserved.
//

import UIKit
import Intents;

class OrderViewController: UIViewController {

    var cupcake : Product!;
    var toppings = Set<Product>();
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var orderLabel: UILabel!
    @IBOutlet weak var costLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let image = imageView.image;
        
        imageView.image = nil;
        imageView.image = image?.withRenderingMode(UIImage.RenderingMode.alwaysTemplate);
        
        let order = Order(cupcake: cupcake, toppings: toppings);
        
        showOrderViewDetails(order);
        sendToServer(order);
        donate(order);
        
        navigationItem.hidesBackButton = true;
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.done, target: self, action: #selector(done));
    }
    
    func showOrderViewDetails(_ order: Order) {
        orderLabel.text = order.name;
        costLabel.text = "\(order.price) $";
        
    }

    func sendToServer(_ order : Order) {
        let encoder = JSONEncoder();
        
        do {
            let data = try encoder.encode(order);
            print(data);
        } catch  {
            print("Error al enviar el pedido al restaurante.");
        }
    }
    
    func donate(_ order : Order) {
        let activity = NSUserActivity(activityType: "com.CristianAlmendro.UdemyJustEat.order");
        
        let orderName = order.name
        
        if order.cupcake.name.last == "a" {
            activity.title = "Pedir una \(orderName)"
        } else {
            activity.title = "Pedir un \(orderName)"
        }
        
        activity.isEligibleForSearch = true;
        activity.isEligibleForPrediction = true;
        
        let encoder = JSONEncoder();
        
        if let orderData = try? encoder.encode(order) {
            activity.userInfo = ["order" : orderData];
        }
        
        activity.persistentIdentifier = NSUserActivityPersistentIdentifier(orderName);
        activity.suggestedInvocationPhrase = "Quiero un postre";
        
        self.userActivity = activity
    }
    
    @objc func done(){
        navigationController?.popToRootViewController(animated: true);
    }

}

