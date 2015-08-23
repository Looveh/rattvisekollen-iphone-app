//
//  ProductViewController.swift
//  Rattvisekollen
//
//  Created by Fredrik Bystam on 16/08/15.
//  Copyright © 2015 nickenil_byrreb. All rights reserved.
//

import UIKit

enum ProductSection: Int {
    case Labels = 0, Summary = 1, Ingredients = 2
}

class ProductViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var productNameLabel: UILabel!

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var parallaxHeaderView: ParallaxHeaderView!

    @IBOutlet weak var labelThumbnailStackView: UIStackView!
    var labelsShowing: Bool = false

    var product: Product? = nil

    class func pushFromViewController(parent: UIViewController, forProduct product: Product) {
        let storyboard = UIStoryboard(name: "Product", bundle: nil)
        let productViewController = storyboard.instantiateViewControllerWithIdentifier("ProductViewController") as! ProductViewController
        productViewController.product = product

        parent.navigationController?.showViewController(productViewController, sender: parent)
    }
        
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupTitleView()
        self.setupParallaxHeaderView()
        self.setupLabelThumbnails()
        self.productNameLabel.text = self.product!.name
        
        
        self.tableView.registerNib(UINib(nibName: "IngredientsHeaderView", bundle: nil), forHeaderFooterViewReuseIdentifier: "ingredientsHeaderView");
        self.tableView.registerNib(UINib(nibName: "IngredientsFooterView", bundle: nil), forHeaderFooterViewReuseIdentifier: "ingredientsFooterView");
    }

    // MARK: Parallax header
    
    func setupTitleView() {
        let title = UILabel()
        title.text = self.product?.name
        title.font = UIFont.boldSystemFontOfSize(17)
        title.textColor = self.navigationController?.navigationBar.tintColor
        title.sizeToFit()
        title.hidden = true
        self.navigationItem.titleView = title
    }
    
    func setNavbarTitleVisible(parallaxContentVisible: Bool) {
        if (!parallaxContentVisible) {
            self.navigationItem.titleView?.hidden = false
            self.navigationItem.titleView?.alpha = 0.0
        }

        UIView.animateWithDuration(0.3) { () -> Void in
            self.navigationItem.titleView?.alpha = !parallaxContentVisible ? 1.0 : 0.0
        }
    }
    
    func setupParallaxHeaderView() {
        self.parallaxHeaderView.contentVisibilityHandler = self.setNavbarTitleVisible
        (self.tableView.tableHeaderView as! TouchRedirectView).targetView = self.parallaxHeaderView
    }
    
    func setupLabelThumbnails() {
        guard let labels = self.product?.labels else {
            return
        }
        for label in labels {
            let imageView = UIImageView(image: label.loadThumbnail())
            imageView.contentMode = .ScaleAspectFit
            self.labelThumbnailStackView.addArrangedSubview(imageView)
        }
    }
    
    // MARK: Show labels
    
    @IBAction func showLabelsButtonPressed(sender: UIButton) {
        self.labelsShowing = !self.labelsShowing
        self.tableView.beginUpdates()
        self.tableView.endUpdates()

        UIView.animateWithDuration(0.3) {
            self.parallaxHeaderView.layoutForScrollOffset(self.tableView.contentOffset)
            self.parallaxHeaderView.layoutIfNeeded()
        }

        UIView.animateWithDuration(0.4, delay: 0.0, usingSpringWithDamping: 0.5, initialSpringVelocity: 1.0, options: .CurveEaseInOut, animations: {
            self.labelThumbnailStackView.transform = self.labelsShowing ? CGAffineTransformMakeScale(1.1, 1.1) : CGAffineTransformIdentity
            self.labelThumbnailStackView.alpha = self.labelsShowing ? 1.0 : 0.6
        }, completion:nil)
    }
    
    
    // MARK: UITableViewDataSource
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch ProductSection(rawValue: section)! {
        case .Labels: return 1
        case .Summary: return 1
        case .Ingredients: return self.product!.ingredients.count
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let section = ProductSection(rawValue: indexPath.section)

        if section == .Labels {
            let cell = tableView.dequeueReusableCellWithIdentifier("labelsCell") as! LabelsTableViewCell
            cell.configureWithParent(self, labels: (self.product?.labels)!)
            return cell
        } else if section == .Summary {
            let cell = tableView.dequeueReusableCellWithIdentifier("summaryCell") as! ProductSummaryTableViewCell
            cell.configureWithProduct(self.product!)
            return cell
        } else if (section == .Ingredients) {
            let cell = tableView.dequeueReusableCellWithIdentifier("IngredientTableViewCell") as! IngredientTableViewCell
            cell.configureWithIngredient(self.product!.ingredients[indexPath.row])
            return cell
        }
        return UITableViewCell()
    }
    
    // MARK: UITableViewDelegate
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        switch ProductSection(rawValue: indexPath.section)! {
        case .Labels: return self.labelsShowing ? 200 : 0
        case .Summary: return 100
        case .Ingredients: return 20
        }
    }

    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if (ProductSection(rawValue: section) == .Ingredients) {
            return tableView.dequeueReusableHeaderFooterViewWithIdentifier("ingredientsHeaderView")
        }
        return nil
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if (ProductSection(rawValue: section) == .Ingredients) {
            return 40
        }
        return 0
    }
    
    // MARK: UIScrollViewDelegate
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        self.parallaxHeaderView.layoutForScrollOffset(scrollView.contentOffset)
    }
}
