//
//  ListRecipesViewController.swift
//  Reciplease
//
//  Created by Angelique Babin on 16/10/2019.
//  Copyright © 2019 Angelique Babin. All rights reserved.
//

import UIKit

class ListRecipesViewController: UIViewController {
    
    // MARK: - Outlets
    
    @IBOutlet weak var recipesTableView: UITableView!
    
    // MARK: - Properties
    
    var recipesList = [Hit]()
    var cellSelected: Hit!
    private let segueToRecipeDetail = "segueToRecipeDetail"

    // MARK: - Methods
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        recipesTableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let nib = UINib(nibName: StaticVariable.ListRecipesTableViewCell, bundle: nil)
        recipesTableView.register(nib, forCellReuseIdentifier: StaticVariable.ListRecipesCell)
        
        recipesTableView.reloadData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    private func listOfIngredients(recipes: Hit) -> String {
        var listRecipe = String()
        for ingredient in recipes.recipe.ingredientLines {
            listRecipe += ingredient + ", "
        }
        return listRecipe
    }
}

// MARK: - UITableViewDataSource

extension ListRecipesViewController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return recipesList.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let listRecipesCell = tableView.dequeueReusableCell(
            withIdentifier: StaticVariable.ListRecipesCell,
            for: indexPath) as? ListRecipesTableViewCell else {
            return UITableViewCell()
        }
        let recipes = recipesList[indexPath.row]
        let ingredients = listOfIngredients(recipes: recipes)
        listRecipesCell.configure(title: recipes.recipe.label,
                                  ingredients: ingredients,
                                  yield: recipes.recipe.yield,
                                  totalTime: recipes.recipe.totalTime ?? 0,
                                  image: recipes.recipe.image ?? "ImageDefault1024x768" + ".jpg")
        return listRecipesCell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.cellSelected = recipesList[indexPath.row]
        performSegue(withIdentifier: self.segueToRecipeDetail, sender: self)
    }
}

// MARK: - Navigation

extension ListRecipesViewController {
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == segueToRecipeDetail {
            guard let detailRecipeVC = segue.destination as? DetailRecipeViewController else { return }
            detailRecipeVC.cellule = self.cellSelected
        }
    }
}
