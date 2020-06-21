//
//  LineChartTextCell.swift
//  FL-Covid-Case-Tracker
//
//  Created by Josh Ketcham on 6/2/20.
//  Copyright © 2020 jketch. All rights reserved.
//

import UIKit
import Charts

class LineChartTextCell: UICollectionViewCell, CellProtocol
{
    
    @IBOutlet weak var lineGragh: LineChartView!
    @IBOutlet weak var graphTitle: CVLabel!
    @IBOutlet weak var notes: UILabel!
    
    func setup(vm: CovidViewModel, with dataSet: CovidDataSet?)
    {
        guard let dataSet = dataSet else { return }
        
        let chartvm = ChartViewModel(vm: vm)
        chartvm.chartDelegate = self
        let data = chartvm.configureCovidData(for: dataSet)
        
        
        chartvm.configure(&self.lineGragh, from: dataSet)
        let dataPercentage = chartvm.processPercentageOfCases(from: dataSet)
        
        if dataPercentage != 0
        {
            lineGragh.data = data.chartData
            lineGragh.delegate = chartvm
        }
        
        let isPositiveSet = dataSet == .positive
        let isNegativeSet = dataSet == .negative
        
        let graphString = (isPositiveSet || isNegativeSet) ? "\(data.label!): \(data.entry.formatted()) (\(dataPercentage)%)" :"\(data.label!): \(data.entry.formatted()) (\(dataPercentage)%)\u{0002A}"
        
        configureNotesLabel(dataSet: dataSet)
        
        self.graphTitle.text = dataPercentage != 0 ? graphString : "\(dataSet.name): N/A"
    }
    
    func configureNotesLabel(dataSet: CovidDataSet)
    {
        let isPositiveSet = dataSet == .positive
        let isNegativeSet = dataSet == .negative
        self.notes.isHidden = isPositiveSet || isNegativeSet
        let dataSetConfigured: CovidDataSet = .positive
        
        self.notes.text = "\u{0002A} Percentage calculated by number of \(dataSetConfigured.name) Cases."
    }
    
}

extension LineChartTextCell : ChartPressedProtocol
{
    
    func chartEntry(xAxis: Double, yAxis: Double)
    {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM dd, yyyy"
        
        let date = Date(timeIntervalSince1970: xAxis)
        
        print("\n-xAxis: \(dateFormatter.string(from: date))\n-yAxis: \(yAxis)")
    }
    
}
