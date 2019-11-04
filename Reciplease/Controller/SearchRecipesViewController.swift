//
//  SearchRecipesViewController.swift
//  Reciplease
//
//  Created by Angelique Babin on 09/10/2019.
//  Copyright © 2019 Angelique Babin. All rights reserved.
//

import UIKit

class SearchRecipesViewController: UIViewController {

    // MARK: - Outlets

    @IBOutlet weak var ingredientTextField: UITextField!
    @IBOutlet weak var addButton: UIButton!
    @IBOutlet weak var searchButton: UIButton!
    @IBOutlet weak var clearButton: UIButton!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet var allButtons: [UIButton]!
    
    @IBOutlet weak var ingredientsTableView: UITableView! { didSet { ingredientsTableView.tableFooterView = UIView() } }
    
    // MARK: - Properties

    private let recipeService = RecipeService()
    private var ingredientsList = [String]()
    private var recipesList = [Hit]()
    private let segueToRecipesList = "segueToRecipesList"
    
    // MARK: - Actions
    
    @IBAction private func addButtonTapped(_ sender: UIButton) {
        addIngredient()
        ingredientTextField.resignFirstResponder()
        ingredientsTableView.reloadData()
    }
    
    @IBAction func clearButtonTapped(_ sender: UIButton) {
        ingredientsList.removeAll()
        ingredientsTableView.reloadData()
    }
    
    @IBAction func searchButtonTapped(_ sender: UIButton) {
        toggleActivityIndicator(shown: true, activityIndicator: activityIndicator, validateButton: searchButton)
        getRecipes()
    }
    
    // MARK: - Methods
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        ingredientsTableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        customInterfaceSearch(allButtons: allButtons)
        
        let nib = UINib(nibName: Constants.SearchTableViewCell, bundle: nil)
        ingredientsTableView.register(nib, forCellReuseIdentifier: Constants.SearchCell)

        ingredientsTableView.reloadData()
    }
    
    private func getRecipes() {
        // checks if array is not empty
        guard !ingredientsList.isEmpty else {
            presentAlert(typeError: .arrayIsEmpty)
            toggleActivityIndicator(shown: false, activityIndicator: activityIndicator, validateButton: searchButton)
            return
        }
  
        recipeService.getRecipes(ingredientsList: ingredientsList) { (success, recipesSearch) in
            self.toggleActivityIndicator(shown: false,
                                         activityIndicator: self.activityIndicator,
                                         validateButton: self.searchButton)
            if success {
                guard let recipesSearch = recipesSearch else { return }
                self.recipesList = recipesSearch.hits
                self.performSegue(withIdentifier: self.segueToRecipesList, sender: self)
            } else {
                self.presentAlert(typeError: .noRecipe)
                self.toggleActivityIndicator(shown: false,
                                             activityIndicator: self.activityIndicator,
                                             validateButton: self.searchButton)
            }
        }
    }
    
    func addIngredient() {
        guard let ingredient = ingredientTextField?.text, !ingredient.isBlank else { return }
        ingredientsList.append(ingredient)
        ingredientsTableView.reloadData()
        ingredientTextField.text = String()
    }
}

// MARK: - UITableViewDataSource

extension SearchRecipesViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ingredientsList.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let searchCell = tableView.dequeueReusableCell(
            withIdentifier: Constants.SearchCell,
            for: indexPath) as? SearchTableViewCell else {
            return UITableViewCell()
        }
        let ingredient = ingredientsList[indexPath.row]
        searchCell.configure(withIngredient: ingredient)
        return searchCell
    }
}

// MARK: - UITableViewDelegate

extension SearchRecipesViewController: UITableViewDelegate {
    
    /// delete a row in tableView
    func tableView(_ tableView: UITableView,
                   commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            ingredientsList.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
}

// MARK: - Keyboard

extension SearchRecipesViewController: UITextFieldDelegate {
    @IBAction func dismissKeyboard(_ sender: UITapGestureRecognizer) {
        ingredientTextField.resignFirstResponder()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        addIngredient()
        ingredientTextField.resignFirstResponder()
        return true
    }
}

// MARK: - Navigation

extension SearchRecipesViewController {
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == segueToRecipesList {
            guard let listRecipesVC = segue.destination as? ListRecipesViewController else { return }
            listRecipesVC.recipesList = recipesList
        }
    }
}
