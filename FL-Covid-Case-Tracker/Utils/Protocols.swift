//
//  Protocols.swift
//  FL-Covid-Case-Tracker
//
//  Created by Josh Ketcham on 5/31/20.
//  Copyright © 2020 jketch. All rights reserved.
//

import Foundation
import UIKit

protocol PresentProtocol
{
    
    /// shows alert with entered title and message
    /// - Parameters:
    ///   - title: title to be presented
    ///   - message: message to be presented
    func showAlert(title: String, message: String?)
    
}

extension PresentProtocol where Self: UIViewController
{
    
    func showAlert(title: String, message: String? = nil)
    {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(okAction)
        self.present(alert, animated: true, completion: nil)
    }
    
}

/// Conform this protocol to handles user press actions
@objc protocol CellPressProtocol
{
    
    /// optional user press action method
    /// - Parameter indexPath: indexPath from the TableView
    @objc optional func userPressed(at indexPath: IndexPath)
    
    /// optional user press action method
    /// - Parameters:
    ///   - collectionView: takes in a collectionView parameter
    ///   - indexPath: indexPath from the collectionView
    @objc optional func userPressed(in collectionView: UICollectionView, at indexPath: IndexPath)
}

protocol CellProtocol
{
    
    static func className(_ aClass: AnyClass) -> String
    
    /// cell height for table / collectionview cell
    static var cellHeight: CGFloat { get }
    
    /// Default function that configures cell data for
    /// - Parameter viewModel: a viewModel that conforms to CovidViewModel
    func setup(vm: CovidViewModel, with dataSet: CovidDataSet?)
    
}

extension CellProtocol where Self: UICollectionViewCell
{
    
    static func className(_ aClass: AnyClass) -> String
    {
        return NSStringFromClass(aClass).components(separatedBy: ".").last!
    }
    
    static var identifier: String
    {
        return String.className(self)
    }
    
    static var cellHeight : CGFloat
    {
        return 48
    }
    
    func setup(vm: CovidViewModel) { }
}

@objc protocol ChartPressedProtocol
{
    func chartEntry(xAxis: Double, yAxis: Double)
}
