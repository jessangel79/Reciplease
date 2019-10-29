//
//  UIViewController.swift
//  Reciplease
//
//  Created by Angelique Babin on 09/10/2019.
//  Copyright © 2019 Angelique Babin. All rights reserved.
//

import UIKit
//import CoreData

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
//        button.layer.shadowColor = UIColor.black.cgColor
//        button.layer.shadowOpacity = 0.8
    }
    
    /// custom views
    func customView(view: UIView) {
        view.layer.cornerRadius = 4
        view.layer.borderColor = UIColor.white.cgColor
        view.layer.borderWidth = 1.0
    //        view.layer.shadowColor = UIColor.black.cgColor
    //        view.layer.shadowOpacity = 0.8
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
        case errorNetwork
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
        case .errorNetwork:
            title = "Error download"
            message = "The download failed."
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
    func deleteRecipeFavorite(recipeTitle: String?, url: String?, coreDataManager: CoreDataManager?, barButtonItem: UIBarButtonItem) {
        coreDataManager?.deleteRecipe(recipeTitle: recipeTitle ?? "", url: url ?? "")
        setupBarButtonItem(color: .white, barButtonItem: barButtonItem)

        debugFavorites(titleDebug: "Favorite deleted !!! ", coreDataManager: coreDataManager)
    }
    
    func setupBarButtonItem(color: UIColor, barButtonItem: UIBarButtonItem) {
        barButtonItem.tintColor = color
        navigationItem.rightBarButtonItem = barButtonItem
    }
}

// MARK: - Extension to debug ### To delete ###

extension UIViewController {
    /// function to debug ### To delete ###
    func debugFavorites(titleDebug: String, coreDataManager: CoreDataManager?) {
        print(titleDebug)
        print("--------------------")
        for recipe in coreDataManager?.recipes ?? [RecipeEntity]() {
            print("resultat callback :")
            print(recipe.totalTime)
            print(recipe.image as Any)
            print(recipe.yield)
            print(recipe.title ?? "title error")
            print(recipe.ingredients ?? "ingredients error")
            print(recipe.url ?? "url error")
            print("\n")
        }
    }
}

// MARK: - Extension to config nib of table view cell // ???? A garder ????

//extension UIViewController {
//    func nibRegisterForCell(tableView: UITableView, nibName: String, forCellReuseIdentifier: String) {
//        let nib = UINib(nibName: nibName, bundle: nil)
//        tableView.register(nib, forCellReuseIdentifier: forCellReuseIdentifier)
//        
//        tableView.reloadData()
//    }
//}
        
//        nibRegisterForCell(tableView: recipesTableView,
//                           nibName: StaticVariable.ListRecipesTableViewCell,
//                           forCellReuseIdentifier: StaticVariable.ListRecipesCell)
        
