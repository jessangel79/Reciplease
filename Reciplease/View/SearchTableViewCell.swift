//
//  SearchTableViewCell.swift
//  Reciplease
//
//  Created by Angelique Babin on 11/10/2019.
//  Copyright © 2019 Angelique Babin. All rights reserved.
//

import UIKit

class SearchTableViewCell: UITableViewCell {
    @IBOutlet weak var ingredientLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configure(withIngredient ingredient: String) {
        ingredientLabel?.text = "- " + ingredient.localizedCapitalized
    }
}
