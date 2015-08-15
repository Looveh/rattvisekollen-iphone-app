//
//  ScanViewModalAnimation.swift
//  Rattvisekollen
//
//  Created by Fredrik Bystam on 15/08/15.
//  Copyright © 2015 nickenil_byrreb. All rights reserved.
//

import UIKit

class ScanViewModalAnimation: NSObject, UIViewControllerAnimatedTransitioning {
    
    internal var isPresenting: Bool = false
    
    func transitionDuration(transitionContext: UIViewControllerContextTransitioning?) -> NSTimeInterval {
        return self.isPresenting ? 0.6 : 0.3
    }
    
    func animateTransition(transitionContext: UIViewControllerContextTransitioning) {
        let fromViewController = transitionContext.viewControllerForKey(UITransitionContextFromViewControllerKey)!
        let toViewController = transitionContext.viewControllerForKey(UITransitionContextToViewControllerKey)!
        
        if (self.isPresenting) {
            let scanViewController = toViewController as! ScanViewController
            transitionContext.containerView()?.addSubview(scanViewController.view)
            scanViewController.view.layoutIfNeeded()
            
            scanViewController.infoLabel.transform = CGAffineTransformMakeTranslation(0, 15)
            scanViewController.closeButton.transform = CGAffineTransformMakeTranslation(0, -15)
            scanViewController.view.alpha = 0.0
            UIView.animateWithDuration(0.2, animations: { () -> Void in
                scanViewController.view.alpha = 1.0
                scanViewController.infoLabel.transform = CGAffineTransformIdentity
                scanViewController.closeButton.transform = CGAffineTransformIdentity
            })

            scanViewController.maskView.transform = CGAffineTransformMakeScale(1.0, CGFloat.min)
            UIView.animateWithDuration(0.5, delay: 0.1, usingSpringWithDamping:0.6, initialSpringVelocity: 2.0, options: UIViewAnimationOptions.CurveEaseInOut, animations: { () -> Void in
                scanViewController.maskView.transform = CGAffineTransformIdentity
                }, completion: { (_) -> Void in
                    transitionContext.completeTransition(true)
            })
        } else {
            UIView.animateWithDuration(0.3, animations: { () -> Void in
                fromViewController.view.alpha = 0.0
                }, completion: { (success: Bool) -> Void in
                    transitionContext.completeTransition(true)
            })
        }
    }
}
