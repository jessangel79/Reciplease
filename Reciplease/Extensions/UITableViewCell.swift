//
//  UITableViewCell.swift
//  Reciplease
//
//  Created by Angelique Babin on 18/10/2019.
//  Copyright © 2019 Angelique Babin. All rights reserved.
//

import UIKit

// MARK: - Extension to custom views

extension UITableViewCell {
    
    /// custom views
    func customViewCell(view: UIView) {
        view.layer.cornerRadius = 4
        view.layer.borderColor = UIColor.white.cgColor
        view.layer.borderWidth = 1.0
    }
}
