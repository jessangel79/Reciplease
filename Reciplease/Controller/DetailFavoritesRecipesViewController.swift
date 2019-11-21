//
//  DetailFavoritesRecipesViewController.swift
//  Reciplease
//
//  Created by Angelique Babin on 23/10/2019.
//  Copyright © 2019 Angelique Babin. All rights reserved.
//

import UIKit

final class DetailFavoritesRecipesViewController: UIViewController {
    
    // MARK: - Outlets
    
    @IBOutlet private weak var grayView: UIView!
    @IBOutlet private weak var getDirectionsButton: UIButton!
    @IBOutlet private weak var favoritesBarButtonItem: UIBarButtonItem!
    @IBOutlet private weak var recipeImageView: UIImageView!
    @IBOutlet private weak var totalTimeLabel: UILabel!
    @IBOutlet private weak var yieldLabel: UILabel!
    @IBOutlet private weak var titleRecipeLabel: UILabel!
    @IBOutlet private weak var ingredientsTextView: UITextView!
    
    // MARK: - Properties

    var cellule: RecipeEntity?
    private var coreDataManager: CoreDataManager?
    private var recipeIsFavorite = false
   
    // MARK: - Actions
    
    @IBAction private func getDirectionsButtonTapped(_ sender: UIButton) {
        guard let url = cellule?.url else { return }
        webViewRecipe(urlString: url)
    }
    
    @IBAction private func favoritesBarButtonItemTapped(_ sender: UIBarButtonItem) {
        checkIfRecipeIsFavorite()
        deleteRecipeFavorite(recipeTitle: cellule?.title,
                             url: cellule?.url,
                             coreDataManager: coreDataManager,
                             barButtonItem: favoritesBarButtonItem)
        navigationController?.popViewController(animated: true)
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
    
    private func coreDataFunction() {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let coreDataStack = appDelegate.coreDataStack
        coreDataManager = CoreDataManager(coreDataStack: coreDataStack)
    }
    
    private func configureRecipe() {
        guard let yield = cellule?.yield else { return }
        guard let totalTime = cellule?.totalTime else { return }
        
        titleRecipeLabel.text = cellule?.title
        ingredientsTextView.text = cellule?.ingredients
        yieldLabel.text = String(yield)
        totalTimeLabel.text = Int(totalTime).convertTimeToString
        recipeImageView.load(urlImageString: cellule?.image)
    }

    private func checkIfRecipeIsFavorite() {
        guard let recipeTitle = cellule?.title else { return }
        guard let url = cellule?.url else { return }
        guard let checkIsRecipeIsFavorite = coreDataManager?.checkIfRecipeIsFavorite(recipeTitle: recipeTitle, url: url) else { return }

        recipeIsFavorite = checkIsRecipeIsFavorite

        if recipeIsFavorite {
            favoritesBarButtonItem.tintColor = UIColor.green
        } else {
            favoritesBarButtonItem.tintColor = .none
        }
    }
}
