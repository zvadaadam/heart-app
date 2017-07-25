//
//  GraphViewController.swift
//  HearthApp
//
//  Created by Adam Zvada on 17.07.17.
//  Copyright © 2017 Adam Zvada. All rights reserved.
//

import Foundation
import UIKit
import Charts

class GraphViewController : UIViewController, ChartViewDelegate {
    
    @IBOutlet weak var currentRate: CurrentRateView!
    
    @IBOutlet weak var graphView: GraphLineView!
    
    @IBOutlet weak var friendsCollection: UICollectionView!
    
    var counter = 0
    
    let sampleFrequency = 5;
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        graphView.delegate = self
        
        //TODO, TMP MOCK!
        let data = createMockData()
        graphView.createLine(xData: data.x, yData: data.y, color: .red)
        
        let data1 = createMockData()
        graphView.createLine(xData: data1.x, yData: data1.y, color: .blue)
    }
    
    
 
    func chartTranslated(_ chartView: ChartViewBase, dX: CGFloat, dY: CGFloat) {
        //print("HELLO")
    }
    
    func chartValueSelected(_ chartView: ChartViewBase, entry: ChartDataEntry, highlight: Highlight) {
        print(entry.y)
        
        let dataSet = chartView.data?.dataSets[highlight.dataSetIndex]
        let colors = dataSet?.colors
        
        currentRate.changeRateValue(rate: Int(entry.y), colorRing: (colors?.first)!)
        
        //graphView.highlightValue(highlight)
    }
 
    
    func createMockData() -> (x: [Int], y: [Int]) {
        
        var x : [Int] = []
        var y : [Int] = []
        for i in 0 ... (24*(60/sampleFrequency)) {
            let num = i * sampleFrequency
            x.append(num)
            y.append(Int(getRndPuls()))
        }
        
        return (x: x, y: y)
    }
    
    func getRndPuls() -> UInt32 {
        counter += 1
        return (arc4random_uniform(150) + 40)
    }
    
    
}

