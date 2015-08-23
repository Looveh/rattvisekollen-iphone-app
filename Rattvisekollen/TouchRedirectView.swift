//
//  TouchRedirectView.swift
//  Rattvisekollen
//
//  Created by Fredrik Bystam on 23/08/15.
//  Copyright © 2015 nickenil_byrreb. All rights reserved.
//

import UIKit

class TouchRedirectView: UIView {
    
    var targetView: UIView?

    override func hitTest(point: CGPoint, withEvent event: UIEvent?) -> UIView? {
        if self.targetView != nil {
            let targetPoint = self.convertPoint(point, toView: self.targetView)
            if self.pointInside(targetPoint, withEvent: event) {
                return self.targetView?.hitTest(targetPoint, withEvent: event)
            }
        }
        return super.hitTest(point, withEvent: event)
    }
}
