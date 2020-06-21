//
//  EnumURL.swift
//  FL-Covid-Case-Tracker
//
//  Created by Josh Ketcham on 5/28/20.
//  Copyright © 2020 jketch. All rights reserved.
//

import Foundation

/// USA URL Enum
enum USA
{
    case current
    case date(date: Date)
    case daily
}

extension USA : CovidTargetAPI
{
    
    var path: String {
        switch self {
        case .current:
            return "us/current.json"
        case .daily:
            return "us/daily.json"
        case .date(let date):
            return "us/\(date).json"
        }
    }
    
}

/// States URL Enum
enum States
{
    case current(state: String?)
    case date(state: String, date: Date)
    case daily(state: String?)
    
    /// Dictionary of States
    static let dict: [String : String] =
    [
        "AL": "Alabama",
        "AK": "Alaska",
        "AS": "American Samoa",
        "AZ": "Arizona",
        "AR": "Arkansas",
        "CA": "California",
        "CO": "Colorado",
        "CT": "Connecticut",
        "DE": "Delaware",
        "DC": "District Of Columbia",
        "FM": "Federated States Of Micronesia",
        "FL": "Florida",
        "GA": "Georgia",
        "GU": "Guam",
        "HI": "Hawaii",
        "ID": "Idaho",
        "IL": "Illinois",
        "IN": "Indiana",
        "IA": "Iowa",
        "KS": "Kansas",
        "KY": "Kentucky",
        "LA": "Louisiana",
        "ME": "Maine",
        "MH": "Marshall Islands",
        "MD": "Maryland",
        "MA": "Massachusetts",
        "MI": "Michigan",
        "MN": "Minnesota",
        "MS": "Mississippi",
        "MO": "Missouri",
        "MT": "Montana",
        "NE": "Nebraska",
        "NV": "Nevada",
        "NH": "New Hampshire",
        "NJ": "New Jersey",
        "NM": "New Mexico",
        "NY": "New York",
        "NC": "North Carolina",
        "ND": "North Dakota",
        "MP": "Northern Mariana Islands",
        "OH": "Ohio",
        "OK": "Oklahoma",
        "OR": "Oregon",
        "PW": "Palau",
        "PA": "Pennsylvania",
        "PR": "Puerto Rico",
        "RI": "Rhode Island",
        "SC": "South Carolina",
        "SD": "South Dakota",
        "TN": "Tennessee",
        "TX": "Texas",
        "UT": "Utah",
        "VT": "Vermont",
        "VI": "Virgin Islands",
        "VA": "Virginia",
        "WA": "Washington",
        "WV": "West Virginia",
        "WI": "Wisconsin",
        "WY": "Wyoming"
    ]
    
}

extension States : CovidTargetAPI
{
    
    var path: String {
        switch self {
        case .current(let state):
            guard let state = state else { return "states/current.json" }
            return "states/\(state)/current.json"
        case .date(let state, let date):
            return "states/\(state)/\(date).json"
        case .daily(let state):
            guard let state = state else { return "states/daily.json" }
            return "states/\(state)/daily.json"
        }
    }
    
}
