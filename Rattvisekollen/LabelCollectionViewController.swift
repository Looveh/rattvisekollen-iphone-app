//
//  LabelCollectionViewController.swift
//  Rattvisekollen
//
//  Created by Fredrik Bystam on 23/08/15.
//  Copyright © 2015 nickenil_byrreb. All rights reserved.
//

import UIKit

private let reuseIdentifier = "Cell"

class LabelCollectionViewController: UICollectionViewController {
    
    internal var labels: [Label] = []

    class func createFromBundle() -> LabelCollectionViewController {
        let storyboard = UIStoryboard(name: "Product", bundle: nil)
        let labelVC = storyboard.instantiateViewControllerWithIdentifier("labelViewController") as! LabelCollectionViewController
        return labelVC
    }
    
    // MARK: UICollectionViewDataSource

    override func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }

    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.labels.count
    }

    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("labelCell", forIndexPath: indexPath) as! LabelCollectionViewCell
        cell.configureWithlabel(self.labels[indexPath.item])
        return cell
    }
}
