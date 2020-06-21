//
//  CovidAnnotation.swift
//  FL-Covid-Case-Tracker
//
//  Created by Josh Ketcham on 5/31/20.
//  Copyright © 2020 jketch. All rights reserved.
//

import UIKit
import MapKit

class CovidAnnotation: MKPointAnnotation
{

    func annotationView() -> MKAnnotationView
    {
        let view = MKAnnotationView(annotation: self, reuseIdentifier: "CovidAnnotation")
        view.translatesAutoresizingMaskIntoConstraints = false
        view.isEnabled = true
        view.canShowCallout = true
        view.image = UIImage(named: "location-4")
        view.rightCalloutAccessoryView = UIButton(type: UIButton.ButtonType.custom)
        view.centerOffset = CGPoint(x: 0, y: -32)
        return view
    }
    
}
