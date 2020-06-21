//
//  CovidURL.swift
//  FL-Covid-Case-Tracker
//
//  Created by Josh Ketcham on 5/28/20.
//  Copyright © 2020 jketch. All rights reserved.
//

import Foundation

// FL COUNTIES DATA
// "https://opendata.arcgis.com/datasets/a7887f1940b34bf5a02c6f7f27a5cb2c_0.geojson"

protocol CovidAPI
{
    
    /// Retreive Covid-19 data from https://covidtracking.com/api
    /// - Parameter url: url to retreive data from.
    /// - Example URL: "https://covidtracking.com/api/v1/us/current.json"
    func getCovidTrackingData(from url: URL, completionHandler: @escaping (Result<CovidDataSource?, StatusError>) -> Void)
    
    /// Parses COVID-19 data
    /// - Parameter data: data to ba parsed
    func parseJSON(data: Data?) -> CovidDataSource?
    
}

extension CovidAPI
{
    
    func getCovidTrackingData(from url: URL, completionHandler: @escaping (Result<CovidDataSource?, StatusError>) -> Void)
    {
        
        let session = URLSession.shared
        
        let task = session.dataTask(with: url) { data, response, error in
            
            if error != nil || data == nil
            {
                completionHandler(.failure(StatusError.other(error!)))
            }
            
            guard let response = response as? HTTPURLResponse, (200...299).contains(response.statusCode) else
            {
                completionHandler(.failure(StatusError.server(300)))
                return
            }
            
            completionHandler(.success(self.parseJSON(data: data)))
            
        }
        task.resume()
        
    }
    
}
