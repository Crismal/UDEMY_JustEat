//
//  Product.swift
//  UdemyJustEat
//
//  Created by Cristian Misael Almendro Lazarte on 12/12/18.
//  Copyright © 2018 Cristian Misael Almendro Lazarte. All rights reserved.
//

import Foundation


struct Product: Codable, Hashable {
    var name : String
    var description : String
    var price : Int
}
