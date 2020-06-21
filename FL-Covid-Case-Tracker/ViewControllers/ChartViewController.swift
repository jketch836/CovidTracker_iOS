//
//  ChartViewController.swift
//  FL-Covid-Case-Tracker
//
//  Created by Josh Ketcham on 5/31/20.
//  Copyright © 2020 jketch. All rights reserved.
//

import UIKit

class ChartViewController: UICollectionViewController
{

    let cvm: CovidViewModel
    
    let covidTypeArray: [CovidDataSet] = [.current, .death, .recovered, .positive, .negative, .hospitalized, .all]

    init(with cvm: CovidViewModel)
    {
        self.cvm = cvm
        super.init(nibName: "ChartViewController", bundle: nil)
    }
    
    required init?(coder: NSCoder)
    {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad()
    {
        super.viewDidLoad()

        self.collectionView.registerAll()
        self.collectionView.translatesAutoresizingMaskIntoConstraints = true
        self.collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
    }

    // MARK: UICollectionViewDataSourcex
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        return covidTypeArray.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {
        
        let dataType: CovidDataSet = covidTypeArray[indexPath.row]
        
        switch dataType
        {
        case .all:
            let cell: LineChartCell = collectionView.dequeueReusableCell(for: indexPath)
            cell.setup(vm: self.cvm, with: nil)
            cell.setNeedsLayout()
            cell.layoutIfNeeded()
            return cell
        case .current:
            let cell: TextCell = collectionView.dequeueReusableCell(for: indexPath)
            cell.setup(vm: self.cvm, with: nil)
            cell.setNeedsLayout()
            cell.layoutIfNeeded()
            return cell
        default:
            let cell: LineChartTextCell = collectionView.dequeueReusableCell(for: indexPath)
            cell.setup(vm: self.cvm, with: dataType)
            cell.setNeedsLayout()
            cell.layoutIfNeeded()
            return cell
        }
        
    }
    
}

extension ChartViewController : UICollectionViewDelegateFlowLayout
{
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
    {
        let dataType: CovidDataSet = covidTypeArray[indexPath.row]
        
        switch dataType
        {
        case .all:
            return cellectionCellSize(for: collectionView)
        case .current:
            return cellectionCellSize(for: collectionView, isTitle: true)
        default:
            return cellectionCellSize(for: collectionView, isLineTextCell: true)
        }
    }
    
    func cellectionCellSize(for collectionView: UICollectionView, isLineTextCell: Bool = false, isTitle: Bool = false) -> CGSize
    {
        var width: CGFloat
        var height: CGFloat
        
        if isLineTextCell
        {
            width = collectionView.bounds.width / 2.15
            height = 300
        }
        else if isTitle
        {
            width = collectionView.bounds.width
            height = 150
        }
        else
        {
            width = collectionView.bounds.width
            height = width / 2
        }
        
        return CGSize(width: width, height: height)
    }
   
}
