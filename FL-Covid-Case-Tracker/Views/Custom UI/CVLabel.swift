//
//  CVLabel.swift
//  FL-Covid-Case-Tracker
//
//  Created by Josh Ketcham on 6/2/20.
//  Copyright © 2020 jketch. All rights reserved.
//

import UIKit

enum LabelType: String
{
    case title = "title" // lowercase to make it case-insensitive
    case subtitle = "subtitle"
    case body = "body"
    case light = "light"
    case none = ""
}


@IBDesignable
class CVLabel: UILabel
{

    var labelType: LabelType = .title { // default label type
        didSet {
            self.configureLabel()
        }
    }
    
    
    @available(*, unavailable, message: "This property is reserved for Interface Builder. Use 'labelType' instead.")
    @IBInspectable var setLabelType: String? {
        get {
            return labelType.rawValue
        }
        set {
            // Ensure user enters a valid shape while making it lowercase.
            // Ignore input if not valid.
            if let labelType = LabelType(rawValue: newValue?.lowercased() ?? "") {
                self.labelType = labelType
            }
        }
    }
    
    @IBInspectable var size: CGFloat = 0 { // default font size type
        didSet {
            self.configureLabel()
        }
    }
    
    @IBInspectable var textColorName: String? {
        didSet {
            self.configureLabel()
        }
    }
    
    @IBInspectable var backgroundColorName: String? {
        didSet {
            self.configureLabel()
        }
    }

    
    func configureLabel() {
        self.layer.cornerRadius = 30
        self.layer.masksToBounds = true
        self.textAlignment = .center
        self.backgroundColor = .black
        self.font = self.configureFont(with: size)
    }
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        self.configureLabel()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.configureLabel()
    }
    
    override func awakeFromNib() {
        self.configureLabel()
    }
    
    override func prepareForInterfaceBuilder() {
        self.configureLabel()
        
        self.setNeedsLayout()
        self.setNeedsDisplay()
        self.setNeedsUpdateConstraints()
        self.layoutIfNeeded()
    }
    
    func configureFont(with size: CGFloat) -> UIFont {
        switch labelType {
        case .title:
            return UIFont.Title.headline(with: size)
        case .subtitle:
            return UIFont.SubTitle.headline(with: size)
        case .body:
            return UIFont.Body.headline(with: size)
        default:
            return UIFont.Light.headline(with: size)
        }
    }
    
    
}
