//
//  UIViewController.swift
//  Reciplease
//
//  Created by Angelique Babin on 09/10/2019.
//  Copyright © 2019 Angelique Babin. All rights reserved.
//

import UIKit

// MARK: - Extension to custom buttons and views

extension UIViewController {

    /// custom interface Search Recipes
    func customInterfaceSearch(allButtons: [UIButton]) {
        for button in allButtons {
            customButton(button: button)
        }
    }

    /// custom buttons
    func customButton(button: UIButton) {
        button.layer.cornerRadius = 4
    }
    
    /// custom views
    func customView(view: UIView) {
        view.layer.cornerRadius = 4
        view.layer.borderColor = UIColor.white.cgColor
        view.layer.borderWidth = 1.0
    }
}

// MARK: - Extension to manage the ActivityIndicator

extension UIViewController {
    func toggleActivityIndicator(shown: Bool, activityIndicator: UIActivityIndicatorView, validateButton: UIButton) {
        activityIndicator.isHidden = !shown
        validateButton.isHidden = shown
    }
}

// MARK: - Extension to display a alert message to the user

extension UIViewController {
    /// Enumeration of the error
    enum AlertError {
        case arrayIsEmpty
        case noRecipe
    }

    /// Alert message to user
    func presentAlert(typeError: AlertError) {
        var message: String
        var title: String
        
        switch typeError {
        case .arrayIsEmpty:
            title = "No ingredient"
            message = "Please add an ingredient."
        case .noRecipe:
            title = "No recipe"
            message = "Sorry there is no recipe."
        }
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
}

// MARK: - Extension to open url

extension UIViewController {
    func webViewRecipe(urlString: String) {
        guard let url = URL(string: urlString) else { return }
        guard UIApplication.shared.canOpenURL(url) else { return }
        UIApplication.shared.open(url)
    }
}

// MARK: - Extension to delete favorites and manage the button of favorites

extension UIViewController {
    /// Delete favorite
    func deleteRecipeFavorite(recipeTitle: String?, url: String?, coreDataManager: CoreDataManager?, barButtonItem: UIBarButtonItem) {
        coreDataManager?.deleteRecipe(recipeTitle: recipeTitle ?? "", url: url ?? "")
        setupBarButtonItem(color: .white, barButtonItem: barButtonItem)

        debugFavorites(titleDebug: "Favorite deleted", coreDataManager: coreDataManager)
    }
    
    /// Manage the button of favorites
    func setupBarButtonItem(color: UIColor, barButtonItem: UIBarButtonItem) {
        barButtonItem.tintColor = color
        navigationItem.rightBarButtonItem = barButtonItem
    }
}

// MARK: - Extension to debug

extension UIViewController {
    /// function to debug
    func debugFavorites(titleDebug: String, coreDataManager: CoreDataManager?) {
        print(titleDebug)
        print("-----------------------")
        var index = 0
        for recipe in coreDataManager?.recipes ?? [RecipeEntity]() {
            print("Recipes N° \(index + 1) :")
            print("Total time : \(Int(recipe.totalTime).convertTimeToString)")
            print("Servings : \(recipe.yield)")
            print(recipe.image ?? "image error")
            print(recipe.url ?? "url error")
            print(recipe.title ?? "title error")
            print(recipe.ingredients ?? "ingredients error")
            print("\n")
            index += 1
        }
    }
}
