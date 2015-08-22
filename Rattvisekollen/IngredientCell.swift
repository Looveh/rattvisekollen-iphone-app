//
//  IngredientCell.swift
//  Rattvisekollen
//
//  Created by Fredrik Bystam on 22/08/15.
//  Copyright © 2015 nickenil_byrreb. All rights reserved.
//

import UIKit

class IngredientCell: UITableViewCell {
    
    @IBOutlet weak var ingredientLabel: UILabel!
    
    internal func configureWithIngredient(ingredient: String) {
        self.ingredientLabel.text = ingredient
    }
}
