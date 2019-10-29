//
//  Recipes.swift
//  Reciplease
//
//  Created by Angelique Babin on 15/10/2019.
//  Copyright © 2019 Angelique Babin. All rights reserved.
//
// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let recipeSearch = try? newJSONDecoder().decode(RecipesSearch.self, from: jsonData)

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

//// MARK: - RecipesSearch
//struct RecipesSearch: Decodable {
//    let q: String
//    let from, to: Int
//    let more: Bool
//    let count: Int
//    let hits: [Hit]
//}
//
//// MARK: - Hit
//struct Hit: Decodable {
//    let recipe: Recipe
//    let bookmarked, bought: Bool
//}
//
//// MARK: - Recipe
//struct Recipe: Decodable {
//    let uri: String
//    let label: String
//    let image: String?
//    let source: String
//    let url: String
//    let shareAs: String
//    let yield: Int
//    let ingredientLines: [String]
//    let ingredients: [IngredientStruct] // KO ### JSON #####
//    let calories, totalWeight: Double
//    let totalTime: Int?
//}
//
//// MARK: - IngredientStruct // KO ### JSON #####
//struct IngredientStruct: Codable {
//    let text: String
//    let quantity: Double
//    let measure, food: String
//    let weight: Double
//}
