//
//  CircleView.swift
//  Rattvisekollen
//
//  Created by Fredrik Bystam on 16/08/15.
//  Copyright © 2015 nickenil_byrreb. All rights reserved.
//

import UIKit

@IBDesignable
class CircleView: UIView {

    override func layoutSubviews() {
        super.layoutSubviews()
        self.layer.cornerRadius = self.bounds.size.width/2
    }
}
