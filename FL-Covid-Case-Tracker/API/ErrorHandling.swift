//
//  ErrorHandling.swift
//  FedGov
//
//  Created by Josh Ketcham on 8/23/19.
//  Copyright © 2019 jketcham. All rights reserved.
//

import Foundation

enum StatusError: Error
{
    case bad_request(Int)
    case not_acceptable(Int)
    case forbidden(Int)
    case not_found(Int)
    case timeout(Int)
    case server(Int)
    case other(Error?)
    
    static func Code(for statusCode: Int) -> StatusError
    {
        switch statusCode {
        case 400:
            return .bad_request(statusCode)
        case 403:
            return .forbidden(statusCode)
        case 404:
            return .not_found(statusCode)
        case 406:
            return .not_acceptable(statusCode)
        case 500...503:
            return .server(statusCode)
        default:
            return .timeout(statusCode)
        }
    }
}

extension StatusError: LocalizedError
{
    public var errorDescription: String?
    {
        switch self
        {
        case .not_acceptable(let code):
            return NSLocalizedString("You requested a format that isn’t json or xml", comment: "Error Code \(code): Not Acceptable")
        case .forbidden(let code):
            return NSLocalizedString("Your request did not include an authorization header", comment: "Error Code \(code): Forbidden")
        case .not_found(let code):
            return NSLocalizedString("The specified record(s) could not be found", comment: "Error Code \(code): Not Found")
        case .server(let code):
            let internalError = NSLocalizedString("There was a problem with our server. Please Try again later.", comment: "Error Code \(code): Internal Server Error")
            let unavailable = NSLocalizedString("The service is currently not working. Please try again later.", comment: "Error Code \(code): Service Unavailable")
            return code == 500 ? internalError : unavailable
        case .timeout(let code):
            return NSLocalizedString("The server did not responed a timely response. Please try again.", comment: "Error Code \(code)")
        case .other(let error):
            return NSLocalizedString(error?.localizedDescription ?? "Something went wrong. Please Try again.", comment: "Error: \(error?.localizedDescription ?? "SERIOUS ERROR HERE. NOT SHOWING ERROR AT ALL")")
        case .bad_request(let code):
            return NSLocalizedString("Your request is improperly formed", comment: "Error Code \(code): Bad Request")
        }
    }
    
    var localizedDescription: String
    {
        switch self
        {
        case .not_acceptable(let code):
            return NSLocalizedString("You requested a format that isn’t json or xml", comment: "Error Code \(code): Not Acceptable")
        case .forbidden(let code):
            return NSLocalizedString("Your request did not include an authorization header", comment: "Error Code \(code): Forbidden")
        case .not_found(let code):
            return NSLocalizedString("The specified record(s) could not be found", comment: "Error Code \(code): Not Found")
        case .server(let code):
            let internalError = NSLocalizedString("There was a problem with our server. Please Try again later.", comment: "Error Code \(code): Internal Server Error")
            let unavailable = NSLocalizedString("The service is currently not working. Please try again later.", comment: "Error Code \(code): Service Unavailable")
            return code == 500 ? internalError : unavailable
        case .timeout(let code):
            return NSLocalizedString("The server did not responed a timely response. Please try again.", comment: "Error Code \(code)")
        case .other(let error):
            return NSLocalizedString(error?.localizedDescription ?? "Something went wrong. Please Try again.", comment: "Error: \(error?.localizedDescription ?? "SERIOUS ERROR HERE. NOT SHOWING ERROR AT ALL")")
        case .bad_request(let code):
            return NSLocalizedString("Your request is improperly formed", comment: "Error Code \(code): Bad Request")
        }
    }
}
