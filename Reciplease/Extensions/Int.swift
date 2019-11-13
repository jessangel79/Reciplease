//
//  Int.swift
//  Reciplease
//
//  Created by Angelique Babin on 31/10/2019.
//  Copyright © 2019 Angelique Babin. All rights reserved.
//

import Foundation

extension Int {
    /// Convert the minutes to display in the better string format
    var convertTimeToString: String {
        if self == 0 {
            let timeNull = "N/A"
            return timeNull
        } else {
            let minutes = self % (60)
            let hours = self / 60
            let timeFormatString = String(format: "%01dh%02d", hours, minutes)
            let timeFormatStringMin = String(format: "%02dm", minutes)
            let timeFormatNoMin = String(format: "%01dh", hours)
            if self < 60 {
                return timeFormatStringMin
            } else if minutes == 0 {
                return timeFormatNoMin
            } else {
                return timeFormatString
            }
        }
    }
}
