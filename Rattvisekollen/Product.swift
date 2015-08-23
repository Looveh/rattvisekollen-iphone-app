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
    let labels: [Label]

    required init(jsonData: NSDictionary) {
        self.code = jsonData["barcode"] as! String
        self.name = jsonData["name"] as! String
        self.manufacturer = jsonData["manufacturer"] as! String
        self.origin = jsonData["origin"] as! String
        self.ingredients = jsonData["ingredients"] as! [String]
        self.labels = (jsonData["labels"] as! [String]).map({ Label.labelWithId($0) })
    }
}
