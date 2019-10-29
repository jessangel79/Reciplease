//
//  String.swift
//  Reciplease
//
//  Created by Angelique Babin on 15/10/2019.
//  Copyright © 2019 Angelique Babin. All rights reserved.
//

import Foundation

extension String {
    /**
     * Check if a string contains at least one element
     */
    var isBlank: Bool {
        return self.trimmingCharacters(in: .whitespaces) == String() ? true : false
    }
}
