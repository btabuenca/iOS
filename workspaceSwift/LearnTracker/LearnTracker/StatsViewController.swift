//
//  StatsViewController.swift
//  LearnTracker
//
//  Created by Bernardo Tabuenca on 08/12/15.
//  Copyright © 2015 Bernardo Tabuenca. All rights reserved.
//

import UIKit
import Charts


class StatsViewController: UIViewController {

    @IBOutlet weak var topBarUIView: UIView!
    @IBOutlet weak var logoImageView: UIImageView!
    @IBOutlet weak var emptyLeftImageView: UIImageView!
    @IBOutlet weak var emptyRightImageView: UIImageView!
    @IBOutlet weak var pieChartView: PieChartView!
    @IBOutlet weak var lineChartView: LineChartView!
    
    @IBOutlet weak var scrollerView: UIScrollView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Init images
        topBarUIView.backgroundColor = UIColorFromRGB(0x9CA31E)
        logoImageView.backgroundColor = UIColorFromRGB(0x9CA31E)
        emptyLeftImageView.backgroundColor = UIColorFromRGB(0x9CA31E)
        emptyRightImageView.backgroundColor = UIColorFromRGB(0x9CA31E)
        
        
        logoImageView.contentMode = UIViewContentMode.ScaleAspectFit
        emptyLeftImageView.contentMode = UIViewContentMode.ScaleAspectFit
        emptyRightImageView.contentMode = UIViewContentMode.ScaleAspectFit
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(animated: Bool) {
        // Here is the library to use
        // https://github.com/danielgindi/ios-charts
        // and here is howw to use it
        // http://www.appcoda.com/ios-charts-api-tutorial/
        
        var values: [Double] = []
        var keys: [String] = []
        let summary = HTTPReqManager.sharedInstance.getSummary()
        
        
        for (key, value) in summary {
            
            values.append(Double(value))
            keys.append(key)
            
        }
        
        setChart(keys, values: values)
        
        scrollerView.contentSize = CGSizeMake(400, 1200)
    }
    
    
    func setChart(dataPoints: [String], values: [Double]) {
        
        var dataEntries: [ChartDataEntry] = []
        
        for i in 0..<dataPoints.count {
            let dataEntry = ChartDataEntry(value: values[i], xIndex: i)
            dataEntries.append(dataEntry)
        }
        
        let pieChartDataSet = PieChartDataSet(yVals: dataEntries, label: "Activities")
        
        var colors: [UIColor] = []
        
        for i in 0..<dataPoints.count {
            let red = Double(arc4random_uniform(256))
            let green = Double(arc4random_uniform(256))
            let blue = Double(arc4random_uniform(256))
            
            let color = UIColor(red: CGFloat(red/255), green: CGFloat(green/255), blue: CGFloat(blue/255), alpha: 1)
            colors.append(color)
        }
        
        pieChartDataSet.colors = colors
        let pieChartData = PieChartData(xVals: dataPoints, dataSet: pieChartDataSet)
        pieChartView.data = pieChartData
        
        let lineChartDataSet = LineChartDataSet(yVals: dataEntries, label: "Activities")
        let lineChartData = LineChartData(xVals: dataPoints, dataSet: lineChartDataSet)
        lineChartView.data = lineChartData
        
    }
    
    func UIColorFromRGB(rgbValue: UInt) -> UIColor {
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
    
    
}
