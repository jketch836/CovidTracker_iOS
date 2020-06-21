//
//  CountyCoords.swift
//  FL-Covid-Case-Tracker
//
//  Created by Josh Ketcham on 5/19/20.
//  Copyright © 2020 jketch. All rights reserved.
//

import Foundation

struct CountyCoords
{
    
    var latitude: Double
    var longitude: Double
    
}

extension CountyCoords: Codable {
    
    enum CodingKeys: String, CodingKey {
        case latitude
        case longitude
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(latitude, forKey: .latitude)
        try container.encode(longitude, forKey: .longitude)
        
    }
    
    init(from decoder: Decoder) throws {
         let values = try decoder.container(keyedBy: CodingKeys.self)
         latitude = try values.decode(Double.self, forKey: .latitude)
         longitude = try values.decode(Double.self, forKey: .longitude)
         
     }
}

//{
//  "date": 20200526,
//  "state": "CA",
//  "positive": 96733,
//  "negative": 1599663,
//  "pending": null,
//  "hospitalizedCurrently": 4404,
//  "hospitalizedCumulative": null,
//  "inIcuCurrently": 1392,
//  "inIcuCumulative": null,
//  "onVentilatorCurrently": null,
//  "onVentilatorCumulative": null,
//  "recovered": null,
//  "dataQualityGrade": "B",
//  "lastUpdateEt": "5/26/2020 00:00",
//  "hash": "c10019a47267304cfdeb7b73c433186046e6dd1f",
//  "dateChecked": "2020-05-26T20:00:00Z",
//  "death": 3814,
//  "hospitalized": null,
//  "total": 1696396,
//  "totalTestResults": 1696396,
//  "posNeg": 1696396,
//  "fips": "06",
//  "deathIncrease": 19,
//  "hospitalizedIncrease": 0,
//  "negativeIncrease": 50119,
//  "positiveIncrease": 2175,
//  "totalTestResultsIncrease": 52294
//}
//
//{
//  "state": "AK",
//  "positive": 411,
//  "positiveScore": 1,
//  "negativeScore": 1,
//  "negativeRegularScore": 1,
//  "commercialScore": 1,
//  "grade": "A",
//  "score": 4,
//  "notes": "Please stop using the \"total\" field. Use \"totalTestResults\" instead. As of 4/24/20, \"grade\" is deprecated. Please use \"dataQualityGrade\" instead.",
//  "dataQualityGrade": "C",
//  "negative": 44553,
//  "pending": null,
//  "hospitalizedCurrently": 12,
//  "hospitalizedCumulative": null,
//  "inIcuCurrently": null,
//  "inIcuCumulative": null,
//  "onVentilatorCurrently": null,
//  "onVentilatorCumulative": null,
//  "recovered": 362,
//  "lastUpdateEt": "5/26 00:00",
//  "checkTimeEt": "5/26 15:04",
//  "death": 10,
//  "hospitalized": null,
//  "total": 44964,
//  "totalTestResults": 44964,
//  "posNeg": 44964,
//  "fips": "02",
//  "dateModified": "2020-05-26T04:00:00Z",
//  "dateChecked": "2020-05-26T19:04:00Z",
//  "hash": "2b6d43191575435333be44ef22782501a160fe22"
//}
