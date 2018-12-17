//
//  Order.swift
//  UdemyJustEat
//
//  Created by Cristian Misael Almendro Lazarte on 12/14/18.
//  Copyright © 2018 Cristian Misael Almendro Lazarte. All rights reserved.
//

import Foundation


struct Order: Codable, Hashable {
    
    var cupcake : Product
    var toppings : Set<Product>
    
    var name : String {
        if( toppings.count == 0) {
            return cupcake.name;
        }
        else {
            let toppingsNames = toppings.map { $0.name.lowercased(); }
            
            return  "\(cupcake.name) con \(toppingsNames.joined(separator: ", "))";
        }
    }
    
    var price : Int {
        return toppings.reduce(cupcake.price, { $0 + $1.price }) 
    }
    
}

extension Order {
    
    init?(from data: Data?) {
        
        guard let data = data else {
            return nil;
        }
        
        let decoder = JSONDecoder();
        
        guard let savedOrder = try? decoder.decode(Order.self, from: data) else {
            return nil;
        }
        
        cupcake = savedOrder.cupcake;
        toppings = savedOrder.toppings;
        
        
    }
}
