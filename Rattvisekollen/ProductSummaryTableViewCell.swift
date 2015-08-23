//
//  ProductSummaryTableViewCell.swift
//  Rattvisekollen
//
//  Created by Fredrik Bystam on 23/08/15.
//  Copyright © 2015 nickenil_byrreb. All rights reserved.
//

import UIKit

class ProductSummaryTableViewCell: UITableViewCell {

    @IBOutlet weak var manufacturerLabel: UILabel!
    @IBOutlet weak var originLabel: UILabel!

    func configureWithProduct(product: Product) {
        self.manufacturerLabel.text = product.manufacturer
        self.originLabel.text = product.origin
    }
}
