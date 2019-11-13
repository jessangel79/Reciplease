//
//  ListRecipesTableViewCell.swift
//  Reciplease
//
//  Created by Angelique Babin on 17/10/2019.
//  Copyright © 2019 Angelique Babin. All rights reserved.
//

import UIKit

final class ListRecipesTableViewCell: UITableViewCell {
    
    @IBOutlet private weak var recipeImageView: UIImageView!
    @IBOutlet private weak var titleRecipeLabel: UILabel!
    @IBOutlet private weak var ingredientsLabel: UILabel!
    @IBOutlet private weak var yieldLabel: UILabel!
    @IBOutlet private weak var totalTimeLabel: UILabel!
    @IBOutlet private weak var grayView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        customViewCell(view: grayView)
    }
    
    var recipe: Recipe? {
        didSet {
            titleRecipeLabel.text = recipe?.label.localizedCapitalized
            ingredientsLabel.text = recipe?.ingredientLines.joined(separator: ", ")
            yieldLabel.text = String(recipe?.yield ?? 0)
            totalTimeLabel.text = (recipe?.totalTime ?? 0).convertTimeToString
            recipeImageView.load(urlImageString: recipe?.image ?? "ImageDefault1024x768" + ".jpg")
        }
    }

    var recipeEntity: RecipeEntity? {
        didSet {
            titleRecipeLabel.text = recipeEntity?.title
            ingredientsLabel.text = recipeEntity?.ingredients
            yieldLabel.text = String(recipeEntity?.yield ?? 0)
            totalTimeLabel.text = Int(recipeEntity?.totalTime ?? 0).convertTimeToString
            recipeImageView.load(urlImageString: recipeEntity?.image)
        }
    }
}
