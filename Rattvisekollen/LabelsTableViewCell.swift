//
//  LabelsTableViewCell.swift
//  Rattvisekollen
//
//  Created by Fredrik Bystam on 23/08/15.
//  Copyright © 2015 nickenil_byrreb. All rights reserved.
//

import UIKit

class LabelsTableViewCell: UITableViewCell {

    var labelsViewController: LabelCollectionViewController?

    override func awakeFromNib() {
        super.awakeFromNib()
        self.labelsViewController = LabelCollectionViewController.createFromBundle()
    }

    func configureWithParent(parent: UIViewController, labels: [Label]) {
        let labelsVC = self.labelsViewController!
        labelsVC.labels = labels

        labelsVC.view.frame = self.bounds
        self.addSubview(labelsVC.view)
        parent.addChildViewController(labelsVC)
        labelsVC.didMoveToParentViewController(parent)
    }
}
