//
//  ViewController.swift
//  Rattvisekollen
//
//  Created by Fredrik Bystam on 15/08/15.
//  Copyright © 2015 nickenil_byrreb. All rights reserved.
//

import UIKit

class StartViewController: UIViewController {

    @IBOutlet weak var barcodeButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupButton()
    }
    
    func setupButton() {
        self.barcodeButton.layer.borderWidth = 1.0
        self.barcodeButton.layer.borderColor = Theme.darkGreen().CGColor
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.barcodeButton.layer.cornerRadius = self.self.barcodeButton.bounds.height/2
    }
}

