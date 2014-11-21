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

@IBDesignable class DashboardViewController: UIViewController, LineChartDataSource, JBBarChartViewDataSource, JBBarChartViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    @IBOutlet weak var calendar: UICollectionView!
    @IBOutlet weak var moodFooterView: UIView!
    @IBOutlet weak var chartView: JBBarChartView!
    @IBOutlet weak var lineChart: LineChart!
    var dataSet: [MoodItem] = []
    var barValues: [CGFloat] = []
    let stepsNumberFormatter = NSNumberFormatter()
    var blanks = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // take the origin date
        // take the current date
        
        self.stepsNumberFormatter.numberStyle = NSNumberFormatterStyle.DecimalStyle
        self.stepsNumberFormatter.maximumFractionDigits = 0
        
        self.chartView.dataSource = self
        self.chartView.delegate = self
        self.chartView.minimumValue = 0
        self.chartView.maximumValue = 60
        self.chartView.headerView = UIView(frame: CGRectMake(0, 0, 0, 5))
        self.chartView.footerView = UIView(frame: CGRectMake(0, 0, 0, 20))
        
        self.lineChart.dataSource = self
        
        self.calendar.registerNib(UINib(nibName: "CalendarDayLabelCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "dayCell")
        self.calendar.registerNib(UINib(nibName: "CalendarLogCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "logCell")
        
        self.dataSet.append(MoodItem(date: NSDate(timeIntervalSinceNow: -60*60*3), temperature: 30, steps: 1000, intersect: CGPointMake(0, 0), text: "Pretty dang good"))
        self.dataSet.append(MoodItem(date: NSDate(timeIntervalSinceNow: -60*60*2), temperature: 40, steps: 1200, intersect: CGPointMake(1, 2), text: "Meh"))
        self.dataSet.append(MoodItem(date: NSDate(timeIntervalSinceNow: -60*60*1), temperature: 50, steps: 3000, intersect: CGPointMake(2, 4), text: "Today is the worst!"))
        self.dataSet.append(MoodItem(date: NSDate()                              , temperature: 60, steps: 3030, intersect: CGPointMake(4, 0), text: "Pretty dang good"))
        self.dataSet.append(MoodItem(date: NSDate(timeIntervalSinceNow: 60*60*2),  temperature: 70, steps: 3500, intersect: CGPointMake(5, 1), text: "Feeling good"))
        self.dataSet.append(MoodItem(date: NSDate(timeIntervalSinceNow: 60*60*3),  temperature: 60, steps: 6000, intersect: CGPointMake(6, 3), text: "Bad day"))
        self.dataSet.append(MoodItem(date: NSDate(timeIntervalSinceNow: 60*60*4),  temperature: 50, steps: 7000, intersect: CGPointMake(7, 2), text: "Meh"))
        self.dataSet.append(MoodItem(date: NSDate(timeIntervalSinceNow: 60*60*5),  temperature: 40, steps: 9000, intersect: CGPointMake(8, 4), text: "Today is the worst!"))
        self.dataSet.append(MoodItem(date: NSDate(timeIntervalSinceNow: 60*60*6),  temperature: 30, steps: 10000, intersect: CGPointMake(9, 3), text: "Bad day"))
        
        self.barValues = [10.0, 20.0, 35.0, 4.0, 50.0]
        self.paddValues()
    }
    
    func paddValues () {
        let min: CGFloat = 20
        var largestDiff: CGFloat = 0
        
        for (index, value) in enumerate(self.barValues) {
            let diff = value - min
            
            if diff < 0 {
            
                if fabs(diff) > largestDiff {
                    largestDiff = fabs(diff)
                }
            }
        }
        
        var newValues: [CGFloat] = []
        
        for value in self.barValues {
            newValues.append(value+largestDiff)
        }
        
        self.barValues = newValues
        
    }
    
    class func showDashboardInNavigationController(navigationController: UINavigationController) {
        let storyBoard = UIStoryboard(name: "dashboard", bundle: nil)
        navigationController.setViewControllers([storyBoard.instantiateViewControllerWithIdentifier("dashboard")], animated: true)
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.chartView.reloadData()
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
    
    //MARK: - Mood Count Chart
    func numberOfBarsInBarChartView(barChartView: JBBarChartView!) -> UInt {
        return UInt(self.barValues.count)
    }
    
    func barChartView(barChartView: JBBarChartView!, heightForBarViewAtIndex index: UInt) -> CGFloat {
        return self.barValues[Int(index)]
    }
    
    func barChartView(barChartView: JBBarChartView!, barViewAtIndex index: UInt) -> UIView! {
        let mood = MoodBar()
        mood.setMoodBarIndex(Int(index))
        return mood
    }
    
    func barPaddingForBarChartView(barChartView: JBBarChartView!) -> CGFloat {
        return 8.0
    }
    
    //MARK: - Calendar CollecitonView
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAtIndex section: Int) -> UIEdgeInsets {
        if section == 0 {
            return UIEdgeInsetsMake(0, 0, 5, 0)
        } else {
            return UIEdgeInsetsZero
        }
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        if indexPath.section == 0 {
            let cell = collectionView.dequeueReusableCellWithReuseIdentifier("dayCell", forIndexPath: indexPath) as CalendarDayLabelCollectionViewCell
            cell.setDayLabelFromIndex(indexPath.item)
            
            return cell
        } else {
            let cell = collectionView.dequeueReusableCellWithReuseIdentifier("logCell", forIndexPath: indexPath) as CalendarLogCollectionViewCell
            println(self.blanks)
            if indexPath.item <= self.blanks {
                println(indexPath.item)
                cell.loggedImageView.hidden = true
            } else {
                cell.loggedImageView.hidden = false
                
                let option: Bool = Bool(Int(arc4random_uniform(2)))
                
                cell.setLogged(option)
            }
            return cell
        }
    }
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 2
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 7
        default:
            return self.totalDaysToShow()
        }
    }
    
    func totalDaysToShow() -> Int {
        let maxDays = 28
        
        println("Max Days: \(maxDays)")
        
        let cal = NSCalendar.currentCalendar()
        let dayOfWeek = cal.component(NSCalendarUnit.WeekdayCalendarUnit, fromDate: NSDate())

        println("Day Of Week: \(dayOfWeek)")
        
        let offsetOfGivenWeekday = self.offsetGivenWeekday(dayOfWeek)
        
        println("Offset Of Given Weekday: \(offsetOfGivenWeekday)")
        
        let maxDaysOffset = maxDays - offsetOfGivenWeekday
        
        println("Max Days Offset: \(maxDaysOffset)")
        
        let accountDaysOld = self.accountDaysOldInclusive()
        
        println("Account Days Old: \(accountDaysOld)")
        
        if accountDaysOld >= maxDaysOffset {
            println("Account Days old is greater than or equal to Max Days Offset")
            return maxDaysOffset
        } else {
            println("Account Days old is less than Max Days Offset")
            
            let daysToShow = accountDaysOld - 1 + self.accountStartDayIndex()

            println("Days to Show: \(daysToShow)")
            
            let returnDaysToShow = min(maxDaysOffset, daysToShow)
            
            println("Return Days To Show: \(returnDaysToShow)")
            
            return returnDaysToShow
        }
    }
    
    func accountDaysOldInclusive() -> Int {
        return 10
    }
    
    /**
    Day Index that Account was started on
    
    :returns: Day Index 0-6 that account was started on
    */
    func accountStartDayIndex() -> Int {
        return 4
    }
    
    func cellBlanks() -> Int {
        return 1
    }
    
    func offsetGivenWeekday(idx: Int) -> Int{
        switch idx {
        case 1:
            return 0
        case 2:
            return 6
        case 3:
            return 5
        case 4:
            return 4
        case 5:
            return 3
        case 6:
            return 2
        case 7:
            return 1
        default:
            return 0
        }
    }

    
}
