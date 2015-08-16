//
//  Theme.swift
//  Rattvisekollen
//
//  Created by Fredrik Bystam on 15/08/15.
//  Copyright © 2015 nickenil_byrreb. All rights reserved.
//

import UIKit

class Theme: NSObject {
    
    class func setupAppearance(window: UIWindow) {
        window.tintColor = self.darkGreen()
        
        let navbarAppearance = UINavigationBar.appearanceWhenContainedInInstancesOfClasses([UINavigationController.self])
        navbarAppearance.setBackgroundImage(self.resizableImageWithColor(self.darkGreen()), forBarMetrics: UIBarMetrics.Default)
        navbarAppearance.shadowImage = UIImage()
        navbarAppearance.tintColor = self.backgroundColor()
        navbarAppearance.titleTextAttributes = [ NSForegroundColorAttributeName : UIColor.whiteColor() ]
        
        UIApplication.sharedApplication().statusBarStyle = UIStatusBarStyle.LightContent
    }

    class func green() -> UIColor {
        return UIColor(red: 160.0/255, green: 198.0/255, blue: 156.0/255, alpha: 1.0)
    }

    class func darkGreen() -> UIColor {
        return UIColor(red: 39.0/255, green: 117.0/255, blue: 84.0/255, alpha: 1.0)
    }
    
    class func backgroundColor() -> UIColor {
        return UIColor(red: 252.0/255, green: 255.0/255, blue: 250.0/255, alpha: 1.0)
    }
    
    class func resizableImageWithColor(color: UIColor) -> UIImage {
        UIGraphicsBeginImageContext(CGSize(width: 100, height: 100))
        color.setFill()
        UIRectFill(CGRect(x: 0, y: 0, width: 100, height: 100))
        let image = UIGraphicsGetImageFromCurrentImageContext().resizableImageWithCapInsets(UIEdgeInsetsZero, resizingMode: UIImageResizingMode.Stretch)
        UIGraphicsEndImageContext()
        return image
    }
}
