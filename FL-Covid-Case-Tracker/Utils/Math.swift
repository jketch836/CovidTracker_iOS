//
//  Math.swift
//  FL-Covid-Case-Tracker
//
//  Created by Josh Ketcham on 6/1/20.
//  Copyright © 2020 jketch. All rights reserved.
//

import UIKit

class Math: NSObject
{
    
    static func findPercentage(of integer: Int,
                               from total: Int) -> Int
    {
        let num = Double(integer) / Double(total)
        return Int(num.rounded(toPlaces: 2) * 100)
    }

}
