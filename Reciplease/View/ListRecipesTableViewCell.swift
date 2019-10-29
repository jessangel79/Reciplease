//
//  ListRecipesTableViewCell.swift
//  Reciplease
//
//  Created by Angelique Babin on 17/10/2019.
//  Copyright © 2019 Angelique Babin. All rights reserved.
//

import UIKit

class ListRecipesTableViewCell: UITableViewCell {
    @IBOutlet weak var recipeImageView: UIImageView!
    @IBOutlet weak var titleRecipeLabel: UILabel!
    @IBOutlet weak var ingredientsLabel: UILabel!
    @IBOutlet weak var yieldLabel: UILabel!
    @IBOutlet weak var totalTimeLabel: UILabel!
    @IBOutlet weak var grayView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        customViewCell(view: grayView)
    }
    
    func configure(title: String, ingredients: String, yield: Int, totalTime: Int?, image: String?) {
        titleRecipeLabel.text = title.localizedCapitalized
        ingredientsLabel.text = ingredients
        yieldLabel.text = String(yield)
        recipeImageView.load(urlImageString: image ?? "ImageDefault1024x768" + ".jpg")
        calcTotalTime(totalTime ?? 0, totalTimeLabel: totalTimeLabel)
//        totalTimeLabel.text = String(totalTime ?? 0)
//        totalTimeLabel.text = String(totalTime ?? 0) + " min"
//        totalTimeLabel.text = String((totalTime ?? 0) / 60) + " h"
//        calcTotalTime(totalTime)
    }
    
// MARK: - In extension UIResponder
//    fileprivate func calcTotalTime(_ totalTime: Int) {
//        let totalTimeTemp = totalTime
//        if totalTimeTemp < 60 {
//            totalTimeLabel.text = String(totalTimeTemp) + " min"
//        } else {
//            totalTimeLabel.text = String(totalTimeTemp / 60) + " h"
//        }
//    }

//    override func setSelected(_ selected: Bool, animated: Bool) {
//        super.setSelected(selected, animated: animated)
//
//        // Configure the view for the selected state
//    }
    
}
