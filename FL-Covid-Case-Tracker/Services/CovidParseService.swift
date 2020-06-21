//
//  CovidParseService.swift
//  FL-Covid-Case-Tracker
//
//  Created by Josh Ketcham on 5/29/20.
//  Copyright © 2020 jketch. All rights reserved.
//

import UIKit
import SwiftyJSON

class CovidParseService: NSObject, CovidAPI
{
    
    func parseJSON(data: Data?) -> CovidDataSource?
    {
        guard let data = data, let json = try? JSON(data: data) else { return nil }
        
        if let array = json.array
        {
            return configure(json: array)
        }
        
        return configure(json: json)
        
    }
    
    func configure(json array: [JSON]) -> CovidDataSource
    {
        let dataSource = CovidDataSource()
        for item in array
        {
            dataSource.statesData.append(covidItem(from: item))
        }
        dataSource.statesData.reverse()
        return dataSource
    }
    
    func configure(json: JSON) -> CovidDataSource
    {
        let dataSource = CovidDataSource()
        dataSource.statesData.append(covidItem(from: json))
        dataSource.statesData.reverse()
        return dataSource
    }

    func covidItem(from json: JSON) -> StateData
    {
        let state = StateData()
        
        state.state = json["state"].string ?? ""
        state.hospitalizedCurrently = json["hospitalizedCurrently"].int ?? 0
        state.hospitalizedCumulative = json["hospitalizedCumulative"].int ?? 0
        state.inIcuCurrently = json["inIcuCurrently"].int ?? 0
        state.inIcuCumulative = json["inIcuCumulative"].int ?? 0
        state.hashCode = json["hash"].string ?? ""
        state.positive = json["positive"].int ?? 0
        state.negative = json["negative"].int ?? 0
        state.recovered = json["recovered"].int ?? 0
        state.totalTestResults = json["totalTestResults"].int ?? 0
        let lastUpdateEt: String = json["lastUpdateEt"].string ?? ""
        let dateChecked: String? = json["dateChecked"].string?.replacingOccurrences(of: "T", with: " ").replacingOccurrences(of: "Z", with: "")
        state.dateTime = lastUpdateEt.count > 0 ? lastUpdateEt :  dateChecked
        state.pending = json["pending"].string ?? ""
        state.inIcuCurrently = json["inIcuCurrently"].int ?? 0
        state.inIcuCumulative = json["inIcuCumulative"].int ?? 0
        state.death = json["death"].int ?? 0
        state.pending = json["pending"].string ?? ""
        state.onVentilatorCurrently = json["onVentilatorCurrently"].string ?? ""
        state.onVentilatorCumulative = json["onVentilatorCumulative"].string ?? ""
        state.totalTestResultsIncrease = json["totalTestResultsIncrease"].string ?? ""
        state.date = json["date"].int ?? 0
        
        return state
    }
    
}
