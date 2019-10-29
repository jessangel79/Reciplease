//
//  Recipes.swift
//  Reciplease
//
//  Created by Angelique Babin on 15/10/2019.
//  Copyright © 2019 Angelique Babin. All rights reserved.
//

import Foundation

// MARK: - RecipesSearch

struct RecipesSearch: Decodable {
    let hits: [Hit]
}

// MARK: - Hit

struct Hit: Decodable {
    let recipe: Recipe
}

// MARK: - Recipe

struct Recipe: Decodable {
    let label: String
    let image: String?
    let url: String
    let yield: Int
    let ingredientLines: [String]
    let totalTime: Int?
}
