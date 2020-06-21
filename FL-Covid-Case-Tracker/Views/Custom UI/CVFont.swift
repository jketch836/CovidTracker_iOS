//
//  CVFont.swift
//  FL-Covid-Case-Tracker
//
//  Created by Josh Ketcham on 6/2/20.
//  Copyright © 2020 jketch. All rights reserved.
//

import UIKit
import Foundation

extension UIFont {
    
    static func adjustFont(for fontSize: CGFloat,
                           textStyle: UIFont.TextStyle,
                           fontStyle: LabelType = .title) -> UIFont
    {
        
        let weight: UIFont.Weight
        
        switch fontStyle {
        case .title where textStyle == .headline:
            weight = .heavy
        case .title where textStyle == .subheadline:
            weight = .black
        case .title:
            weight = .bold
        case .subtitle where textStyle == .headline:
            weight = .bold
        case .subtitle where textStyle == .subheadline:
            weight = .black
        case .subtitle:
            weight = .semibold
        case .body where textStyle == .headline:
            weight = .semibold
        case .body where textStyle == .subheadline:
            weight = .medium
        case .body:
            weight = .regular
        case .light where textStyle == .headline:
            weight = .regular
        case .light where textStyle == .subheadline:
            weight = .light
        case .light, .none:
            weight = .ultraLight
        }
        
        self.preferredFont(forTextStyle: textStyle)
        
        let adjustedFont = UIFont.systemFont(ofSize: fontSize, weight: weight)
//        UIFont(name: "Helvetica", size: fontSize)
        return UIFontMetrics(forTextStyle: textStyle).scaledFont(for: adjustedFont)
    }
    
    struct Light
    {
        static let fontStyle: LabelType = .light
        
        static func normal(with size: CGFloat) -> UIFont { return adjustFont(for: size, textStyle: .body, fontStyle: fontStyle) }
        static func headline(with size: CGFloat) -> UIFont { return adjustFont(for: size, textStyle: .headline, fontStyle: fontStyle) }
        static func subHeadline(with size: CGFloat) -> UIFont { return adjustFont(for: size, textStyle: .subheadline, fontStyle: fontStyle) }
        
    }
    
    struct Body
    {
        static let fontStyle: LabelType = .body
        
        static func normal(with size: CGFloat) -> UIFont { return adjustFont(for: size, textStyle: .body, fontStyle: fontStyle) }
        static func headline(with size: CGFloat) -> UIFont { return adjustFont(for: size, textStyle: .headline, fontStyle: fontStyle) }
        static func subHeadline(with size: CGFloat) -> UIFont { return adjustFont(for: size, textStyle: .subheadline, fontStyle: fontStyle) }
        
    }
    
    struct SubTitle
    {
        static let fontStyle: LabelType = .subtitle
        
        static func normal(with size: CGFloat) -> UIFont { return adjustFont(for: size, textStyle: .body, fontStyle: fontStyle) }
        static func headline(with size: CGFloat) -> UIFont { return adjustFont(for: size, textStyle: .headline, fontStyle: fontStyle) }
        static func subHeadline(with size: CGFloat) -> UIFont { return adjustFont(for: size, textStyle: .subheadline, fontStyle: fontStyle) }
        
    }
    
    struct Title
    {
        static let fontStyle: LabelType = .title
        
        static func normal(with size: CGFloat) -> UIFont { return adjustFont(for: size, textStyle: .body, fontStyle: fontStyle) }
        static func headline(with size: CGFloat) -> UIFont { return adjustFont(for: size, textStyle: .headline, fontStyle: fontStyle) }
        static func subHeadline(with size: CGFloat) -> UIFont { return adjustFont(for: size, textStyle: .subheadline, fontStyle: fontStyle) }
        
    }
}
