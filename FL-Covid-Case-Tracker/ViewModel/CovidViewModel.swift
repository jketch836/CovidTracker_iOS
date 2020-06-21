//
//  CovidViewModel.swift
//  FL-Covid-Case-Tracker
//
//  Created by Josh Ketcham on 5/29/20.
//  Copyright © 2020 jketch. All rights reserved.
//

import UIKit

class CovidViewModel: NSObject
{

    let covidService: CovidParseService
    
    var loadedGraph: (()->())?
    
    var covidData: CovidDataSource?
    {
        didSet
        {
            self.loadedGraph?()
        }
    }
    
    init(_ covidService: CovidParseService = CovidParseService())
    {
        self.covidService = covidService
    }
    
    func getData(from state: String)
    {
        
        guard state.count == 2, let url = try? States.daily(state: state).urlRequest().url else { return }
        print(url.absoluteString)
        
        self.covidData?.statesData.removeAll()
        
        covidService.getCovidTrackingData(from: url)
        {
            [weak self] result in

            guard let self = self else { return }
            
            switch result
            {
                
            case .success(let datasource):
                
                guard let dataSource = datasource else { return }
                self.covidData = dataSource
                
            case .failure(let statusError):
                
                print("ERROR: \(statusError.localizedDescription)")
                
            }
        }
        
    }
    
    func getUSAData()
    {
        
        guard let url = try? USA.daily.urlRequest().url else { return }
        print(url.absoluteString)
        
        self.covidData?.statesData.removeAll()
        
        covidService.getCovidTrackingData(from: url)
        {
            [weak self] result in

            guard let self = self else { return }
            
            switch result
            {
                
            case .success(let datasource):
                
                guard let dataSource = datasource else { return }
                self.covidData = dataSource
                
            case .failure(let statusError):
                
                print("ERROR: \(statusError.localizedDescription)")
                
            }
        }
        
    }
    
    func totalForState() -> String
    {
        guard let stateData = covidData?.statesData else { return "" }
        let total = stateData[stateData.count - 1].totalTestResults.formatted()
        return "Total Tests: \(total)"
    }
    
}
