//
//  RecipeProtocol.swift
//  Reciplease
//
//  Created by Angelique Babin on 16/10/2019.
//  Copyright © 2019 Angelique Babin. All rights reserved.
//

import Foundation
import Alamofire

protocol RecipeProtocol {
    var urlStringApi: String { get }
    func request(url: URL, completionHandler: @escaping (DataResponse<Any>) -> Void)
}

extension RecipeProtocol {
    var keyRecipeSearch: String {
        return valueForAPIKey(named: "API_RecipeSearch")
    }
    
    var urlStringApi: String {
        return "https://api.edamam.com/api/recipes/v2?type=public&beta=false&app_id=efc09e97&app_key=\(keyRecipeSearch)&q="
    }
    
    // API Recipe search V2
//"https://api.edamam.com/api/recipes/v2?type=public&beta=false&app_id=efc09e97&app_key=\(keyRecipeSearch)&q="
    
    // API Recipe search V1
//    "https://api.edamam.com/search?app_id=efc09e97&app_key=\(keyRecipeSearch)&to=50&q="
}
