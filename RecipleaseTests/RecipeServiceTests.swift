//
//  RecipeServiceTests.swift
//  RecipleaseTests
//
//  Created by Angelique Babin on 09/10/2019.
//  Copyright © 2019 Angelique Babin. All rights reserved.
//

import XCTest
@testable import Reciplease

class RecipeServiceTests: XCTestCase {
    
    // MARK: - Properties
    
//    let ingredientsList = ["cocoa", "milk"]
    var ingredientsList: [String]!
    
    // MARK: - Tests Life Cycle
    
    override func setUp() {
        super.setUp()
        ingredientsList = ["cocoa", "milk"]
    }
    
    // MARK: - Tests
    
    func testGetRecipesShouldPostFailedCallback() {
        let fakeResponse = FakeResponse(response: nil, data: nil, error: FakeResponseData.networkError)
        let recipeSessionFake = RecipeSessionFake(fakeResponse: fakeResponse)
//        let recipeSessionFake = RecipeSessionFake(fakeResponse: fakeResponse, ingredientsList: ingredientsList)
        let recipeService = RecipeService(recipeSession: recipeSessionFake)

        let expectation = XCTestExpectation(description: "Wait for queue change.")
        recipeService.getRecipes(ingredientsList: ingredientsList) { (success, recipesSearch) in
            XCTAssertFalse(success)
            XCTAssertNil(recipesSearch)
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 0.01)
    }
    
    func testGetRecipesShouldPostFailedCallbackIfNoData() {
        let fakeResponse = FakeResponse(response: nil, data: FakeResponseData.incorrectData, error: nil)
        let recipeSessionFake = RecipeSessionFake(fakeResponse: fakeResponse)
//        let recipeSessionFake = RecipeSessionFake(fakeResponse: fakeResponse, ingredientsList: ingredientsList)
        let recipeService = RecipeService(recipeSession: recipeSessionFake)

        let expectation = XCTestExpectation(description: "Wait for queue change.")
        recipeService.getRecipes(ingredientsList: ingredientsList) { (success, recipesSearch) in
            XCTAssertFalse(success)
            XCTAssertNil(recipesSearch)
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 0.01)
    }
    
    func testGetRecipesShouldPostFailedCallbackIfIncorrectResponse() {
        let fakeResponse = FakeResponse(response: FakeResponseData.responseKO, data: FakeResponseData.correctData, error: nil)
        let recipeSessionFake = RecipeSessionFake(fakeResponse: fakeResponse)
//        let recipeSessionFake = RecipeSessionFake(fakeResponse: fakeResponse, ingredientsList: ingredientsList)
        let recipeService = RecipeService(recipeSession: recipeSessionFake)

        let expectation = XCTestExpectation(description: "Wait for queue change.")
        recipeService.getRecipes(ingredientsList: ingredientsList) { (success, recipesSearch) in
            XCTAssertFalse(success)
            XCTAssertNil(recipesSearch)
            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 0.01)
    }
    
    func testGetRecipesShouldPostFailedCallbackIfResponseCorrectAndNilData() {
        let fakeResponse = FakeResponse(response: FakeResponseData.responseOK, data: nil, error: nil)
        let recipeSessionFake = RecipeSessionFake(fakeResponse: fakeResponse)
//        let recipeSessionFake = RecipeSessionFake(fakeResponse: fakeResponse, ingredientsList: ingredientsList)
        let recipeService = RecipeService(recipeSession: recipeSessionFake)

        let expectation = XCTestExpectation(description: "Wait for queue change.")
        recipeService.getRecipes(ingredientsList: ingredientsList) { (success, recipesSearch) in
            XCTAssertFalse(success)
            XCTAssertNil(recipesSearch)
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 0.01)
    }

    func testGetRecipesShouldPostFailedCallbackIfIncorrectData() {
        let fakeResponse = FakeResponse(response: FakeResponseData.responseOK, data: FakeResponseData.incorrectData, error: nil)
        let recipeSessionFake = RecipeSessionFake(fakeResponse: fakeResponse)
//        let recipeSessionFake = RecipeSessionFake(fakeResponse: fakeResponse, ingredientsList: ingredientsList)
        let recipeService = RecipeService(recipeSession: recipeSessionFake)

        let expectation = XCTestExpectation(description: "Wait for queue change.")
        recipeService.getRecipes(ingredientsList: ingredientsList) { (success, recipesSearch) in
            XCTAssertFalse(success)
            XCTAssertNil(recipesSearch)
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 0.01)
    }

    func testGetRecipeShouldPostSuccessCallbackIfNoErrorAndCorrectData() {
        let fakeResponse = FakeResponse(response: FakeResponseData.responseOK, data: FakeResponseData.correctData, error: nil)
        let recipeSessionFake = RecipeSessionFake(fakeResponse: fakeResponse)
//        let recipeSessionFake = RecipeSessionFake(fakeResponse: fakeResponse, ingredientsList: ingredientsList)
        let recipeService = RecipeService(recipeSession: recipeSessionFake)
        
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        recipeService.getRecipes(ingredientsList: ingredientsList) { (success, recipesSearch) in
            XCTAssertTrue(success)
            XCTAssertNotNil(recipesSearch)
            XCTAssertEqual(recipesSearch?.hits[0].recipe.label, "Recreating the Adult Brownies from Andronico's Recipe")
            XCTAssertEqual(recipesSearch?.hits[0].recipe.image, "https://www.edamam.com/web-img/de7/de75049edc890303d8fd1293d35938b2.jpg")
            XCTAssertEqual(recipesSearch?.hits[0].recipe.yield, Int(16.0))
            XCTAssertEqual(recipesSearch?.hits[0].recipe.url, "http://www.seriouseats.com/recipes/2009/09/adult-brownie-chocolate-salt-coffee-andronicos-supermarket-san-francisco-recipe.html")
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 0.01)
    }
    
//    func testGetRecipeShouldPostSuccessCallbackIfNoErrorAndCorrectDataIfIngredientsListIsEmpty() {
//        let fakeResponse = FakeResponse(response: FakeResponseData.responseOK, data: FakeResponseData.correctData, error: nil)
//        let recipeSessionFake = RecipeSessionFake(fakeResponse: fakeResponse)
//    //        let recipeSessionFake = RecipeSessionFake(fakeResponse: fakeResponse, ingredientsList: ingredientsList)
//        let recipeService = RecipeService(recipeSession: recipeSessionFake)
//        
//        let expectation = XCTestExpectation(description: "Wait for queue change.")
//        recipeService.getRecipes(ingredientsList: [" "]) { (success, recipesSearch) in
//            XCTAssertFalse(success)
//            XCTAssertNil(recipesSearch)
//            expectation.fulfill()
//        }
//    }
    
}
