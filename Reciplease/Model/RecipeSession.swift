//
//  RecipeSession.swift
//  Reciplease
//
//  Created by Angelique Babin on 16/10/2019.
//  Copyright © 2019 Angelique Babin. All rights reserved.
//

import Foundation
import Alamofire

class RecipeSession: RecipeProtocol {
    func request(url: URL, completionHandler: @escaping (DataResponse<Any>) -> Void) {
        Alamofire.request(url).responseJSON { responseData in
            completionHandler(responseData)
        }
    }
}
