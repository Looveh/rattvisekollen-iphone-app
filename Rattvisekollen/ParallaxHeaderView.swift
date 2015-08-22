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
        let height = max(self.baseHeight - offset.y, 0.0)
        self.heightConstraint?.constant = height

        var alpha = (height - 0.2 * self.baseHeight) / (0.4 * self.baseHeight)
        alpha = min(max(alpha, 0.0), 1.0)

        for view in self.subviews {
            view.alpha = alpha
        }
    }
}
