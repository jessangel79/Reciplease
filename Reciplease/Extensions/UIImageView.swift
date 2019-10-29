//
//  UIImageView.swift
//  Reciplease
//
//  Created by Angelique Babin on 18/10/2019.
//  Copyright © 2019 Angelique Babin. All rights reserved.
//

import UIKit

extension UIImageView {
    
    func load(urlImageString: String?) {
        guard let urlImageString = urlImageString else { return }
        guard let urlImage = URL(string: urlImageString) else { return }
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: urlImage) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.image = image
//                        self?.image = image.alpha(0.8)
                    }
                } else {
                    self?.image = UIImage(named: "ImageDefault1024x768" + ".jpg")
                }
            }
        }
    }
    
//    func load(urlImageString: String?) {
//        guard let urlImageString = urlImageString else { return }
//        guard let urlImage = URL(string: urlImageString) else { return }
//            guard let data = try? Data(contentsOf: urlImage) else { return }
//            if let image = UIImage(data: data) {
//                self.image = image
////                self.image = image.alpha(0.8)
//            } else {
//                self.image = UIImage(named: "ImageDefault1024x768" + ".jpg")
//            }
//    }

}
