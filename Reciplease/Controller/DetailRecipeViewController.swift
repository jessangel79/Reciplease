//
//  DetailRecipeViewController.swift
//  Reciplease
//
//  Created by Angelique Babin on 21/10/2019.
//  Copyright © 2019 Angelique Babin. All rights reserved.
//

import UIKit

class DetailRecipeViewController: UIViewController {
    
    // MARK: - Outlets
    
    @IBOutlet weak var grayView: UIView!
    @IBOutlet weak var getDirectionsButton: UIButton!
    @IBOutlet weak var favoritesBarButtonItem: UIBarButtonItem!
    @IBOutlet weak var recipeImageView: UIImageView!
    @IBOutlet weak var totalTimeLabel: UILabel!
    @IBOutlet weak var yieldLabel: UILabel!
    @IBOutlet weak var titleRecipeLabel: UILabel!
    @IBOutlet weak var ingredientsTextView: UITextView!
    
    // MARK: - Properties

    var cellule: Hit!
    var coreDataManager: CoreDataManager?
    var recipeIsFavorite = false
    
    // MARK: - Actions
    @IBAction func getDirectionsButtonTapped(_ sender: UIButton) {
        webViewRecipe(urlString: cellule.recipe.url)
    }
    
    @IBAction func favoritesBarButtonItemTapped(_ sender: UIBarButtonItem) {
        checkIfRecipeIsFavorite()
//        !recipeIsFavorite ? addRecipeToFavorites() : deleteRecipeFavorite()
        !recipeIsFavorite ? addRecipeToFavorites() : deleteRecipeFavorite(recipeTitle: cellule?.recipe.label,
                                                                          url: cellule?.recipe.url,
                                                                          coreDataManager: coreDataManager,
                                                                          barButtonItem: favoritesBarButtonItem)
    }
    
    // MARK: - Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        coreDataFunction()
        
        customView(view: grayView)
        customButton(button: getDirectionsButton)
        configureRecipe()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        checkIfRecipeIsFavorite()
    }
    
    private func coreDataFunction() {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let coreDataStack = appDelegate.coreDataStack
        coreDataManager = CoreDataManager(coreDataStack: coreDataStack)
    }

    private func configureRecipe() {
        titleRecipeLabel.text = cellule.recipe.label.localizedCapitalized
        ingredientsTextView.text = "- " + cellule.recipe.ingredientLines.joined(separator: "\n" + "- ")
        yieldLabel.text = String(cellule.recipe.yield)
        let totalTimeInt = Int(cellule.recipe.totalTime ?? 0)
        totalTimeLabel.text = totalTimeInt.convertTimeToString
        recipeImageView.load(urlImageString: cellule.recipe.image ?? "ImageDefault1024x768" + ".jpg")
    }
    
//    private func listOfIngredients() -> String {
//        var listRecipe = String()
//        for ingredient in cellule.recipe.ingredientLines {
//            listRecipe += "- " + ingredient + "\n"
//        }
//        return listRecipe
//    }
    
    private func checkIfRecipeIsFavorite() {
        guard let recipeTitle = cellule?.recipe.label else { return }
        guard let url = cellule?.recipe.url else { return }
        guard let checkIsRecipeIsFavorite = coreDataManager?.checkIsRecipeIsFavorite(
            recipeTitle: recipeTitle, url: url) else { return }

        recipeIsFavorite = checkIsRecipeIsFavorite

        if recipeIsFavorite {
            favoritesBarButtonItem.tintColor = UIColor.green
        } else {
            favoritesBarButtonItem.tintColor = .none
        }
    }
    
    private func addRecipeToFavorites() {
//        let ingredients = listOfIngredients()
//        let ingredients = cellule.recipe.ingredientLines.joined(separator: ", ")
        let ingredients = "- " + cellule.recipe.ingredientLines.joined(separator: "\n" + "- ")
        let totalTime = Int16(cellule.recipe.totalTime?.convertTimeToString ?? "") ?? 0
        let image = cellule.recipe.image ?? "ImageDefault1024x768" + ".jpg"
        let yield = Int16(cellule.recipe.yield)
        let url = cellule.recipe.url
        coreDataManager?.createRecipe(title: cellule.recipe.label,
                                      ingredients: ingredients,
                                      yield: yield,
                                      totalTime: totalTime,
                                      image: image, url: url)
        setupBarButtonItem(color: .green, barButtonItem: favoritesBarButtonItem)
        
        debugFavorites(titleDebug: "Favorite created", coreDataManager: coreDataManager)
    }

//    private func deleteRecipeFavorite() {
//        guard let recipeTitle = cellule?.recipe.label else { return }
//        guard let image = cellule?.recipe.image else { return }
//        coreDataManager?.deleteRecipe(recipeTitle: recipeTitle, image: image)
//        setupBarButtonItem(color: .white)
//
//        debugFavorites(titleDebug: "Favorite deleted !!! ", coreDataManager: coreDataManager)
//    }
//
//    fileprivate func setupBarButtonItem(color: UIColor) {
//        favoritesBarButtonItem.tintColor = color
//        navigationItem.rightBarButtonItem = favoritesBarButtonItem
//    }
}
    
// MARK: - In extension UIResponder
//    fileprivate func calcTotalTime(_ totalTime: Int) {
//        let totalTimeTemp = totalTime
//        if totalTimeTemp < 60 {
//            totalTimeLabel.text = String(totalTimeTemp) + " min"
//        } else {
//            totalTimeLabel.text = String(totalTimeTemp / 60) + " h"
//        }
//    }
