//
//  CountyPolygon.swift
//  FL-Covid-Case-Tracker
//
//  Created by Josh Ketcham on 5/19/20.
//  Copyright © 2020 jketch. All rights reserved.
//

import UIKit

struct CountyPolygon
{
    
    var coords: CountyCoords
    
}

//extension CountyCoords: Codable {
//
//    enum CodingKeys: String, CodingKey {
//        case latitude
//        case longitude
//    }
//
//    func encode(to encoder: Encoder) throws {
//        var container = encoder.container(keyedBy: CodingKeys.self)
//        try container.encode(latitude, forKey: .latitude)
//        try container.encode(longitude, forKey: .longitude)
//
//    }
//
//    init(from decoder: Decoder) throws {
//         let values = try decoder.container(keyedBy: CodingKeys.self)
//         latitude = try values.decode(Double.self, forKey: .latitude)
//         longitude = try values.decode(Double.self, forKey: .longitude)
//
//     }
//}
