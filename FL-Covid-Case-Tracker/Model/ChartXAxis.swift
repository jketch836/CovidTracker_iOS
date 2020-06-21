//
//  ChartXAxis.swift
//  FL-Covid-Case-Tracker
//
//  Created by Josh Ketcham on 6/16/20.
//  Copyright © 2020 jketch. All rights reserved.
//

import UIKit
import Charts

class ChartXAxis: IAxisValueFormatter
{
    
    private let values: [ChartDataEntry];

    init(_ values: [ChartDataEntry])
    {
        self.values = values
    }

    func stringForValue(_ value: Double, axis: AxisBase?) -> String
    {

//        let index = Int(value)
//        let entry = values[index]
//
//        guard let stateData = entry.data as? StateData else
//        {
//            fatalError("whoops")
//        }
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM dd"

//        let date = Date.convertDateToDouble(from: stateData.dateChecked ?? "")
//        let configuredDate = Date(milliseconds: date)
//
//        return dateFormatter.string(from: configuredDate)
//        return stateData.dateChecked!

        let date = Date(timeIntervalSince1970: value)
        return dateFormatter.string(from: date)

    }

}
