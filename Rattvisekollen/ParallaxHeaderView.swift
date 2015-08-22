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

    var visible: Bool = true
    var contentVisibilityHandler: ((visible: Bool) -> Void)?

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

        if (alpha < 0.01 && self.visible) {
            self.visible = false
            self.contentVisibilityHandler?(visible: false)
        } else if (alpha > 0.05 && !self.visible) {
            self.visible = true
            self.contentVisibilityHandler?(visible: true)
        }
    }
}
