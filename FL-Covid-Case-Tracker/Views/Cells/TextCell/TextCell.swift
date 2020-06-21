//
//  TextCell.swift
//  FL-Covid-Case-Tracker
//
//  Created by Josh Ketcham on 6/2/20.
//  Copyright © 2020 jketch. All rights reserved.
//

import UIKit

class TextCell: UICollectionViewCell, CellProtocol
{
    
    @IBOutlet weak var cvlabel: CVLabel!
    
    func setup(vm: CovidViewModel, with dataSet: CovidDataSet?)
    {
        self.cvlabel.text = vm.totalForState()
    }

}
