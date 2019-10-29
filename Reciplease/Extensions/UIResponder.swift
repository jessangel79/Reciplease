//
//  UIResponder.swift
//  Reciplease
//
//  Created by Angelique Babin on 24/10/2019.
//  Copyright © 2019 Angelique Babin. All rights reserved.
//

import UIKit

// MARK: - Extension to calculate minutes in hour if time > 60 min

extension UIResponder {

    func calcTotalTime(_ totalTime: Int, totalTimeLabel: UILabel) {
        let totalTimeTemp = totalTime
        if totalTimeTemp < 60 {
            totalTimeLabel.text = String(totalTimeTemp) + " min"
        } else {
            totalTimeLabel.text = String(totalTimeTemp / 60) + " h"
        }
    }
}
