//
//  ScanViewController.swift
//  Rattvisekollen
//
//  Created by Fredrik Bystam on 15/08/15.
//  Copyright © 2015 nickenil_byrreb. All rights reserved.
//

import UIKit

class ScanViewController: UIViewController, BarcodeOutputDelegate, UIViewControllerTransitioningDelegate {
    
    @IBOutlet weak var cameraLayerView: UIView!
    @IBOutlet weak var maskViewPositionView: UIView!

    @IBOutlet internal weak var closeButton: UIButton!
    @IBOutlet internal weak var infoLabel: UILabel!
    
    internal var maskView: UIView!
    var barcodeScanner: BarcodeScanner!
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.modalPresentationStyle = .Custom
        self.transitioningDelegate = self
    }
    
    class func startScanningFromViewController(presentingViewController: UIViewController) {
        let storyboard = UIStoryboard(name: "Scanner", bundle: nil)
        let scanViewController = storyboard.instantiateInitialViewController()!
        presentingViewController.presentViewController(scanViewController, animated: true, completion: nil)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.barcodeScanner = BarcodeScanner(previewView: self.cameraLayerView, delegate: self)
        self.setupMaskView()
        self.setupCloseButton()
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        self.barcodeScanner.startScanning()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)

        NSNotificationCenter.defaultCenter().addObserver(self, selector: "onApplicationWillEnterForeground", name:UIApplicationWillEnterForegroundNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "onApplicationDidEnterBackground", name: UIApplicationDidEnterBackgroundNotification, object: nil)
    }
    
    override func viewDidDisappear(animated: Bool) {
        super.viewDidDisappear(animated)
        
        NSNotificationCenter.defaultCenter().removeObserver(self, name: UIApplicationWillEnterForegroundNotification, object: nil)
        NSNotificationCenter.defaultCenter().removeObserver(self, name: UIApplicationDidEnterBackgroundNotification, object: nil)
    }
    
    // MARK: View setup
    
    func setupCloseButton() {
        self.closeButton.layer.cornerRadius = 4.0
        self.closeButton.layer.borderWidth = 0.5
        self.closeButton.layer.borderColor = Theme.lightGreen().CGColor
        self.closeButton.setTitleColor(Theme.darkGreen(), forState: UIControlState.Normal)
        self.closeButton.backgroundColor = Theme.backgroundColor()
    }
    
    func setupMaskView() {
        self.maskView = UIView()
        self.maskView.layer.cornerRadius = 6.0
        self.maskView.backgroundColor = UIColor.whiteColor()
        
        self.cameraLayerView.maskView = maskView;
    }
    
    override func viewDidLayoutSubviews() {
        super.viewWillLayoutSubviews()
        self.maskView.frame = self.maskViewPositionView.frame
    }
    
    // MARK: Actions
    
    @IBAction func closeButtonPressed(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil);
    }
    
    func onApplicationWillEnterForeground() {
        self.barcodeScanner.startScanning()
    }
    
    func onApplicationDidEnterBackground() {
        self.barcodeScanner.stopScanning();
    }
    
    // MARK: BarcodeOutputDelegate
    
    func scannerDidOutputData(data: String) {
        print(data)
    }
    
    // MARK : UIViewControllerTransitioningDelegate
    
    func animationControllerForPresentedController(presented: UIViewController, presentingController presenting: UIViewController, sourceController source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        let animation = ScanViewModalAnimation()
        animation.isPresenting = true
        return animation
    }
    
    func animationControllerForDismissedController(dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        let animation = ScanViewModalAnimation()
        animation.isPresenting = false
        return animation
    }
}
