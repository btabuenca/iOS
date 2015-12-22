//
//  SecondViewController.swift
//  LearnTracker
//
//  Created by Bernardo Tabuenca on 08/12/15.
//  Copyright © 2015 Bernardo Tabuenca. All rights reserved.
//

import UIKit

//
// History controller
//
class SecondViewController: UIViewController, UITableViewDelegate {
    
    
    @IBOutlet weak var tavleView: UITableView!
    
    @IBOutlet weak var logoBar: UIView!
    
    @IBOutlet weak var logoImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        // Init images
        logoBar.backgroundColor = UIColorFromRGB(0x9CA31E)
        
        let imgBar = UIImage(named: "ltbar_trasp_x50")!
        logoImageView.image = imgBar
        logoImageView.contentMode = UIViewContentMode.ScaleAspectFit

        self.tavleView.delegate = self
        
//        
//        var recognizer = UISwipeGestureRecognizer(target: self, action: "didSwipe")
//        self.tavleView.addGestureRecognizer(recognizer)
        
        
        //self.tavleView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "cell")
        // Load data
        //sendRequest("https://lifelong-learning-hub.appspot.com/_ah/api/subjectendpoint/v1/subject/course/N35231")
        

        self.activities = HTTPReqManager.sharedInstance.activities
        print("Number of activities \(activities.count) ")
        
        let longPressRecognizer = UILongPressGestureRecognizer(target: self, action: "longPressedRow:")
        longPressRecognizer.minimumPressDuration = 0.5
        tavleView.addGestureRecognizer(longPressRecognizer)
        
    }
    

    
//    
//    func didSwipe(recognizer: UIGestureRecognizer) {
//        
//        print("Swiping ")
//        
//        if recognizer.state == UIGestureRecognizerState.Ended {
//            let swipeLocation = recognizer.locationInView(tavleView)
//            if let swipedIndexPath = tavleView.indexPathForRowAtPoint(swipeLocation) {
//                if let swipedCell = tavleView.cellForRowAtIndexPath(swipedIndexPath) {
//                    print("CLick aaaaaaaa")
//                    //esto no funciona
//                    //print("You selected cell #\(swipedCell.textLabel)!")
//
//                    
//                    
//                }
//            }
//        }
//    }
//    
    
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    //
    // Datasource mangement
    //
    //var assignments = [Assignment]()
    var activities = [Activity]()
    
    // Returns the number of chunks in the table
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    
    // Returns the number of rows
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return activities.count
    }
    
    // Content of the coverride ells
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd hh:mm:ss"
        
        let act = activities[indexPath.row]
        let duration : Double = Double(act.dateCheckOut - act.dateCheckIn)
        let seconds = duration / 1000
        let mins = seconds.minute
        
        let timeAsIntervalCI: NSTimeInterval = Double(act.dateCheckIn)/1000
        let theDateCI = NSDate(timeIntervalSince1970: timeAsIntervalCI)

        let timeAsIntervalCO: NSTimeInterval = Double(act.dateCheckOut)/1000
        let theDateCO = NSDate(timeIntervalSince1970: timeAsIntervalCO)
        


        //print("Duration seconds \(seconds) ")
        print("Duration mins \(mins) ")
        //print("Duration mins:secs:mills \(time) ")
        print("Date ci formmated \(dateFormatter.stringFromDate(theDateCI)) ")
        print("Date co formmated \(dateFormatter.stringFromDate(theDateCO)) ")
        
        
        let cell:UITableViewCell = UITableViewCell(style: UITableViewCellStyle.Subtitle, reuseIdentifier: "cell")
        
        
        cell.textLabel?.text = "[\(mins) mins] \(act.idSubject)"
        cell.imageView?.image = UIImage(named: "history")
        let x : Int64 = act.dateCheckIn
        cell.detailTextLabel?.text = " Started \(dateFormatter.stringFromDate(theDateCI)) "
        

        
        return cell
    }
    

    
    //
    // Delete item
    //
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        
        if editingStyle == UITableViewCellEditingStyle.Delete {
            deleteItem(indexPath.row)
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Automatic)
        }
    }
    
    func deleteItem(rowIndex: Int){
        
        activities.removeAtIndex(rowIndex)
        HTTPReqManager.sharedInstance.activities.removeAtIndex(rowIndex)
        HTTPReqManager.sharedInstance.deleteActivityDB()
        
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

extension NSTimeInterval {
    var minuteSecondMS: String {
        return String(format:"%d:%02d.%03d", minute , second, millisecond  )
    }
    var minute: Int {
        return Int((self/60.0)%60)
    }
    var second: Int {
        return Int(self % 60)
    }
    var millisecond: Int {
        return Int(self*1000 % 1000 )
    }
}

extension Int {
    var msToSeconds: Double {
        return Double(self) / 1000
    }
}

