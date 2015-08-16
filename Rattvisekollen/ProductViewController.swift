//
//  ProductViewController.swift
//  Rattvisekollen
//
//  Created by Fredrik Bystam on 16/08/15.
//  Copyright © 2015 nickenil_byrreb. All rights reserved.
//

import UIKit

class ProductViewController: UIViewController {

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var scoreSliderStackView: UIStackView!
    
    var sliders: [ScoreSliderView]?

    class func pushFromViewController(parent: UIViewController, forProductCode product: NSString) {
        let storyboard = UIStoryboard(name: "Product", bundle: nil)
        let productViewController = storyboard.instantiateViewControllerWithIdentifier("ProductViewController")
        parent.navigationController?.showViewController(productViewController, sender: parent)
    }
        
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = Theme.darkGreen()
        self.setupScoreSliders()
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)

        var delay = 0.15
        for slider: ScoreSliderView in self.sliders! {
            slider.animateSlideWithDelay(delay)
            delay += 0.10
        }
    }
    
    func setupScoreSliders() {
        let c1 = UIColor(red: 113.0/255, green: 160.0/255, blue: 113.0/255, alpha: 1.0)
        let c2 = UIColor(red: 83.0/255, green: 113.0/255, blue: 151.0/255, alpha: 1.0)
        let c3 = UIColor(red: 52.0/255, green: 70.0/255, blue: 92.0/255, alpha: 1.0)
        let slider1 = ScoreSliderView.sliderWithScore(4, color: c1)
        let slider2 = ScoreSliderView.sliderWithScore(8, color: c2)
        let slider3 = ScoreSliderView.sliderWithScore(3, color: c3)

        self.scoreSliderStackView.addArrangedSubview(slider1)
        self.scoreSliderStackView.addArrangedSubview(slider2)
        self.scoreSliderStackView.addArrangedSubview(slider3)
        self.scoreSliderStackView.layoutIfNeeded()
        
        self.sliders = [slider1, slider2, slider3]
    }
}
