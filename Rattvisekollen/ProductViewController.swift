//
//  ProductViewController.swift
//  Rattvisekollen
//
//  Created by Fredrik Bystam on 16/08/15.
//  Copyright © 2015 nickenil_byrreb. All rights reserved.
//

import UIKit

class ProductViewController: UIViewController {

    @IBOutlet weak var scrollView: UIScrollView!

    class func pushFromViewController(parent: UIViewController, forProductCode product: NSString) {
        let storyboard = UIStoryboard(name: "Product", bundle: nil)
        let productViewController = storyboard.instantiateViewControllerWithIdentifier("ProductViewController")
        parent.navigationController?.showViewController(productViewController, sender: parent)
    }
        
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
