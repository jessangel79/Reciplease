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
    @IBOutlet weak var titleRecipeLabel: UILabel!
    @IBOutlet weak var ingredientsLabel: UILabel!
    @IBOutlet weak var yieldLabel: UILabel!
    @IBOutlet weak var totalTimeLabel: UILabel!
    @IBOutlet weak var grayView: UIView!
    
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
//            let totalTimeInt = Int(recipeEntity?.totalTime ?? 0)
            totalTimeLabel.text = Int(recipeEntity?.totalTime ?? 0).convertTimeToString
            recipeImageView.load(urlImageString: recipeEntity?.image)
        }
    }
    
    // A supprimer
//    func configure(title: String, ingredients: String, yield: Int, totalTime: Int?, image: String?) {
//        titleRecipeLabel.text = title.localizedCapitalized
//        ingredientsLabel.text = ingredients
//        yieldLabel.text = String(yield)
//        recipeImageView.load(urlImageString: image ?? "ImageDefault1024x768" + ".jpg")
//        calcTotalTime(totalTime ?? 0, totalTimeLabel: totalTimeLabel)
//        
////        listRecipesCell.configure(title: recipes.recipe.label,
////                                  ingredients: ingredients,
////                                  yield: recipes.recipe.yield,
////                                  totalTime: recipes.recipe.totalTime ?? 0,
////                                  image: recipes.recipe.image ?? "ImageDefault1024x768" + ".jpg")
//    }
}
