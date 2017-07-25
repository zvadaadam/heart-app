//
//  GraphLineView.swift
//  HearthApp
//
//  Created by Adam Zvada on 18.07.17.
//  Copyright © 2017 Adam Zvada. All rights reserved.
//

import Foundation
import UIKit
import Charts

class GraphLineView : LineChartView {
    
    let granularity = 1
    let widthLine = 1
    let aplha = 1
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setGraphParam()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        setGraphParam()
    }
    
    func initGraphData() {
        let data : [ChartDataEntry] = []
        let dataSet : [LineChartDataSet] = [LineChartDataSet(values: data, label: "bpm")]
        self.data = LineChartData(dataSets: dataSet)
        self.data?.setDrawValues(false)
    }
    
    func createLine(xData: [Int], yData: [Int], color: NSUIColor) {
        
        var data : [ChartDataEntry] = []
        var timeData : [String] = []
        
        for i in 0 ..< xData.count {
            timeData.append(getHourAndMinStr(minFromNoon: xData[i]))
            data.append(ChartDataEntry(x: Double(i), y: Double(yData[i])))
        }
        
        let dataSet = LineChartDataSet(values: data, label: "bpm")
        
        setDataParam(dataSet: dataSet, color: color)
        
        //Set how xData will be presented
        self.xAxis.valueFormatter = IndexAxisValueFormatter(values: timeData)
        
        if self.data == nil {
            self.data = LineChartData(dataSet: dataSet)
        } else {
            self.data?.addDataSet(dataSet)
        }
        
        self.data?.setDrawValues(false)
        
        //Settings minimun zoom
        self.viewPortHandler.setMaximumScaleX((CGFloat(xData.count/5)))
    }
    
    func importFormattedData(xData: [String], yData: [Int]) {
        
        //TODO
        
    }
    
    func addLineWithData(xData: [Int], yData: [Int]) {
        var data : [ChartDataEntry] = []
        var timeData : [String] = []
        
        for i in 0 ..< xData.count {
            timeData.append(getHourAndMinStr(minFromNoon: xData[i]))
            data.append(ChartDataEntry(x: Double(i), y: Double(yData[i])))
        }
        
        let dataSet = LineChartDataSet(values: data, label: "bpm")
        
        setDataParam(dataSet: dataSet, color: .red)
        
        self.data?.addDataSet(dataSet)
    }
    
    
    private func setDataParam(dataSet: LineChartDataSet, color: NSUIColor) {
        
        //dataSet.mode = .horizontalBezier
        dataSet.mode = .linear
        dataSet.setColor(color)
        dataSet.lineWidth = CGFloat(widthLine)
        dataSet.drawCirclesEnabled = true
        dataSet.drawCircleHoleEnabled = false
        dataSet.drawIconsEnabled = false
        dataSet.circleColors = [color]
        dataSet.circleHoleColor = NSUIColor.black
        dataSet.circleHoleRadius = 1.5
        dataSet.circleRadius = 2.5

        
        //setGradientEffect(dataSet: dataSet)
    }
    
    private func setGraphParam() {
        self.noDataText = "No data provided"
        
        self.animate(xAxisDuration: 1.5, yAxisDuration: 1.0, easingOption: .easeInCubic)
        
        //turn off vertical zoom
        self.scaleYEnabled = false
        
        //No legend needded
        self.legend.enabled = false
        self.chartDescription?.text? = ""
        
        self.dragEnabled = true
        
        self.rightAxis.removeAllLimitLines()
        self.rightAxis.drawAxisLineEnabled = false
        self.rightAxis.drawGridLinesEnabled = false
        self.rightAxis.drawTopYLabelEntryEnabled = false
        self.rightAxis.drawBottomYLabelEntryEnabled = false
        self.rightAxis.drawLimitLinesBehindDataEnabled = false
        self.rightAxis.drawLabelsEnabled = false
        self.rightAxis.labelTextColor = UIColor.lightGray
        
        self.leftAxis.removeAllLimitLines()
        self.leftAxis.drawAxisLineEnabled = false
        self.leftAxis.drawGridLinesEnabled = false
        self.leftAxis.drawBottomYLabelEntryEnabled = false
        self.leftAxis.labelTextColor = UIColor.lightGray
        
        self.xAxis.drawAxisLineEnabled = false
        self.xAxis.drawGridLinesEnabled = false
        self.xAxis.drawLimitLinesBehindDataEnabled = false
        self.xAxis.labelPosition = .bottom
        self.xAxis.granularity = Double(granularity)
        self.xAxis.labelTextColor = UIColor.lightGray
        
        self.alpha = alpha
        
        self.xAxis.avoidFirstLastClippingEnabled = true
        
        //self.zoom(scaleX: 2, scaleY: 0, x: 0, y: 0)
        
        //self.viewPortHandler.setMaximumScaleX((CGFloat(xData.count/5)))
        
        self.zoomToCenter(scaleX: 3, scaleY: 0)
    }
    
    private func setGradientEffect(dataSet: LineChartDataSet) {
        dataSet.drawFilledEnabled = true
        let gradientColors = [ChartColorTemplates.colorFromString("#00ff0000").cgColor, ChartColorTemplates.colorFromString("#ffff0000").cgColor] as CFArray
        let gradient = CGGradient(colorsSpace: nil, colors: gradientColors, locations: nil)
        dataSet.fillAlpha = 1
        dataSet.fill = Fill.fillWithLinearGradient(gradient!, angle: 90)

    }

    private func getHourAndMinStr(minFromNoon: Int) -> String {
        
        let hours : Int = minFromNoon/60
        let min : Int = minFromNoon - hours*60
        
        let hoursStr = String(hours)
        var minStr = String(min)
        
        if minStr.characters.count == 1 {
            minStr.append("0")
        }
        
        print(minFromNoon, " - ", hoursStr + ":" + minStr)
        
        return hoursStr + ":" + minStr
    }

}
