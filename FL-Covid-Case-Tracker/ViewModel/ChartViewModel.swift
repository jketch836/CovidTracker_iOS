//
//  ChartViewModel.swift
//  FL-Covid-Case-Tracker
//
//  Created by Josh Ketcham on 5/29/20.
//  Copyright © 2020 jketch. All rights reserved.
//

import UIKit
import Charts

enum CovidDataSet: Int
{
    
    case death, positive, negative, recovered, hospitalized, all, current
    
    static let name: [CovidDataSet: String] = [
        .death: "Deaths",
        .positive: "Positive",
        .recovered: "Recovered",
        .hospitalized: "Hospitalized",
        .negative: "Negative"
    ]
    
    var name: String {
        return CovidDataSet.name[self]!
    }
    
}

class ChartViewModel: NSObject
{
    
    private var dataSource = CovidDataSource()
    
    private var dataEntryArray = [ChartDataEntry]()
    
    weak var chartDelegate: ChartPressedProtocol? = nil
    
    init(vm: CovidViewModel)
    {
        guard let dataSource = vm.covidData else { return }
        self.dataSource = dataSource
    }
    
    func processAllCovidData() -> LineChartData
    {
        
        var deathSet = [ChartDataEntry]()
        var positiveCaseSet = [ChartDataEntry]()
        var negativeCaseSet = [ChartDataEntry]()
        var recoveredCaseSet = [ChartDataEntry]()
        var hospitalizedCaseSet = [ChartDataEntry]()
        
        for (_, data) in dataSource.statesData.enumerated()
        {
            if let dateString = data.dateTime
            {
                
                let timeInterval = Date.convertDateToDouble(from: dateString)
                //            let date = Double(data.date)
                
                
                deathSet.append(ChartDataEntry(x: timeInterval,
                                               y: Double(data.death)))
                positiveCaseSet.append(ChartDataEntry(x: timeInterval,
                                                      y: Double(data.positive)))
                negativeCaseSet.append(ChartDataEntry(x: timeInterval,
                                                      y: Double(data.negative)))
                recoveredCaseSet.append(ChartDataEntry(x: timeInterval,
                                                       y: Double(data.recovered)))
                hospitalizedCaseSet.append(ChartDataEntry(x: timeInterval,
                                                          y: Double(data.hospitalizedCumulative)))
            }
            
        }
        
        let deathData = customLineChartDataSet(with: deathSet,
                                               labelText: "Deaths",
                                               color: .red)
        
        let positiveCaseData = customLineChartDataSet(with: positiveCaseSet,
                                                      labelText: "Positive Cases",
                                                      color: .orange)
        
        let negativeCaseData = customLineChartDataSet(with: negativeCaseSet,
                                                      labelText: "Negative Cases",
                                                      color: .darkGray)
        
        let recoveredCaseData = customLineChartDataSet(with: recoveredCaseSet,
                                                       labelText: "Recovered",
                                                       color: .green)
        
        let hospitalizedCaseData = customLineChartDataSet(with: hospitalizedCaseSet,
                                                          labelText: "Hospitalized",
                                                          color: .purple)
        
        let lineChart = LineChartData(dataSets: [deathData, positiveCaseData, negativeCaseData, recoveredCaseData, hospitalizedCaseData])
        
        return lineChart
        
    }
    
    func customLineChartDataSet(with chartEntry: [ChartDataEntry],
                                labelText: String,
                                color: UIColor) -> LineChartDataSet
    {
        let dataSet = LineChartDataSet(entries: chartEntry, label: labelText)
        dataSet.colors = [color]
        dataSet.circleColors = dataSet.colors
        dataSet.lineWidth = 2
        dataSet.drawCirclesEnabled = false
        return dataSet
    }
    
    
    
    func processCovidData(for dataSet: CovidDataSet) -> (chartData: [ChartDataEntry], color: UIColor)
    {
        
        var color: UIColor = UIColor.red
        
        for (_, data) in zip(dataSource.statesData.indices, dataSource.statesData)
        {
            if let date = data.dateTime
            {
                
                let timeInterval = Date.convertDateToDouble(from: date)
                
                var entry: ChartDataEntry = ChartDataEntry()
                
                switch dataSet
                {
                case .death:
                    entry = ChartDataEntry(x: timeInterval,
                                           y: Double(data.death))
                    color = .systemRed
                case .positive:
                    entry = ChartDataEntry(x: timeInterval,
                                           y: Double(data.positive))
                    color = .systemOrange
                case .negative:
                    entry = ChartDataEntry(x: timeInterval,
                                           y: Double(data.negative))
                    color = .systemGray
                case .recovered:
                    entry = ChartDataEntry(x: timeInterval,
                                           y: Double(data.recovered))
                    color = .systemGreen
                case .hospitalized:
                    entry = ChartDataEntry(x: timeInterval,
                                           y: Double(data.hospitalizedCumulative))
                    color = .systemPurple
                default:
                    break
                }
                
                dataEntryArray.append(entry)
            }
        }
        
        return (dataEntryArray, color)
    }
    
    func configureCovidData(for dataSet: CovidDataSet) -> (chartData: LineChartData, label: String?, entry: Double)
    {
        
        let covidData = processCovidData(for: dataSet)
        
        let chartDataSet = customLineChartDataSet(with: covidData.chartData,
                                                  labelText: dataSet.name,
                                                  color: covidData.color)
        chartDataSet.fillAlpha = 0.25
        chartDataSet.fill = Fill.fillWithLinearGradient(self.setGradient(with: covidData.color), angle: 45)
        chartDataSet.drawFilledEnabled = true
        
        let linechart = LineChartData(dataSet: chartDataSet)
        
        let lastIndexOfChartData = dataEntryArray[dataEntryArray.count - 1].y
        
        return (linechart, chartDataSet.label, lastIndexOfChartData)
        
    }
    
    func processAllCovidData(from covidData: [CovidDataSet] = [.positive, .negative, .recovered, .death, .hospitalized]) -> LineChartData
    {
        
        var lineChartArray = [LineChartData]()
        
        for dataSet in covidData
        {
            let chartDataSet = configureCovidData(for: dataSet)
            lineChartArray.append(chartDataSet.chartData)
        }
        
        let lineChart = LineChartData(dataSets: lineChartArray as? [IChartDataSet])
        
        return lineChart
        
    }
    
    
    func processPercentageOfCases(from dataSet: CovidDataSet) -> Int
    {
        
        let currentStats = dataSource.statesData[dataSource.statesData.count - 1]
        let totalCases = currentStats.totalTestResults
        let positive = currentStats.positive
        
        var processedPercentage: Int = 0
        
        switch dataSet
        {
        case .death:
            processedPercentage = Math.findPercentage(of: currentStats.death, from: positive)
        case .positive:
            processedPercentage = Math.findPercentage(of: positive, from: totalCases)
        case .negative:
            processedPercentage = Math.findPercentage(of: currentStats.negative, from: totalCases)
        case .recovered:
            processedPercentage = Math.findPercentage(of: currentStats.recovered, from: positive)
        case .hospitalized:
            processedPercentage = Math.findPercentage(of: currentStats.hospitalizedCumulative, from: positive)
        default:
            break
        }
        
        return processedPercentage
    }
    
    func configure(_ lineGragh: inout LineChartView, from dataSet: CovidDataSet?)
    {
        
        lineGragh.noDataFont = UIFont.Body.subHeadline(with: 16)
        lineGragh.rightAxis.enabled = false
        lineGragh.legend.form = .line
        self.configureLegend(for: &lineGragh)
        guard let dataSet = dataSet else { return }
        lineGragh.noDataText = "There is no data for \(dataSet.name) Cases"
        
    }
    
    private func configureXAxis(from lineGragh: inout LineChartView)
    {
        let xAxis = lineGragh.xAxis
        xAxis.labelFont = .systemFont(ofSize: 12, weight: .semibold)
        xAxis.drawAxisLineEnabled = false
        xAxis.drawGridLinesEnabled = true
        xAxis.centerAxisLabelsEnabled = true
        xAxis.labelTextColor = UIColor.black
        xAxis.valueFormatter = self
    }
    
    private func configureLegend(for lineGragh: inout LineChartView)
    {
        let l = lineGragh.legend
        l.horizontalAlignment = .right
        l.verticalAlignment = .bottom
        l.orientation = .horizontal
        l.drawInside = false
        l.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        self.configureXAxis(from: &lineGragh)
    }
    
    
    private func setGradient(with color: UIColor) -> CGGradient
    {
        // Colors of the gradient
        let gradientColors = [color.cgColor, UIColor.clear.cgColor] as CFArray
        // Positioning of the gradient
        let colorLocations: [CGFloat] = [1.0, 0.0]
        // Gradient Object
        let gradient = CGGradient(colorsSpace: CGColorSpaceCreateDeviceRGB(), colors: gradientColors, locations: colorLocations)
        return gradient!
    }
    
}

extension ChartViewModel : IAxisValueFormatter
{
    
    func stringForValue(_ value: Double, axis: AxisBase?) -> String
    {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM dd"
        
        let date = Date(timeIntervalSince1970: value)
        let dateString = dateFormatter.string(from: date)
        return dateString
    }
    
}


extension ChartViewModel : ChartViewDelegate
{
    
    func chartValueSelected(_ chartView: ChartViewBase, entry: ChartDataEntry, highlight: Highlight)
    {
        print(entry.description)
        chartDelegate?.chartEntry(xAxis: entry.x, yAxis: entry.y)
        
    }
    
}
