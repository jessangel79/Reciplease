//
//  CoreDataManagerTests.swift
//  RecipleaseTests
//
//  Created by Angelique Babin on 30/10/2019.
//  Copyright © 2019 Angelique Babin. All rights reserved.
//

import XCTest
@testable import Reciplease

final class CoreDataManagerTests: XCTestCase {
    
    // MARK: - Properties

    var coreDataStack: MockCoreDataStack!
    var coreDataManager: CoreDataManager!

    // MARK: - Tests Life Cycle

    override func setUp() {
        super.setUp()
        coreDataStack = MockCoreDataStack()
        coreDataManager = CoreDataManager(coreDataStack: coreDataStack)
    }

    override func tearDown() {
        super.tearDown()
        coreDataManager = nil
        coreDataStack = nil
    }

    // MARK: - Tests

    func testAddRecipeMethods_WhenAnEntityIsCreated_ThenShouldBeCorrectlySaved() {
        coreDataManager.createRecipe(title: "My Recipe", ingredients: "Ingredients", yield: 16, totalTime: 0, image: "https://www.edamam.com/web-img/de7/de75049edc890303d8fd1293d35938b2.jpg", url: "http://www.seriouseats.com/recipes/2009/09/adult-brownie-chocolate-salt-coffee-andronicos-supermarket-san-francisco-recipe.html")
        XCTAssertTrue(!coreDataManager.recipes.isEmpty)
        XCTAssertTrue(coreDataManager.recipes.count == 1)
        XCTAssertTrue(coreDataManager.recipes[0].title == "My Recipe")
        XCTAssertTrue(coreDataManager.recipes[0].ingredients == "Ingredients")
        XCTAssertTrue(coreDataManager.recipes[0].yield == 16)
        XCTAssertTrue(coreDataManager.recipes[0].totalTime == 0)
        XCTAssertTrue(coreDataManager.recipes[0].image == "https://www.edamam.com/web-img/de7/de75049edc890303d8fd1293d35938b2.jpg")
        XCTAssertTrue(coreDataManager.recipes[0].url == "http://www.seriouseats.com/recipes/2009/09/adult-brownie-chocolate-salt-coffee-andronicos-supermarket-san-francisco-recipe.html")
        
        let recipeIsFavorite = coreDataManager.checkIsRecipeIsFavorite(recipeTitle: "My Recipe", url: "http://www.seriouseats.com/recipes/2009/09/adult-brownie-chocolate-salt-coffee-andronicos-supermarket-san-francisco-recipe.html")
        XCTAssertTrue(coreDataManager.recipes.count > 0)
        XCTAssertTrue(recipeIsFavorite)
    }

    func testDeleteRecipeMethod_WhenAnEntityIsCreated_ThenShouldBeCorrectlyDeleted() {
        coreDataManager.createRecipe(title: "My Recipe One", ingredients: "Ingredients", yield: 16, totalTime: 0, image: "https://www.edamam.com/web-img/de7/de75049edc890303d8fd1293d35938b2.jpg", url: "http://www.seriouseats.com/recipes/2009/09/adult-brownie-chocolate-salt-coffee-andronicos-supermarket-san-francisco-recipe.html")
        
        coreDataManager.createRecipe(title: "My Recipe Two", ingredients: "Ingredients", yield: 12, totalTime: 0, image: "https://www.edamam.com/web-img/ef8/ef85302a1ac4ac3a94f22ca566ddeea2.jpg", url: "https://food52.com/recipes/67029-milk-chocolate-cocoa")
        
        coreDataManager.deleteRecipe(recipeTitle: "My Recipe One", url: "http://www.seriouseats.com/recipes/2009/09/adult-brownie-chocolate-salt-coffee-andronicos-supermarket-san-francisco-recipe.html")
        
        let recipeIsFavoriteOne = coreDataManager.checkIsRecipeIsFavorite(recipeTitle: "My Recipe One", url: "http://www.seriouseats.com/recipes/2009/09/adult-brownie-chocolate-salt-coffee-andronicos-supermarket-san-francisco-recipe.html")
        XCTAssertFalse(recipeIsFavoriteOne)
        
        let recipeIsFavoriteTwo = coreDataManager.checkIsRecipeIsFavorite(recipeTitle: "My Recipe Two", url: "https://food52.com/recipes/67029-milk-chocolate-cocoa")
        XCTAssertTrue(recipeIsFavoriteTwo)
        XCTAssertFalse(coreDataManager.recipes.isEmpty)
    }
    
    func testDeleteAllRecipesMethod_WhenAnEntityIsCreated_ThenShouldBeCorrectlyAllDeleted() {
        coreDataManager.createRecipe(title: "My Recipe", ingredients: "Ingredients", yield: 16, totalTime: 0, image: "https://www.edamam.com/web-img/de7/de75049edc890303d8fd1293d35938b2.jpg", url: "http://www.seriouseats.com/recipes/2009/09/adult-brownie-chocolate-salt-coffee-andronicos-supermarket-san-francisco-recipe.html")
        coreDataManager.deleteAllRecipes()
        XCTAssertTrue(coreDataManager.recipes.isEmpty)
        
        let recipeIsFavorite = coreDataManager.checkIsRecipeIsFavorite(recipeTitle: "My Recipe", url: "http://www.seriouseats.com/recipes/2009/09/adult-brownie-chocolate-salt-coffee-andronicos-supermarket-san-francisco-recipe.html")
        XCTAssertFalse(recipeIsFavorite)
    }
    
//    func testCheckIsRecipeIsFavoriteMethod_WhenAnEntityIsCreated_ThenShouldBeInFavorites() {
//        coreDataManager.createRecipe(title: "My Recipe", ingredients: "Ingredients", yield: 16, totalTime: 0, image: "https://www.edamam.com/web-img/de7/de75049edc890303d8fd1293d35938b2.jpg", url: "http://www.seriouseats.com/recipes/2009/09/adult-brownie-chocolate-salt-coffee-andronicos-supermarket-san-francisco-recipe.html")
//        let recipeIsFavorite = coreDataManager.checkIsRecipeIsFavorite(recipeTitle: "My Recipe", url: "http://www.seriouseats.com/recipes/2009/09/adult-brownie-chocolate-salt-coffee-andronicos-supermarket-san-francisco-recipe.html")
//        XCTAssertTrue(coreDataManager.recipes.count > 0)
//        XCTAssertTrue(recipeIsFavorite)
//    }
    
//    func testCheckIsRecipeIsFavoriteMethod_WhenAnEntityIsCreatedAndDeleted_ThenShouldBeNotInFavorites() {
//        coreDataManager.createRecipe(title: "My Recipe", ingredients: "Ingredients", yield: 16, totalTime: 0, image: "https://www.edamam.com/web-img/de7/de75049edc890303d8fd1293d35938b2.jpg", url: "http://www.seriouseats.com/recipes/2009/09/adult-brownie-chocolate-salt-coffee-andronicos-supermarket-san-francisco-recipe.html")
//        coreDataManager.deleteRecipe(recipeTitle: "My Recipe", url: "http://www.seriouseats.com/recipes/2009/09/adult-brownie-chocolate-salt-coffee-andronicos-supermarket-san-francisco-recipe.html")
//
//        let recipeIsFavorite = coreDataManager.checkIsRecipeIsFavorite(recipeTitle: "My Recipe", url: "http://www.seriouseats.com/recipes/2009/09/adult-brownie-chocolate-salt-coffee-andronicos-supermarket-san-francisco-recipe.html")
//        XCTAssertFalse(recipeIsFavorite)
//    }
}
