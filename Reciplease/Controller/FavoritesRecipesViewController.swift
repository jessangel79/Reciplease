//
//  FavoritesRecipesViewController.swift
//  Reciplease
//
//  Created by Angelique Babin on 23/10/2019.
//  Copyright © 2019 Angelique Babin. All rights reserved.
//

import UIKit

// Trick to get static variable in Swift
//struct StaticVariableFavorite {
//    static let ListRecipesCell = "ListRecipesCell"
//}

class FavoritesRecipesViewController: UIViewController {
    
     // MARK: - Outlets
    
    @IBOutlet weak var favoritesRecipesTableView: UITableView! {
        didSet { favoritesRecipesTableView.tableFooterView = UIView() }
    }
    
    // MARK: - Properties
    
    var coreDataManager: CoreDataManager?
    var cellSelected: RecipeEntity!
    private let segueToRecipeDetailFavorite = "segueToRecipeDetailFavorite"
    
    // MARK: - Actions

    @IBAction func deleteAllFavorites(_ sender: UIBarButtonItem) {
        coreDataManager?.deleteAllRecipes()
        print("delete all recipes ok")
        favoritesRecipesTableView.reloadData()
    }
    
    // MARK: - Methods
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        favoritesRecipesTableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        coreDataFunction()
        
        print("In FavoritesRecipesViewController : ")
        debugFavorites(titleDebug: "Recipes entity", coreDataManager: coreDataManager)
        
        let nib = UINib(nibName: Constants.ListRecipesTableViewCell, bundle: nil)
        favoritesRecipesTableView.register(nib, forCellReuseIdentifier: Constants.ListRecipesCell)
        favoritesRecipesTableView.reloadData()
    }
    
    private func coreDataFunction() {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let coreDataStack = appDelegate.coreDataStack
        coreDataManager = CoreDataManager(coreDataStack: coreDataStack)
    }
}

// MARK: - UITableViewDataSource

extension FavoritesRecipesViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return coreDataManager?.recipes.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let listRecipesCell = tableView.dequeueReusableCell(
            withIdentifier: Constants.ListRecipesCell,
            for: indexPath) as? ListRecipesTableViewCell else {
            return UITableViewCell()
        }
        let recipe = coreDataManager?.recipes[indexPath.row]
        listRecipesCell.recipeEntity = recipe
//        listRecipesCell.configure(title: recipe?.title ?? "",
//                                  ingredients: recipe?.ingredients ?? "",
//                                  yield: Int(recipe?.yield ?? 0),
//                                  totalTime: Int(recipe?.totalTime ?? 0),
//                                  image: recipe?.image ?? "ImageDefault1024x768" + ".jpg")
        return listRecipesCell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.cellSelected = coreDataManager?.recipes[indexPath.row]
        performSegue(withIdentifier: self.segueToRecipeDetailFavorite, sender: self)
    }
}

// MARK: - UITableViewDelegate

extension FavoritesRecipesViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let label = UILabel()
        label.text = "Click on the star to add the recipe in your favorites"
        label.font = UIFont.systemFont(ofSize: 15, weight: .semibold)
        label.textAlignment = .center
        label.textColor = .white
        return label
    }

    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return coreDataManager?.recipes.isEmpty ?? true ? 300 : 0
    }
}

// MARK: - Navigation

extension FavoritesRecipesViewController {
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == segueToRecipeDetailFavorite {
            guard let detailFavoritesRecipesVC = segue.destination
                as? DetailFavoritesRecipesViewController else { return }
            detailFavoritesRecipesVC.cellule = self.cellSelected
        }
    }
}
