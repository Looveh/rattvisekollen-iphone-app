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
        window.tintColor = self.primaryColor()
        
        let navbarAppearance = UINavigationBar.appearanceWhenContainedInInstancesOfClasses([UINavigationController.self])
        navbarAppearance.setBackgroundImage(self.resizableImageWithColor(self.primaryColor()), forBarMetrics: UIBarMetrics.Default)
        navbarAppearance.shadowImage = UIImage()
        navbarAppearance.tintColor = self.backgroundColor()
        navbarAppearance.titleTextAttributes = [ NSForegroundColorAttributeName : UIColor.whiteColor() ]
        
        UIApplication.sharedApplication().statusBarStyle = UIStatusBarStyle.LightContent
    }

    class func primaryColor() -> UIColor {
        return color(95, g: 120, b: 178)
    }
    
    class func lightColor() -> UIColor {
        return color(143, g: 194, b: 255)
    }

    class func lightComplementaryColor() -> UIColor {
        return color(255, g: 241, b: 213)
    }

    class func backgroundColor() -> UIColor {
        return color(255, g: 252, b: 248)
    }
    
    class func color(r: Int, g: Int, b: Int) -> UIColor {
        return UIColor(red: CGFloat(r)/255, green: CGFloat(g)/255, blue: CGFloat(b)/255, alpha: 1.0)
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
