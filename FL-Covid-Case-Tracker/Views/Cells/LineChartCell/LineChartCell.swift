//
//  LineChartCell.swift
//  FL-Covid-Case-Tracker
//
//  Created by Josh Ketcham on 5/31/20.
//  Copyright © 2020 jketch. All rights reserved.
//

import UIKit
import Charts

class LineChartCell: UICollectionViewCell, CellProtocol
{
    
    @IBOutlet weak var lineGragh: LineChartView!
    
    func setup(vm: CovidViewModel, with dataSet: CovidDataSet?)
    {
        
        let chartvm = ChartViewModel(vm: vm)
        chartvm.chartDelegate = self
        let data = chartvm.processAllCovidData()

        chartvm.configure(&self.lineGragh, from: nil)
        self.lineGragh.data = data
        self.lineGragh.delegate = chartvm
        
    }
    
}

extension LineChartCell : ChartPressedProtocol
{
    
    func chartEntry(xAxis: Double, yAxis: Double)
    {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM dd, yyyy"
        
        let date = Date(timeIntervalSince1970: xAxis)
        
        print("\n-xAxis: \(dateFormatter.string(from: date))\n-yAxis: \(yAxis)")
    }
    
}
