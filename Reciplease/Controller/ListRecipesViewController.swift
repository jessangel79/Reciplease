//
//  ListRecipesViewController.swift
//  Reciplease
//
//  Created by Angelique Babin on 16/10/2019.
//  Copyright © 2019 Angelique Babin. All rights reserved.
//

import UIKit

final class ListRecipesViewController: UIViewController {
    
    // MARK: - Outlets
    
    @IBOutlet private weak var recipesTableView: UITableView!
    
    // MARK: - Properties
    
    var recipesList = [Hit]()
    private var cellSelected: Hit?
    private let segueToRecipeDetail = "segueToRecipeDetail"

    // MARK: - Methods
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        recipesTableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let nib = UINib(nibName: Constants.ListRecipesTableViewCell, bundle: nil)
        recipesTableView.register(nib, forCellReuseIdentifier: Constants.ListRecipesCell)
        recipesTableView.reloadData()
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
            withIdentifier: Constants.ListRecipesCell,
            for: indexPath) as? ListRecipesTableViewCell else {
            return UITableViewCell()
        }
        let recipe = recipesList[indexPath.row]
        listRecipesCell.recipe = recipe.recipe
        
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
