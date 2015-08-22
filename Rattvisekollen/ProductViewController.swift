//
//  ProductViewController.swift
//  Rattvisekollen
//
//  Created by Fredrik Bystam on 16/08/15.
//  Copyright © 2015 nickenil_byrreb. All rights reserved.
//

import UIKit

class ProductViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    class func pushFromViewController(parent: UIViewController, forProductCode product: NSString) {
        let storyboard = UIStoryboard(name: "Product", bundle: nil)
        let productViewController = storyboard.instantiateViewControllerWithIdentifier("ProductViewController")
        parent.navigationController?.showViewController(productViewController, sender: parent)
    }
        
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: UITableViewDataSource
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0: return 1
        case 1: return 3
        default: return 0
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if (indexPath.section == 0) {
            return tableView.dequeueReusableCellWithIdentifier("summaryCell")!
        }
        return tableView.dequeueReusableCellWithIdentifier("ingredientCell")!
    }
    
    // MARK: UITableViewDelegate
}
