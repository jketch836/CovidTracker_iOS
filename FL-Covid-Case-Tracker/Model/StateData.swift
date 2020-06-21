//
//  StateData.swift
//  FL-Covid-Case-Tracker
//
//  Created by Josh Ketcham on 5/28/20.
//  Copyright © 2020 jketch. All rights reserved.
//

import Foundation

class StateData: NSObject
{
    
    var state : String = ""                     //  "state": "CA"
    var positive : Int = 0                      //  "positive": 96733
    var negative : Int = 0                      //  "negative": 1599663
    var recovered : Int = 0                     //  "recovered": null
    var dataQualityGrade : String = ""          //  "dataQualityGrade": "B"
    var pending : String = ""                   //  "pending": null
    var inIcuCurrently : Int = 0                //  "inIcuCurrently": 1392
    var inIcuCumulative : Int = 0               //  "inIcuCumulative": null
    var hospitalizedCurrently : Int = 0         //  "hospitalizedCurrently": 4404
    var hospitalizedCumulative : Int = 0        //  "hospitalizedCumulative": null
    var death : Int = 0                         //  "death": 3814
    var totalTestResults : Int = 0              //  "totalTestResults": 1696396
    var hashCode : String = ""                  //  "hash": "2b6d43191575435333be44ef22782501a160fe22"
    var onVentilatorCurrently : String = ""     //  "onVentilatorCurrently": null
    var onVentilatorCumulative : String = ""    //  "onVentilatorCumulative": null
    var totalTestResultsIncrease : String = ""  //  "totalTestResultsIncrease": 52294
    var dateTime: String?                       //  "dateChecked": "2020-05-26T20:00:00Z"
    var date: Int = 0                           //  "date": 20200616
    
}
