//
//  RecipeService.swift
//  Reciplease
//
//  Created by Angelique Babin on 16/10/2019.
//  Copyright © 2019 Angelique Babin. All rights reserved.
//

import Foundation

class RecipeService {
    
    // MARK: - Vars
    
    private let recipeSession: RecipeProtocol
    
    init(recipeSession: RecipeProtocol = RecipeSession()) {
        self.recipeSession = recipeSession
    }
    
//    private let keyRecipeSearch = valueForAPIKey(named: "API_RecipeSearch")
    
    // MARK: - Methods
    
    /// network call to get the recipes
    func getRecipes(ingredientsList: [String], completionHandler: @escaping (Bool, RecipesSearch?) -> Void) {

        guard let url = createRecipeSearchUrl(ingredientsList: ingredientsList) else { return }

        recipeSession.request(url: url) { responseData in
            guard responseData.response?.statusCode == 200 else {
                completionHandler(false, nil)
                return
            }
            guard let data = responseData.data else {
                completionHandler(false, nil)
                return
            }
            guard let recipeSearch = try? JSONDecoder().decode(RecipesSearch.self, from: data) else {
                completionHandler(false, nil)
                return
            }
            completionHandler(true, recipeSearch)
        }
    }
    
    private func createRecipeSearchUrl(ingredientsList: [String]) -> URL? {
        let ingredientUrl = ingredientsList.joined(separator: ",")
//        let ingredientUrl = "&q=" + ingredientsList.joined(separator: ",")
//        let apiKeyRecipe = "&app_key=\(keyRecipeSearch)"
//        guard let url = URL(string: recipeSession.urlStringApi + apiKeyRecipe + ingredientUrl) else { return nil }
        guard let url = URL(string: recipeSession.urlStringApi + ingredientUrl) else { return nil }

        print(url)
        return url
    }
}
