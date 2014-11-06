//
//  DashboardViewController.swift
//  sense
//
//  Created by Matt McMurry on 10/15/14.
//  Copyright (c) 2014 O. C. Tanner. All rights reserved.
//

import UIKit

struct MoodItem {
    let date: NSDate
    let temperature: Int
    let steps: Int
    let intersect: CGPoint
    let text: String
    
    init(date: NSDate, temperature: Int, steps: Int, intersect: CGPoint, text: String){
        self.date = date
        self.temperature = temperature
        self.steps = steps
        self.intersect = intersect
        self.text = text
    }
}

@IBDesignable class DashboardViewController: UIViewController, LineChartDataSource {

    @IBOutlet weak var lineChart: LineChart!
    var dataSet: [MoodItem] = []
    let stepsNumberFormatter = NSNumberFormatter()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.stepsNumberFormatter.numberStyle = NSNumberFormatterStyle.DecimalStyle
        self.stepsNumberFormatter.maximumFractionDigits = 0
        
        self.lineChart.dataSource = self
        
        self.dataSet.append(MoodItem(date: NSDate(timeIntervalSinceNow: -60*60*3), temperature: 30, steps: 1000, intersect: CGPointMake(0, 0), text: "Pretty dang good"))
        self.dataSet.append(MoodItem(date: NSDate(timeIntervalSinceNow: -60*60*2), temperature: 40, steps: 1200, intersect: CGPointMake(1, 2), text: "Meh"))
        self.dataSet.append(MoodItem(date: NSDate(timeIntervalSinceNow: -60*60*1), temperature: 50, steps: 3000, intersect: CGPointMake(2, 4), text: "Today is the worst!"))
        self.dataSet.append(MoodItem(date: NSDate()                              , temperature: 60, steps: 3030, intersect: CGPointMake(4, 0), text: "Pretty dang good"))
        self.dataSet.append(MoodItem(date: NSDate(timeIntervalSinceNow: 60*60*2),  temperature: 70, steps: 3500, intersect: CGPointMake(5, 1), text: "Feeling good"))
        self.dataSet.append(MoodItem(date: NSDate(timeIntervalSinceNow: 60*60*3),  temperature: 60, steps: 6000, intersect: CGPointMake(6, 3), text: "Bad day"))
        self.dataSet.append(MoodItem(date: NSDate(timeIntervalSinceNow: 60*60*4),  temperature: 50, steps: 7000, intersect: CGPointMake(7, 2), text: "Meh"))
        self.dataSet.append(MoodItem(date: NSDate(timeIntervalSinceNow: 60*60*5),  temperature: 40, steps: 9000, intersect: CGPointMake(8, 4), text: "Today is the worst!"))
        self.dataSet.append(MoodItem(date: NSDate(timeIntervalSinceNow: 60*60*6),  temperature: 30, steps: 10000, intersect: CGPointMake(9, 3), text: "Bad day"))
    }
    
    class func showDashboardInNavigationController(navigationController: UINavigationController) {
        let storyBoard = UIStoryboard(name: "dashboard", bundle: nil)
        navigationController.setViewControllers([storyBoard.instantiateViewControllerWithIdentifier("dashboard")], animated: true)
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    @IBAction func segmentChanged(sender: AnyObject) {
        self.lineChart.reloadData()
    }
    //MARK: - LineChartDataSource
    
    func gridForLineChart(lineChart: LineChart) -> (x: Int, y: Int) {
        return (10, 5)
    }
    
    func lineChart(lineChart: LineChart, viewForYIntersect: Int) -> UIView {
        let view = UIImageView(image: UIImage(named: "face\(viewForYIntersect)"))
        return view
    }
    
    func lineChart(lineChart: LineChart, viewForXIntersect: Int) -> UIView {
        let label = UILabel(frame: CGRectZero)
        label.text = "x\(viewForXIntersect)"
        label.sizeToFit()
        return label
    }
    
    func numberOfDataPointsForLineChart(lineChart: LineChart) -> Int {
        return 9
    }
    
    func lineChart(lineChart: LineChart, dataPointAtIndex: Int) -> CGPoint {
        return [CGPointMake(0, 0), CGPointMake(1, 2), CGPointMake(2, 4), CGPointMake(4, 0), CGPointMake(5, 1), CGPointMake(6, 3), CGPointMake(7, 2), CGPointMake(8, 4), CGPointMake(9, 3)][dataPointAtIndex]
    }
    
    func willShowAnnotation(annotation: LineTip, atIndex index: Int) {
        let mood = self.dataSet[index]
        annotation.date = mood.date
        annotation.temperatureLabel.text = "\(mood.temperature)°"
        annotation.stepLabel.text = self.stepsNumberFormatter.stringFromNumber(NSNumber(integer: mood.steps))
        annotation.feelLabel.text = mood.text
    }
}
