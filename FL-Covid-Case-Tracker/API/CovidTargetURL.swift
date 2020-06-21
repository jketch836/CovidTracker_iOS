//
//  API.swift
//  FL-Covid-Case-Tracker
//
//  Created by Josh Ketcham on 5/28/20.
//  Copyright © 2020 jketch. All rights reserved.
//

import Foundation

protocol CovidTargetAPI
{
    
    /// The path to be appended to `baseURL` to form the full `URL`.
    var path: String { get }
    
    /// The method used to combine the full api request
    func urlRequest() throws -> URLRequest
    
}

extension CovidTargetAPI
{
    
    var baseURL: String
    {
        return "https://covidtracking.com/api/v1/"
    }
    
    func urlRequest() throws -> URLRequest
    {

        guard let covidURL = URL(string: "\(baseURL)\(path)") else { throw NSError(domain: "COVIDDOMAIN", code: 0, userInfo: nil) }
        
        return URLRequest(url: covidURL)
        
    }
    
}
