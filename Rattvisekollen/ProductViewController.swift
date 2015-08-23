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
            self.labelThumbnailStackView.alpha = self.labelsShowing ? 1.0 : 0.7
        }, completion:nil)
    }
    
    
    // MARK: UITableViewDataSource
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0: return 1// self.labelsShowing ? 1 : 0
        case 1: return self.product!.ingredients.count
        default: return 0
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if (indexPath.section == 0) {
            let cell = tableView.dequeueReusableCellWithIdentifier("summaryCell") as! LabelsTableViewCell
            cell.configureWithParent(self, labels: (self.product?.labels)!)
            return cell
        }

        let cell = tableView.dequeueReusableCellWithIdentifier("IngredientTableViewCell") as! IngredientTableViewCell
        cell.configureWithIngredient(self.product!.ingredients[indexPath.row])
        return cell
    }
    
    // MARK: UITableViewDelegate
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if (indexPath.section == 0) {
            return self.labelsShowing ? 200 : 0.0
        }
        return 20
    }

    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if (section == 1) {
            return tableView.dequeueReusableHeaderFooterViewWithIdentifier("ingredientsHeaderView")
        }
        return nil
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return section == 1 ? 40 : 0
    }
    
    // MARK: UIScrollViewDelegate
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        self.parallaxHeaderView.layoutForScrollOffset(scrollView.contentOffset)
    }
}
