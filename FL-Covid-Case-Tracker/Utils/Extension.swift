//
//  Extension.swift
//  FL-Covid-Case-Tracker
//
//  Created by Josh Ketcham on 5/31/20.
//  Copyright © 2020 jketch. All rights reserved.
//

import Foundation
import UIKit

/* MARK: - UICollectionView Extensions */
extension UICollectionView
{
    
    func registerAll()
    {
        register(LineChartCell.self)
        register(LineChartTextCell.self)
        register(TextCell.self)
    }
    
    func register<T: UICollectionViewCell>(_: T.Type) where T: CellProtocol {
        let nib = UINib(nibName: T.identifier, bundle: nil)
        register(nib, forCellWithReuseIdentifier: T.identifier)
    }
    
    func dequeueReusableCell<T: UICollectionViewCell>(for indexPath: IndexPath) -> T where T: CellProtocol {
        guard let cell = dequeueReusableCell(withReuseIdentifier: T.identifier, for: indexPath) as? T else {
            fatalError("Could not dequeue cell with identifier: \(T.identifier)")
        }
        return cell
    }
    
}

/* MARK: - String Extensions */
extension String
{
    //MARK: CellProtocol Methods
    static func className(_ aClass: AnyClass) -> String
    {
        return NSStringFromClass(aClass).components(separatedBy: ".").last!
    }
    
    func substring(from index: Int) -> String
    {
        return String(describing: [..<self.index(self.startIndex, offsetBy: index)])
    }
    
    static func classString(_ aClass: AnyClass) -> String
    {
        return NSStringFromClass(aClass)
    }
    
}

/* MARK: - Double Extensions */
extension Double
{
    /// Rounds the double to decimal places value
    func rounded(toPlaces places: Double) -> Double
    {
        let divisor = pow(10.0, places)
        return (self * divisor).rounded() / divisor
    }
    
    
    //MARK: NSNumber Methods
    func formatted() -> String
    {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        let number = NSNumber(value: self)
        guard let formattedNumber = numberFormatter.string(from: number) else { return "\(self)"}
        return formattedNumber
    }
}

/* MARK: - Int Extensions */
extension Int
{
    
    //MARK: NSNumber Methods
    func formatted() -> String
    {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        let number = NSNumber(value: self)
        guard let formattedNumber = numberFormatter.string(from: number) else { return "\(self)"}
        return formattedNumber
    }
    
}

extension UIViewController {
    func addChild(_ child: UIViewController, in containerView: UIView)
    {
        guard containerView.isDescendant(of: view) else { return }
        addChild(child)
        containerView.addSubview(child.view)
        child.view.pinToSuperview()
        child.didMove(toParent: self)
    }

    func removeChild(_ child: UIViewController)
    {
        child.willMove(toParent: nil)
        child.view.removeFromSuperview()
        child.removeFromParent()
    }
}

extension UIView {
    func pinToSuperview(with insets: UIEdgeInsets = .zero, edges: UIRectEdge = .all)
    {
        guard let superview = superview else { return }
        translatesAutoresizingMaskIntoConstraints = false
        if edges.contains(.top)
        {
            topAnchor.constraint(equalTo: superview.topAnchor, constant: insets.top).isActive = true
        }
        if edges.contains(.bottom)
        {
            bottomAnchor.constraint(equalTo: superview.bottomAnchor, constant: -insets.bottom).isActive = true
        }
        if edges.contains(.left)
        {
            leadingAnchor.constraint(equalTo: superview.leadingAnchor, constant: insets.left).isActive = true
        }
        if edges.contains(.right)
        {
            trailingAnchor.constraint(equalTo: superview.trailingAnchor, constant: -insets.right).isActive = true
        }
    }
}


extension Date
{

    init(milliseconds: Double)
    {
        self = Date(timeIntervalSince1970: TimeInterval(milliseconds))
    }
    
    static func configureDate(from dateToConvert: String) -> Date?
    {
        guard !dateToConvert.isEmpty else { return nil }
        let dateFormatter = DateFormatter()
        let dateFormatString = dateToConvert.count > 15 ? "yyyy-MM-dd HH:mm:ss" : "M/dd/yyyy HH:mm"
        dateFormatter.dateFormat = dateFormatString
        dateFormatter.locale = Locale.current
        let date = dateFormatter.date(from: dateToConvert)
        return date
    }
    
    static func configureDateDouble(date: Int) -> Date?
    {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyyddMM"
        let dateString = String(date)
        let date = dateFormatter.date(from: dateString)
        return date
    }
    
    static func toDouble(from integer: Int) -> Double
    {
        guard let configureDate = self.configureDateDouble(date: integer) else { return 0.0 }
        return Double(configureDate.timeIntervalSince1970)
    }
    
    static func convertDateToDouble(from string: String?) -> Double
    {
        guard let string = string,
              let configureDate = self.configureDate(from: string) else { return 0.0 }
              print(configureDate.timeIntervalSince1970)
        return Double(configureDate.timeIntervalSince1970)
    }
}
