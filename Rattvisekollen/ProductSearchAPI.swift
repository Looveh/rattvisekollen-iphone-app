//
//  ProductSearchAPI.swift
//  Rattvisekollen
//
//  Created by Fredrik Bystam on 22/08/15.
//  Copyright © 2015 nickenil_byrreb. All rights reserved.
//

import UIKit

class ProductSearchAPI: NSObject {
    
    class func findProductWithCode(code: String, callback: (product: Product?, error: NSError?) -> Void) {
        let session = NSURLSession.sharedSession()
        let url = urlFromCode(code)

        let task = session.dataTaskWithURL(url) { data, response, error -> Void in
            callback(product: Product.dummyProduct(), error: nil)
//            if (error != nil) {
//                callback(product: nil, error: error)
//            } else {
//                callback(product: productFromData(data), error: nil)
//            }
        }

        task.resume()
    }

    class func productFromData(data: NSData?) -> Product? {
        do {
            let json = try NSJSONSerialization.JSONObjectWithData(data!, options: .MutableContainers) as! NSDictionary
            
            let product = Product(jsonData: json)
            return product
        } catch let jsonError as NSError {
            print(jsonError)
        }
        return nil
    }
    
    class func urlFromCode(code: String) -> NSURL {
        let url = "www.lolfi.golfi/product?code=\(code)"
        return NSURL(string: url)!
    }
}
