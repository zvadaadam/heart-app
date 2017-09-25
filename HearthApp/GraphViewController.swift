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
    
    var calendarModel: CalendarModel = CalendarModel()
    
    var profileUsers: [FriendsSelectedView] = []
    
    let viewModel: GraphViewModel = GraphViewModel()
    
    var counter = 0
    let sampleFrequency = 5;
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        calendar.register(UINib(nibName: "CalendarCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "CalendarCell")
        
        calendar.register(UINib(nibName: "CalendarTodayCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "CalendarCellToday")
        
        graphView.delegate = self
        viewModel.delegate = self
        
        //TODO, TMP MOCK!
        let data = createMockData()
        graphView.createLine(xData: data.x, yData: data.y, color: .red)
        
        let data1 = createMockData()
        graphView.createLine(xData: data1.x, yData: data1.y, color: .blue)
        
        let data2 = createMockData()
        graphView.createLine(xData: data2.x, yData: data2.y, color: .yellow)
        
        let data3 = createMockData()
        graphView.createLine(xData: data3.x, yData: data3.y, color: .white)
        
        
        let user : [(String, UIColor)] = [("Mock1", .red), ("Mock2", .blue), ("Mock3", .white), ("Mock4", .yellow)]
        
        setUserProfiles(users: user);
    }
    
    func getGraphOfDate(date: Date) {
        graphView.clear()

        
        viewModel.retriveHeartRates(date: date)
        
        
//        let data = createMockData()
//        graphView.createLine(xData: data.x, yData: data.y, color: .red)
//
//        let data1 = createMockData()
//        graphView.createLine(xData: data1.x, yData: data1.y, color: .blue)
//
//        let data2 = createMockData()
//        graphView.createLine(xData: data2.x, yData: data2.y, color: .yellow)
//
//        let data3 = createMockData()
//        graphView.createLine(xData: data3.x, yData: data3.y, color: .white)

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
    
    func setUserProfiles(users: [(name: String, color: UIColor)]) {
        
        let numberOfProfiles = users.count
        let profileViewSize : CGFloat = FriendsSelectedView.size
        
        let offset : CGFloat = profileViewSize/2
        let separatorSize : CGFloat = view.bounds.width/CGFloat(numberOfProfiles + 1)
        
        let profileHeight : CGFloat = view.bounds.height - profileViewSize
        
        for i in 0 ..< numberOfProfiles {
            let x = CGFloat(i+1)*separatorSize-offset
            let friend = FriendsSelectedView(frame: CGRect(x: x, y: profileHeight, width: profileViewSize, height: profileViewSize))
            friend.setColor(color: users[i].color)
            friend.setName(name: users[i].name)
            self.view.addSubview(friend)
            profileUsers.append(friend)
        }
    }
    
    
    @IBAction func friendsTapped(_ sender: Any) {
        PresentStoryboard.sharedInstance.showAddFriends(vc: self)
    }
    
    
    @IBAction func profileTapped(_ sender: Any) {
        PresentStoryboard.sharedInstance.showProfile(vc: self)
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

extension GraphViewController: GraphViewModelDelegate {
    
    func retrivedHeartRates(date: Date, heartRates: [HeartRate]) {
        graphView.clear()
        
        var x : [Int] = []
        var y : [Int] = []
        
        let timestampStartOfDayLocal = TimeZoneHelper.localDate(date: date.startOfDay).timeIntervalSince1970
        print(timestampStartOfDayLocal)
        
        for heartRate in heartRates {
            x.append(Int(heartRate.rate))
            print(heartRate.timestamp)
            let minutesFromNoon = Int(timestampStartOfDayLocal - TimeZoneHelper.localDate(timestamp: heartRate.timestamp))/60
            y.append(minutesFromNoon)
        }
        
        graphView.createLine(xData: y, yData: x, color: .red)
    }
}






