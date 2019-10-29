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
    //        view.layer.shadowColor = UIColor.black.cgColor
    //        view.layer.shadowOpacity = 0.8
    }
    
    /// custom imageViews
//    func customImageView(imageView: UIImageView) {
////        imageView.layer.cornerRadius = 4
////        imageView.layer.borderColor = UIColor.black.cgColor
////        imageView.layer.borderWidth = 1.0
//        imageView.layer.shadowColor = UIColor.black.cgColor
//        imageView.layer.shadowOpacity = 10
//        imageView.layer.shadowOffset = CGSize.init(width: 2.0, height: 2.0)
//        imageView.layer.shadowRadius = 5.0
//        imageView.layer.masksToBounds = true
//    }
}
