//
//  LineChart.swift
//  sense
//
//  Created by Matt McMurry on 10/21/14.
//  Copyright (c) 2014 O. C. Tanner. All rights reserved.
//

import UIKit

protocol LineChartDataSource {
    
    func numberOfYIntersectionsForLineChart(lineChart: LineChart) -> Int
    func lineChart(lineChart: LineChart, viewForYIntersect: Int) -> UIView
    func numberOfXIntersectionsForLineChart(lineChart: LineChart) -> Int
    func lineChart(lineChart: LineChart, viewForXIntersect: Int) -> UIView
    func intersectsForLinechart(lineChart: LineChart) -> [CGPoint]
}

let LineChartInnerEdgeInset = UIEdgeInsetsMake(10, 50, 50, 5)
let LineChartYViewOffset = UIOffsetMake(5, 0)
let LineChartDataStartXOffset: CGFloat = 10

@IBDesignable class LineChart: UIView, LineChartDataSource {

    var yViews = [UIView]()
    var xViews = [UIView]()
    var setNeedsReload = false
    var yIntersects: Int? = 0
    var xIntersects: Int? = 0
    var lineGraph = CAShapeLayer()
    var graphMaskView = AllMoodColorGradientView()
    
    @IBInspectable var dataSource: LineChartDataSource? {
        didSet {
            self.reloadData()
        }
    }

    override func drawRect(rect: CGRect) {
        
        if let yIntersects = self.yIntersects {
            
            let height = rect.size.height - LineChartInnerEdgeInset.top - LineChartInnerEdgeInset.bottom
            
            if yIntersects > 0 && height > CGFloat(yIntersects) {
            
                let intersectGap: CGFloat = height / (CGFloat(yIntersects) - 1.0)
                
                UIColor(hex: 0xCCCCCC).setStroke()
                
                for i in 0...yIntersects - 1 {
                    
                    let yOffset: CGFloat = LineChartInnerEdgeInset.top + (CGFloat(i) * intersectGap)
                    
                    let line = UIBezierPath()
                    line.moveToPoint(CGPointMake(LineChartInnerEdgeInset.left, yOffset))
                    line.addLineToPoint(CGPointMake(rect.size.width - LineChartInnerEdgeInset.right, yOffset))
                    line.lineWidth = 1.0
                    
                    line.stroke()
                }
            }
        }
    }
    
    func reloadData() {
        self.yIntersects = self.dataSource?.numberOfYIntersectionsForLineChart(self)
        self.xIntersects = self.dataSource?.numberOfXIntersectionsForLineChart(self)
        setNeedsReload = true
        self.setNeedsLayout()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        if setNeedsReload {
            setNeedsReload = false
            
            self.setNeedsDisplay()
            
            self.removeYViews()
            self.addYViews()
            self.removeXViews()
            self.addXViews()
            self.removeLineGraph()
            self.addLineGraph()

        }
        
        self.updateMask()
    }
    
    func updateMask() {
        var frame = self.graphMaskView.frame
        frame.origin.x = 0
        frame.size.width = self.frame.size.width
        frame.origin.y = 0
        frame.size.height = self.frame.size.height
        
        self.graphMaskView.frame = frame
        
        self.addSubview(self.graphMaskView)
        self.bringSubviewToFront(self.graphMaskView)
        
        self.graphMaskView.layer.mask = lineGraph
    }
    
    func removeLineGraph() {
        
    }
    
    func addLineGraph () {
        self.layer.addSublayer(self.lineGraph)
        self.lineGraph.frame = self.bounds
        self.lineGraph.fillColor = UIColor.clearColor().CGColor
        self.lineGraph.strokeColor = UIColor.redColor().CGColor
        self.lineGraph.lineCap = kCALineCapRound
        self.lineGraph.lineJoin = kCALineCapRound

        self.lineGraph.lineWidth = 15
        
        let pointOffset: CGFloat = 10
        let controlYPointOffset: CGFloat = 5
        let controlXPointOffset: CGFloat = 5
        let arcGapOffset: CGFloat = 20
        
        if let points = self.dataSource?.intersectsForLinechart(self) {
            let pointsFinal = points.sorted({ (first: CGPoint, second: CGPoint) -> Bool in
                return first.x < second.x
            })
            
            let bezierPath = UIBezierPath()
            
            if let yIntersects = self.yIntersects {
                if let xIntersects = self.xIntersects {
                
                    let height = self.lineGraph.bounds.size.height - LineChartInnerEdgeInset.top - LineChartInnerEdgeInset.bottom
                    
                    let width = self.lineGraph.bounds.size.width - LineChartInnerEdgeInset.left - LineChartInnerEdgeInset.right - LineChartDataStartXOffset * 2
                    
                
                    if (yIntersects > 0 && height > CGFloat(yIntersects)) &&
                       (xIntersects > 0 && width > CGFloat(xIntersects)) {
                    
                        let yIntersectGap: CGFloat = height / (CGFloat(yIntersects) - 1.0)
                        let xIntersectGap: CGFloat = width / (CGFloat(xIntersects) - 1.0)
                        
                        var nextPoint: CGPoint? = nil
                        var previousPoint: CGPoint = CGPointZero
                        
                        for (index, value) in enumerate(pointsFinal) {
                            var currentPoint = CGPointMake(value.x * xIntersectGap + LineChartInnerEdgeInset.left + LineChartDataStartXOffset,
                                                           value.y * yIntersectGap + LineChartInnerEdgeInset.top)
                            
                            if index == 0 {
                                bezierPath.moveToPoint(currentPoint)
                                previousPoint = currentPoint
                            } else {
                                if index < points.count - 1 {
                                    let aPoint = pointsFinal[index + 1]
                                    
                                    nextPoint = CGPointMake(aPoint.x * xIntersectGap + LineChartInnerEdgeInset.left + LineChartDataStartXOffset,
                                        aPoint.y * yIntersectGap + LineChartInnerEdgeInset.top)
                                }
                                
                                
                                let lastPoint = pointsFinal[index - 1]

                                if let nextPoint = nextPoint {
                                    let prevYDiff = fabsf(Float(previousPoint.y - currentPoint.y))
                                    let nextYDiff = fabsf(Float(nextPoint.y - currentPoint.y))
                                    if prevYDiff == nextYDiff {
                                        bezierPath.addLineToPoint(currentPoint)
                                    } else {
                                        
                                        var currentXControlOffset = controlXPointOffset
                                        if previousPoint.y < currentPoint.y {
                                            currentXControlOffset *= -1
                                        }
                                        
                                        let translateTransform = CGAffineTransformMakeTranslation(currentPoint.x, currentPoint.y)
                                        
                                        var leftAngle = atan2f(Float(currentPoint.x - previousPoint.x),
                                                               Float(currentPoint.y - previousPoint.y))
                                        
                                        let leftRotationTransform = CGAffineTransformMakeRotation(CGFloat(-leftAngle))
                                        
                                        let leftCustomRotation = CGAffineTransformConcat(CGAffineTransformConcat(CGAffineTransformInvert(translateTransform), leftRotationTransform), translateTransform)
                                        
                                        let initialPoint = CGPointMake(currentPoint.x, currentPoint.y - pointOffset)
                                        
                                        var leftPoint = CGPointApplyAffineTransform(initialPoint, leftCustomRotation)
                                        leftPoint.x -= arcGapOffset / 2
//                                        leftPoint.x -= 10
                                        bezierPath.addLineToPoint(leftPoint)
                                        
//                                        bezierPath.addLineToPoint(currentPoint)
                                        
                                        let rightAngle = atan2f(Float(currentPoint.x - nextPoint.x),
                                                                Float(currentPoint.y - nextPoint.y))

                                        let rightRotationTransform = CGAffineTransformMakeRotation(CGFloat(-rightAngle))
                                        
                                        let rightCustomRotation = CGAffineTransformConcat(CGAffineTransformConcat(CGAffineTransformInvert(translateTransform), rightRotationTransform), translateTransform)
                                        
                                        var rightPoint = CGPointApplyAffineTransform(initialPoint, rightCustomRotation)
                                        rightPoint.x += arcGapOffset / 2
//                                        bezierPath.addLineToPoint(rightPoint)
                                
                                        //c1
                                        let c1Angle = leftAngle - Float(M_PI)

                                        let c1rotationTransform = CGAffineTransformMakeRotation(CGFloat(c1Angle))

                                        let c1customRotation = CGAffineTransformConcat(CGAffineTransformConcat(CGAffineTransformInvert(translateTransform), c1rotationTransform), translateTransform)

                                        var cInitialPoint = CGPointMake(currentPoint.x - currentXControlOffset, currentPoint.y - controlYPointOffset)

                                        var c1Point = CGPointApplyAffineTransform(cInitialPoint, c1customRotation)
//
                                        //c2
                                        let c2Angle = rightAngle - Float(M_PI)

                                        let c2rotationTransform = CGAffineTransformMakeRotation(CGFloat(c2Angle))

                                        let c2customRotation = CGAffineTransformConcat(CGAffineTransformConcat(CGAffineTransformInvert(translateTransform), c2rotationTransform), translateTransform)
                                        
                                        cInitialPoint.x += currentXControlOffset * 2
                                        
                                        var c2Point = CGPointApplyAffineTransform(cInitialPoint, c2customRotation)
                                        
//                                        bezierPath.addLineToPoint(c1Point)
//                                        bezierPath.addLineToPoint(currentPoint)
//                                        bezierPath.addLineToPoint(c2Point)
//                                        bezierPath.addLineToPoint(rightPoint)
//                                            bezierPath.addLineToPoint(rightPoint)
                                        bezierPath.addCurveToPoint(rightPoint,
                                                                   controlPoint1: c1Point,
                                                                   controlPoint2: c2Point)

                                        
                                    }
                                } else {
                                        bezierPath.addLineToPoint(currentPoint)
                                }
                                
                                previousPoint = currentPoint
                                nextPoint = nil
                            }
                        }
                    }
                }
            }
            
            self.lineGraph.path = bezierPath.CGPath
        }
    }
    
    func removeYViews() {
        for view in self.yViews {
            view.removeFromSuperview()
        }
        
        self.yViews = [UIView]()
    }

    func removeXViews() {
        for view in self.xViews {
            view.removeFromSuperview()
        }
        
        self.xViews = [UIView]()
    }

    func addYViews() {
        
        if let yIntersects = self.yIntersects {
        
            let height = self.bounds.size.height - LineChartInnerEdgeInset.top - LineChartInnerEdgeInset.bottom
            
            if yIntersects > 0 && height > CGFloat(yIntersects) {
                
                let intersectGap: CGFloat = height / (CGFloat(yIntersects) - 1.0)
                
                for i in 0...yIntersects - 1 {
                    
                    let yOffset: CGFloat = LineChartInnerEdgeInset.top + (CGFloat(i) * intersectGap)
                    
                    if let yView = self.dataSource?.lineChart(self, viewForYIntersect: i) {
                        
                        self.yViews.append(yView)
                        
                        var frame = yView.frame
                        frame.origin.x = LineChartYViewOffset.horizontal
                        frame.origin.y = LineChartYViewOffset.vertical + yOffset - frame.size.height / 2
                        
                        yView.frame = frame
                        
                        self.addSubview(yView)
                    }
                }
            }
        }
    }
    
    func addXViews() {
        
        if let xIntersects = self.xIntersects {
            
            let width = self.bounds.size.width - LineChartInnerEdgeInset.left - LineChartInnerEdgeInset.right - LineChartDataStartXOffset * 2
            
            if xIntersects > 0 && width > CGFloat(xIntersects) {
                
                let intersectGap: CGFloat = width / (CGFloat(xIntersects) - 1.0)
                
                for i in 0...xIntersects - 1 {
                    
                    let xOffset: CGFloat = LineChartDataStartXOffset + LineChartInnerEdgeInset.left + (CGFloat(i) * intersectGap)
                    
                    if let xView = self.dataSource?.lineChart(self, viewForXIntersect: i) {
                        
                        self.xViews.append(xView)
                        
                        var frame = xView.frame
                        frame.origin.x = xOffset - frame.size.width / 2
                        frame.origin.y = self.bounds.size.height + LineChartInnerEdgeInset.top - LineChartInnerEdgeInset.bottom
                        
                        xView.frame = frame
                        
                        self.addSubview(xView)
                    }
                }
            }
        }
    }
    
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        
        self.dataSource = self
    }
    
    //for testing and ib
    func numberOfYIntersectionsForLineChart(lineChart: LineChart) -> Int {
        return 5
    }
    
    func lineChart(lineChart: LineChart, viewForYIntersect: Int) -> UIView {
        let view = UIView(frame: CGRectMake(0, 0, 30, 30))
        view.backgroundColor = UIColor.greenColor()
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
