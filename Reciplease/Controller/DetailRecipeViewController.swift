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
                                                                          image: cellule?.recipe.image,
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
        checkIfRecipeIsFavorite()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    private func coreDataFunction() {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let coreDataStack = appDelegate.coreDataStack
        coreDataManager = CoreDataManager(coreDataStack: coreDataStack)
    }

    private func configureRecipe() {
        titleRecipeLabel.text = cellule.recipe.label.localizedCapitalized
        ingredientsTextView.text = listOfIngredients()
        yieldLabel.text = String(cellule.recipe.yield)
        calcTotalTime(cellule.recipe.totalTime ?? 0, totalTimeLabel: totalTimeLabel)
        recipeImageView.load(urlImageString: cellule.recipe.image ?? "ImageDefault1024x768" + ".jpg")
        
//        calcTotalTime(cellule.recipe.totalTime ?? 0)
//        totalTimeLabel.text = String((cellule.recipe.totalTime ?? 0) / 60) + " h"
//        totalTimeLabel.text = String(cellule.recipe.totalTime ?? 0) + " min"
//        totalTimeLabel.text = String(cellule.recipe.totalTime ?? 0)
    }
    
    private func listOfIngredients() -> String {
        var listRecipe = String()
        for ingredient in cellule.recipe.ingredientLines {
            listRecipe += "- " + ingredient + "\n"
        }
        return listRecipe
    }
    
    private func checkIfRecipeIsFavorite() {
        guard let recipeTitle = cellule?.recipe.label else { return }
        guard let image = cellule?.recipe.image else { return }
        guard let checkIsRecipeIsFavorite = coreDataManager?.checkIsRecipeIsFavorite(
            recipeTitle: recipeTitle, image: image) else { return }

        recipeIsFavorite = checkIsRecipeIsFavorite

        if recipeIsFavorite {
            favoritesBarButtonItem.tintColor = UIColor.green
        } else {
            favoritesBarButtonItem.tintColor = .none
        }
    }
    
    private func addRecipeToFavorites() {
        let ingredients = listOfIngredients()
        let totalTime = Int16(cellule.recipe.totalTime ?? 0)
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
    
    /// delete all for tests ### To delete ###
    fileprivate func deleteAllRecipesFavorites() {
        coreDataManager?.deleteAllRecipes()
        print("delete all recipes ok")
    }
    
//    private func webViewRecipe() {
//        let urlString = cellule.recipe.url
//        guard let url = URL(string: urlString) else { return }
//        guard UIApplication.shared.canOpenURL(url) else { return }
//        UIApplication.shared.open(url)
//    }
    
//    /// function to debug ### To delete ###
//    fileprivate func debugFavorites(titleDebug: String) {
//        print(titleDebug)
//        print("--------------------")
//        for recipe in coreDataManager?.recipes ?? [RecipeEntity]() {
//            print("resultat callback :")
//            print(recipe.totalTime)
//            print(recipe.image as Any)
//            print(recipe.yield)
//            print(recipe.title ?? "title error")
//            print(recipe.ingredients ?? "ingredients error")
//            print("\n")
//        }
//    }
}

// MARK: - Navigation

//extension DetailRecipeViewController {
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        if segue.identifier == segueToRecipesList {
//            guard let listRecipesVC = segue.destination as? ListRecipesViewController else { return }
//            listRecipesVC.recipesList = recipesList
//        }
//    }
//}

//        totalTimeLabel.text =  String(cellule.recipe.totalTime ?? 0) + " min"
//        calcTotalTime(cellule.recipe.totalTime ?? 0)
    
// MARK: - In extension UIResponder
//    fileprivate func calcTotalTime(_ totalTime: Int) {
//        let totalTimeTemp = totalTime
//        if totalTimeTemp < 60 {
//            totalTimeLabel.text = String(totalTimeTemp) + " min"
//        } else {
//            totalTimeLabel.text = String(totalTimeTemp / 60) + " h"
//        }
//    }
