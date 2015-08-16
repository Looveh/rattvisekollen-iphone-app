//
//  ScoreSliderView.swift
//  Rattvisekollen
//
//  Created by Fredrik Bystam on 16/08/15.
//  Copyright © 2015 nickenil_byrreb. All rights reserved.
//

import UIKit

let MAX_SCORE: CGFloat = 10.0

class ScoreSliderView: UIView {

    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var circleView: UIView!
    @IBOutlet weak var scoreSlideBar: UIView!

    var score: Int?
    var color: UIColor?
    
    class func sliderWithScore(score: Int, color: UIColor) -> ScoreSliderView {
        let slider: ScoreSliderView = ScoreSliderView()
        slider.color = color
        slider.score = score

        let view = NSBundle.mainBundle().loadNibNamed("ScoreSliderView", owner: slider, options: nil).first as! UIView
        view.frame = slider.bounds
        slider.addSubview(view)
        slider.setupViews()
        
        return slider
    }

    func setupViews() {
        self.circleView.backgroundColor = self.color
        self.scoreSlideBar.backgroundColor = self.color?.colorWithAlphaComponent(0.7)
        self.scoreSlideBar.transform = CGAffineTransformMakeScale(0.0, 1.0)
        self.scoreLabel.text = self.score?.description

    }
    
    func animateSlideWithDelay(delay: NSTimeInterval) {
        self.scoreSlideBar.layer.anchorPoint = CGPoint(x: 0, y: 0.5)
        var pos: CGPoint = self.scoreSlideBar.layer.position
        pos.x -= self.scoreSlideBar.layer.bounds.width/2
        self.scoreSlideBar.layer.position = pos

        let scoreFraction: CGFloat = CGFloat(self.score!) / MAX_SCORE
        UIView.animateWithDuration(0.5, delay: delay, usingSpringWithDamping: 0.6, initialSpringVelocity: 2.0, options: [], animations: { () -> Void in
            self.scoreSlideBar.transform = CGAffineTransformMakeScale(scoreFraction, 1.0)
        }, completion:nil)
    }
}
