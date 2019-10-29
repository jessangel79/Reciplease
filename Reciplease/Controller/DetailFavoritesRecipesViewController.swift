//
//  DetailFavoritesRecipesViewController.swift
//  Reciplease
//
//  Created by Angelique Babin on 23/10/2019.
//  Copyright © 2019 Angelique Babin. All rights reserved.
//

import UIKit

class DetailFavoritesRecipesViewController: UIViewController {
    
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

    var cellule: RecipeEntity!
    var celluleHit: Hit!
    var coreDataManager: CoreDataManager?
    var recipeIsFavorite = false
   
    // MARK: - Actions
    @IBAction func getDirectionsButtonTapped(_ sender: UIButton) {
        guard let url = cellule.url else { return }
        webViewRecipe(urlString: url)
    }
    @IBAction func favoritesBarButtonItemTapped(_ sender: UIBarButtonItem) {
        checkIfRecipeIsFavorite()
        deleteRecipeFavorite(recipeTitle: cellule?.title,
                             image: cellule?.image,
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
        titleRecipeLabel.text = cellule?.title
        ingredientsTextView.text = cellule?.ingredients
        yieldLabel.text = String(cellule.yield)
        calcTotalTime(Int(cellule.totalTime), totalTimeLabel: totalTimeLabel)
        recipeImageView.load(urlImageString: cellule.image)
    }

    private func checkIfRecipeIsFavorite() {
        guard let recipeTitle = cellule.title else { return }
        guard let image = cellule.image else { return }
        guard let checkIsRecipeIsFavorite = coreDataManager?.checkIsRecipeIsFavorite(recipeTitle: recipeTitle,
                                                                                     image: image) else { return }

        recipeIsFavorite = checkIsRecipeIsFavorite

        if recipeIsFavorite {
            favoritesBarButtonItem.tintColor = UIColor.green
        } else {
            favoritesBarButtonItem.tintColor = .none
        }
    }

//    private func deleteRecipeFavorite() {
//        guard let recipeTitle = cellule?.title else { return }
//        guard let image = cellule?.image else { return }
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
