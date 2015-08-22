//
//  ProductViewController.swift
//  Rattvisekollen
//
//  Created by Fredrik Bystam on 16/08/15.
//  Copyright © 2015 nickenil_byrreb. All rights reserved.
//

import UIKit

class ProductViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var productNameLabel: UILabel!

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var parallaxHeaderView: ParallaxHeaderView!

    var product: Product? = nil

    class func pushFromViewController(parent: UIViewController, forProduct product: Product) {
        let storyboard = UIStoryboard(name: "Product", bundle: nil)
        let productViewController = storyboard.instantiateViewControllerWithIdentifier("ProductViewController") as! ProductViewController
        productViewController.product = product

        parent.navigationController?.showViewController(productViewController, sender: parent)
    }
        
    override func viewDidLoad() {
        super.viewDidLoad()
        self.productNameLabel.text = self.product!.name
        self.parallaxHeaderView.install()
        
        self.tableView.registerNib(UINib(nibName: "IngredientsHeaderView", bundle: nil), forHeaderFooterViewReuseIdentifier: "ingredientsHeaderView");
        self.tableView.registerNib(UINib(nibName: "IngredientsFooterView", bundle: nil), forHeaderFooterViewReuseIdentifier: "ingredientsFooterView");
    }
    
    // MARK: UITableViewDataSource
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0: return 1
        case 1: return self.product!.ingredients.count
        default: return 0
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if (indexPath.section == 0) {
            return tableView.dequeueReusableCellWithIdentifier("summaryCell")!
        }

        let cell = tableView.dequeueReusableCellWithIdentifier("ingredientCell") as! IngredientCell
        cell.configureWithIngredient(self.product!.ingredients[indexPath.row])
        return cell
    }
    
    // MARK: UITableViewDelegate
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if (indexPath.section == 0) {
            return 160
        }
        return 30
    }

    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if (section == 1) {
            return tableView.dequeueReusableHeaderFooterViewWithIdentifier("ingredientsHeaderView")
        }
        return nil
    }

    func tableView(tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        if (section == 1) {
            return tableView.dequeueReusableHeaderFooterViewWithIdentifier("ingredientsFooterView")
        }
        return nil
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return section == 1 ? 50 : 0
    }
    
    func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return section == 1 ? 20 : 0
    }
    
    // MARK: UIScrollViewDelegate
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        self.parallaxHeaderView.layoutForScrollOffset(scrollView.contentOffset)
    }
}
