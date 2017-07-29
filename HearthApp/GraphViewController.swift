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
    
    @IBOutlet weak var curRate: UILabel!
    
    @IBOutlet weak var curUser: UILabel!
    
    @IBOutlet weak var currentRate: CurrentRateView!
    
    @IBOutlet weak var graphView: GraphLineView!
    
    @IBOutlet weak var calendar: UICollectionView!
    
    var counter = 0
    let sampleFrequency = 5;
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        calendar.register(UINib(nibName: "CalendarCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "CalendarCell")
        
        calendar.register(UINib(nibName: "CalendarTodayCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "CalendarCellToday")
        
        graphView.delegate = self
        
        //TODO, TMP MOCK!
        let data = createMockData()
        graphView.createLine(xData: data.x, yData: data.y, color: .red)
        
        let data1 = createMockData()
        graphView.createLine(xData: data1.x, yData: data1.y, color: .blue)
        
        let data2 = createMockData()
        graphView.createLine(xData: data2.x, yData: data2.y, color: .yellow)
        
        let data3 = createMockData()
        graphView.createLine(xData: data3.x, yData: data3.y, color: .white)
    }
    
    func chartValueSelected(_ chartView: ChartViewBase, entry: ChartDataEntry, highlight: Highlight) {
        //let dataSet = chartView.data?.dataSets[highlight.dataSetIndex]
        //let colors = dataSet?.colors
        //currentRate.changeRateValue(rate: Int(entry.y), colorRing: (colors?.first)!)
        
        curRate.fadeTransition(0.6)
        curRate.text = String(Int(entry.y))
    
        //curUser.text = String(describing: colors?.first)
        
        graphView.highlightValue(highlight)
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

extension UIView {
    func fadeTransition(_ duration:CFTimeInterval) {
        let animation = CATransition()
        animation.timingFunction = CAMediaTimingFunction(name:
            kCAMediaTimingFunctionEaseInEaseOut)
        animation.type = kCATransitionFade
        animation.duration = duration
        layer.add(animation, forKey: kCATransitionFade)
    }
}

