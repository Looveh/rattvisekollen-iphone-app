//
//  LabelCollectionViewCell.swift
//  Rattvisekollen
//
//  Created by Fredrik Bystam on 23/08/15.
//  Copyright © 2015 nickenil_byrreb. All rights reserved.
//

import UIKit

class LabelCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var explanationLabel: UILabel!

    func configureWithlabel(label: Label) {
        self.explanationLabel.text = label.explanation
        self.imageView.image = label.loadImage()
    }
}
