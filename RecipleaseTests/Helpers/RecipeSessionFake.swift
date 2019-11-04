//
//  RecipeSessionFake.swift
//  RecipleaseTests
//
//  Created by Angelique Babin on 30/10/2019.
//  Copyright © 2019 Angelique Babin. All rights reserved.
//

import Foundation
import Alamofire
@testable import Reciplease

class RecipeSessionFake: RecipeProtocol {
    
    private let fakeResponse: FakeResponse
//    private let ingredientsList: [String]
    
    init(fakeResponse: FakeResponse) {
        self.fakeResponse = fakeResponse
    }
    
//    init(fakeResponse: FakeResponse, ingredientsList: [String]) {
//        self.fakeResponse = fakeResponse
//        self.ingredientsList = ingredientsList
//    }
    
    func request(url: URL, completionHandler: @escaping (DataResponse<Any>) -> Void) {
        let httpResponse = fakeResponse.response
        let data = fakeResponse.data
        let error = fakeResponse.error
        let result = Request.serializeResponseJSON(options: .allowFragments, response: httpResponse, data: data, error: error)
        
//        let ingredientsList = ["cocoa", "milk"]
        let ingredientsList = [String]()
        
//        guard let url = createRecipeSearchUrl(ingredientsList: [String]()) else { return }
//        let urlRequest = URLRequest(url: url)
        
        guard let url = URL(string: urlStringApi + ingredientsList.joined(separator: ",")) else { return }
        let urlRequest = URLRequest(url: url)
        print(url)
        
        completionHandler(DataResponse(request: urlRequest, response: httpResponse, data: data, result: result))
    }
    
//    private func createRecipeSearchUrl(ingredientsList: [String]) -> URL? {
//        let ingredientUrl = ingredientsList.joined(separator: ",")
//        guard let url = URL(string: urlStringApi + ingredientUrl) else { return nil }
////        print(url)
//        return url
//    }
}
