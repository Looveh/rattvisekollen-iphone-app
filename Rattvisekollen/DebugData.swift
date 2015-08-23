//
//  DebugData.swift
//  Rattvisekollen
//
//  Created by Fredrik Bystam on 23/08/15.
//  Copyright © 2015 nickenil_byrreb. All rights reserved.
//

import UIKit

class DebugData: NSObject {
    
    class func dummyProduct() -> Product {
        let data = [
            "barcode" : "7340005403622",
            "name" : "Chirre fan",
            "manufacturer" : "OLW",
            "origin":  "Swärje",
            "ingredients" : ["potatis", "salt", "fett", "mer salt", "socker", "sprit", "rost frånt fabriken"],
            "labels" : ["krav", "euleaf", "nyckel"]
        ]
        return Product(jsonData: data as NSDictionary)
    }
}
