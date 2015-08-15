//
//  ScanViewController.swift
//  Rattvisekollen
//
//  Created by Fredrik Bystam on 15/08/15.
//  Copyright © 2015 nickenil_byrreb. All rights reserved.
//

import UIKit
import AVFoundation

class ScanViewController: UIViewController, BarcodeOutputDelegate {
    
    @IBOutlet weak var cameraLayerView: UIView!
    
    var barcodeScanner: BarcodeScanner!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.barcodeScanner = BarcodeScanner(previewView: self.cameraLayerView, delegate: self)
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
}
