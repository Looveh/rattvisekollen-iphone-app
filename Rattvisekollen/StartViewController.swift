//
//  ViewController.swift
//  Rattvisekollen
//
//  Created by Fredrik Bystam on 15/08/15.
//  Copyright © 2015 nickenil_byrreb. All rights reserved.
//

import UIKit

class StartViewController: UIViewController, ScanViewControllerDelegate {

    @IBOutlet weak var barcodeButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.backBarButtonItem = Theme.emptyTitleBackButton()
        self.view.backgroundColor = Theme.backgroundColor()
        self.setupButton()
    }
    
    func setupButton() {
        self.barcodeButton.layer.borderWidth = 1.0
        self.barcodeButton.layer.borderColor = Theme.primaryColor().CGColor
    }
    
    @IBAction func scanningButtonPressed(sender: AnyObject) {
        ScanViewController.startScanningFromViewController(self, delegate: self)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.barcodeButton.layer.cornerRadius = self.self.barcodeButton.bounds.height/2
    }
    
    
    // MARK: ScanViewControllerDelegate
    
    func scanViewController(scanViewController: ScanViewController, foundBarcode barcode: String) {
        ProductSearchAPI.findProductWithCode(barcode) { (product, error) -> Void in
            if let product = product {
                ProductViewController.pushFromViewController(self, forProduct: product)
            } else {
                print(error)
            }
        }
        
    }
}

