//
//  Label.swift
//  Rattvisekollen
//
//  Created by Fredrik Bystam on 23/08/15.
//  Copyright © 2015 nickenil_byrreb. All rights reserved.
//

import UIKit

class Label: NSObject {
    
    static let labels = Label.createLabels()
    
    let id: String
    let name: String
    let explanation: String
    let imageName: String
    
    required init(id: String, name: String, explanation: String, imageName: String) {
        self.id = id
        self.name = name
        self.explanation = explanation
        self.imageName = imageName
    }
    
    func loadImage() -> UIImage {
        return UIImage(named: self.imageName)!
    }
    
    func loadThumbnail() -> UIImage {
        return UIImage(named: "\(self.imageName)-thumbnail")!
    }

    class func createLabels() -> [String : Label] {
        return [
            "krav" : Label(id: "krav", name: "Krav", explanation: "Varan är tillverkad med höga krav på djuromsorg, hälsa, socialt ansvar och klimatpåverkan", imageName: "krav"),
            "euleaf" : Label(id: "euleaf", name: "EU-lövet", explanation: "Varan är tillverkad med bra förhållande för bönderna", imageName: "euleaf"),
            "nyckel" : Label(id: "nyckel", name: "Nyckelhålet", explanation: "Älska nyckelhål vafan", imageName: "nyckel")
        ]
    }
    
    class func labelWithId(id: String) -> Label {
        return Label.labels[id]!
    }
}
