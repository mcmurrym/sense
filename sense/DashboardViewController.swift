//
//  DashboardViewController.swift
//  sense
//
//  Created by Matt McMurry on 10/15/14.
//  Copyright (c) 2014 O. C. Tanner. All rights reserved.
//

import UIKit

@IBDesignable class DashboardViewController: UIViewController, LineChartDataSource {

    @IBOutlet weak var lineChart: LineChart!
    override func viewDidLoad() {
        super.viewDidLoad()

        self.lineChart.dataSource = self
    }
    
    class func showDashboardInNavigationController(navigationController: UINavigationController) {
        let storyBoard = UIStoryboard(name: "dashboard", bundle: nil)
        navigationController.setViewControllers([storyBoard.instantiateViewControllerWithIdentifier("dashboard")], animated: true)
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: - LineChartDataSource
    
    //for testing and ib
    func numberOfYIntersectionsForLineChart(lineChart: LineChart) -> Int {
        return 5
    }
    
    func lineChart(lineChart: LineChart, viewForYIntersect: Int) -> UIView {
        let view = UIImageView(image: UIImage(named: "face\(viewForYIntersect)"))
        return view
    }
    
    func numberOfXIntersectionsForLineChart(lineChart: LineChart) -> Int {
        return 10
    }
    
    func lineChart(lineChart: LineChart, viewForXIntersect: Int) -> UIView {
        let label = UILabel(frame: CGRectZero)
        label.text = "x\(viewForXIntersect)"
        label.sizeToFit()
        return label
    }
    
    func intersectsForLinechart(lineChart: LineChart) -> [CGPoint] {
        return [CGPointMake(0, 0), CGPointMake(1, 2), CGPointMake(2, 4), CGPointMake(4, 0), CGPointMake(5, 1), CGPointMake(6, 3), CGPointMake(7, 2), CGPointMake(8, 4), CGPointMake(9, 3)]
    }
}
