//
//  County.swift
//  FL-Covid-Case-Tracker
//
//  Created by Josh Ketcham on 5/18/20.
//  Copyright © 2020 jketch. All rights reserved.
//

import UIKit
import MapKit

struct StateData
{
    
    var state : String = ""
    var positive : Int = 0
    var negative : Int = 0
    var recovered : Int = 0
    var dataQualityGrade : String = ""
    var notes : String = ""
    var pending : String? = ""
    var inIcuCurrently : String? = ""
    var inIcuCumulative : String? = ""
    var dateModified : String = ""
    var hospitalizedCurrently : Int? = 0
    var hospitalizedCumulative : Int? = 0
    var death : Int = 0
    var totalTestResults : Int = 0
    var hash : String = ""
    var onVentilatorCurrently : String? = ""
    var onVentilatorCumulative : String? = ""
    var totalTestResultsIncrease : String = ""
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



//
//struct County : Codable
//{
//    var properties : Properties
//}
//
//struct Properties : Codable
//{
//
//    var Age_0_4: Int
//    var Age_5_14: Int
//    var Age_15_24: Int
//    var Age_25_34: Int
//    var Age_35_44: Int
//    var Age_45_54: Int
//    var Age_55_64: Int
//    var Age_65_74: Int
//    var Age_75_84: Int
//    var Age_85plus: Int
//    var Age_Unkn: Int
//
//    //    var geography: MKPolygon // geometry
//    var COUNTY: String // COUNTY
//    var County_1: String // County_1 \\ COUNTYNAME
//    var TNegative: Int // TNegative
//    var C_AgeMedian: String // C_AgeMedian
//    var TPositive: Int // TPositive
//
//}
//
//extension County: Codable
//{
//
//    enum CodingKeys: String, CodingKey {
//        case age_0_4
//        case age_5_14
//        case age_15_24
//        case age_25_34
//        case age_35_44
//        case age_45_54
//        case age_55_64
//        case age_65_74
//        case age_75_84
//        case age_85plus
//        case age_Unkn
//
//        case geography // geometry
//        case number  // COUNTY
//        case name // County_1 \\ COUNTYNAME
//        case negative // TNegative
//        case meadianRange // C_ageMedian
//
//
//        enum CoordKeys: String, CodingKey {
//            case lat
//            case long
//        }
//    }
//
//    // MARK: - ENCODER
//    func encode(to encoder: Encoder) throws
//    {
//
//        var container = encoder.container(keyedBy: CodingKeys.self)
//        try container.encode(age_0_4, forKey: .age_0_4)
//        try container.encode(age_5_14, forKey: .age_5_14)
//        try container.encode(age_15_24, forKey: .age_15_24)
//        try container.encode(age_25_34, forKey: .age_25_34)
//        try container.encode(age_35_44, forKey: .age_35_44)
//        try container.encode(age_45_54, forKey: .age_45_54)
//        try container.encode(age_55_64, forKey: .age_55_64)
//        try container.encode(age_65_74, forKey: .age_65_74)
//        try container.encode(age_75_84, forKey: .age_75_84)
//        try container.encode(age_85plus, forKey: .age_85plus)
//        try container.encode(age_Unkn, forKey: .age_Unkn)
//        try container.encode(name, forKey: .name)
//        try container.encode(number, forKey: .number)
//        try container.encode(negative, forKey: .negative)
//        try container.encode(meadianRange, forKey: .meadianRange)
//        try container.encode(geography, forKey: .geography)
//
//    }
//    // MARK: - DECODER
//    init(from decoder: Decoder) throws
//    {
//        let values = try decoder.container(keyedBy: CodingKeys.self)
//
//        age_0_4 = try values.decode(String.self, forKey: .age_0_4)
//        age_5_14 = try values.decode(String.self, forKey: .age_5_14)
//        age_15_24 = try values.decode(String.self, forKey: .age_15_24)
//        age_25_34 = try values.decode(String.self, forKey: .age_25_34)
//        age_35_44 = try values.decode(String.self, forKey: .age_35_44)
//        age_45_54 = try values.decode(String.self, forKey: .age_45_54)
//        age_55_64 = try values.decode(String.self, forKey: .age_55_64)
//        age_65_74 = try values.decode(String.self, forKey: .age_65_74)
//        age_75_84 = try values.decode(String.self, forKey: .age_75_84)
//        age_85plus = try values.decode(String.self, forKey: .age_85plus)
//        age_Unkn = try values.decode(String.self, forKey: .age_Unkn)
//        name = try values.decode(String.self, forKey: .name)
//        number = try values.decode(Int.self, forKey: .number)
//        negative = try values.decode(String.self, forKey: .negative)
//        meadianRange = try values.decode(Int.self, forKey: .meadianRange)
//
////
////
////        self.lat = try values.decodeIfPresent(Double.self, forKey: .lat)
////        self.lon = try values.decodeIfPresent(Double.self, forKey: .lon)
////        let location = try values.nestedContainer(keyedBy: CoordKeys.self, forKey: .country)
////        country = try location.decode(String.self, forKey: .country)
//
//    }
//}
