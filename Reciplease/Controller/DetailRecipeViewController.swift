//
//  DetailRecipeViewController.swift
//  Reciplease
//
//  Created by Angelique Babin on 21/10/2019.
//  Copyright © 2019 Angelique Babin. All rights reserved.
//

import UIKit

final class DetailRecipeViewController: UIViewController {
    
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

    var cellule: Hit?
    private var coreDataManager: CoreDataManager?
    private var recipeIsFavorite = false
    
    // MARK: - Actions
    
    @IBAction private func getDirectionsButtonTapped(_ sender: UIButton) {
        guard let celluleRecipeUrl = cellule?.recipe.url else { return }
        webViewRecipe(urlString: celluleRecipeUrl)
    }
    
    @IBAction private func favoritesBarButtonItemTapped(_ sender: UIBarButtonItem) {
        checkIfRecipeIsFavorite()
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
        guard let ingredientLines = cellule?.recipe.ingredientLines.joined(separator: "\n" + "- ") else { return }
        guard let yield = cellule?.recipe.yield else { return }
        guard let image = cellule?.recipe.image else { return }
        let totalTimeInt = cellule?.recipe.totalTime ?? 0
        
        ingredientsTextView.text = "- " + ingredientLines
        titleRecipeLabel.text = cellule?.recipe.label.localizedCapitalized
        yieldLabel.text = String(yield)
        recipeImageView.load(urlImageString: image)
        totalTimeLabel.text = totalTimeInt.convertTimeToString
    }
    
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
        guard let label = cellule?.recipe.label else { return }
        guard let ingredients = cellule?.recipe.ingredientLines.joined(separator: "\n" + "- ") else { return }
        guard let yield = cellule?.recipe.yield else { return }
        let totalTime = Int16(cellule?.recipe.totalTime ?? 0)
        guard let image = cellule?.recipe.image else { return }
        guard let url = cellule?.recipe.url else { return }
        
        coreDataManager?.createRecipe(title: label.localizedCapitalized,
                                      ingredients: "- " + ingredients,
                                      yield: Int16(yield),
                                      totalTime: totalTime,
                                      image: image, url: url)
        setupBarButtonItem(color: .green, barButtonItem: favoritesBarButtonItem)
        
        debugFavorites(titleDebug: "Favorite created", coreDataManager: coreDataManager)
    }
}
