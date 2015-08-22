//
//  ParallaxHeaderView.swift
//  Rattvisekollen
//
//  Created by Fredrik Bystam on 22/08/15.
//  Copyright © 2015 nickenil_byrreb. All rights reserved.
//

import UIKit

class ParallaxHeaderView: UIView {
    
    var heightConstraint: NSLayoutConstraint?
    var baseHeight: CGFloat = 0.0

    internal func install() {
        for constraint in self.constraints {
            if (constraint.firstItem as! NSObject) == self && constraint.firstAttribute == .Height {
                self.heightConstraint = constraint
                self.baseHeight = constraint.constant
                break
            }
        }
    }
    
    internal func layoutForScrollOffset(offset: CGPoint) {
        let height = self.baseHeight - offset.y
        self.heightConstraint?.constant = max(height, 0.0)
    }
}
