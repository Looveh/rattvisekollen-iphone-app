//
//  Product.swift
//  Rattvisekollen
//
//  Created by Fredrik Bystam on 22/08/15.
//  Copyright © 2015 nickenil_byrreb. All rights reserved.
//

import UIKit

class Product: NSObject {

    let code: String
    let name: String
    let manufacturer: String
    let origin: String
    let ingredients: [String]

    required init(jsonData: NSDictionary) {
        self.code = jsonData["barcode"] as! String
        self.name = jsonData["name"] as! String
        self.manufacturer = jsonData["manufacturer"] as! String
        self.origin = jsonData["origin"] as! String
        self.ingredients = jsonData["ingredients"] as! [String]
    }
    
    
    
    class func dummyProduct() -> Product {
        let data = ["barcode" : "7340005403622",
                    "name" : "Chirre fan",
                    "manufacturer" : "OLW",
                    "origin":  "Swärje",
                    "ingredients" : ["potatis", "salt", "fett", "mer salt", "socker", "sprit", "rost frånt fabriken"]]
        return Product(jsonData: data as NSDictionary)
    }
}
