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
class SecondViewController: UIViewController {
    
    
    @IBOutlet weak var tavleView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
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
 
        

        // Refresh table
//        dispatch_async(dispatch_get_main_queue(), {
//            self.tavleView.reloadData()
//        })
        
        
    }
    
    func longPressedRow(gestureRecognizer:UIGestureRecognizer) {
        
        if (gestureRecognizer.state == UIGestureRecognizerState.Ended) {
            print("STATE ENDED")
            //Do Whatever You want on End of Gesture
        }
        else if (gestureRecognizer.state == UIGestureRecognizerState.Began){
            print("STATE BEGAN")
            //Do Whatever You want on Began of Gesture
        }
        
        print("Selecciona \(tavleView.indexPathForSelectedRow?.row) ")
        
//        let indexPath = tavleView.indexPathForSelectedRow
//        
//        let currentCell = tavleView.cellForRowAtIndexPath(indexPath!)! as UITableViewCell
//        
//        print("Texto \(currentCell.textLabel!.text) ")
        
    }
    
    

    
//    
//    func didSwipe(recognizer: UIGestureRecognizer) {
//        
//        print("CLick aaaaaaaa")
//        
////        if recognizer.state == UIGestureRecognizerState.Ended {
////            let swipeLocation = recognizer.locationInView(tavleView)
////            if let swipedIndexPath = tavleView.indexPathForRowAtPoint(swipeLocation) {
////                if let swipedCell = tavleView.cellForRowAtIndexPath(swipedIndexPath) {
////                    print("CLick aaaaaaaa")
////                    //esto no funciona
////                    //print("You selected cell #\(swipedCell.textLabel)!")
////
////                    
////                    
////                }
////            }
////        }
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
        cell.textLabel?.text = act.idSubject
        cell.imageView?.image = UIImage(named: "bullet_71x")
        let x : Int64 = act.dateCheckIn
        cell.detailTextLabel?.text = " \(dateFormatter.stringFromDate(theDateCI)) [\(mins) mins]"
        

        
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

    
    

    
    
    
    
    // Handle onClick event
//    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
//        print("CLick aaaaaaaa")
//        //esto no funciona
//        print("You selected cell #\(indexPath.row)!")
//
//        
//    }

    
    
    
    
//    
//    //
//    // Handle get request
//    //
//    func sendRequest(url: String) -> NSURLSessionTask {
//        
//        
//        let requestURL = NSURL(string: url)!
//        let request = NSMutableURLRequest(URL: requestURL)
//        request.HTTPMethod = "GET"
//        
//        let session = NSURLSession.sharedSession()
//        let task = session.dataTaskWithRequest(request, completionHandler: {(data, response, error) in
//            print(data)
//            print(response)
//            print(error)
//            
//            if error != nil {
//                print("error=\(error)")
//                return
//            }
//            
//            
//            do {
//                let jsonResult:AnyObject? = try NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.MutableLeaves) as? NSDictionary
//
//                if let result = jsonResult as? NSDictionary {
//                    if let theItems = result["items"] as? NSArray {
//                        for anItem : AnyObject in theItems {
//                            //print("vamos3 = \(anItem)")
//                            if let resultItem = anItem as? NSDictionary {
//                                if let theDesc = resultItem["subject_task_desc"] as? NSString {
//                                    if let theAltDesc = resultItem["subject_task_alternative_desc"] as? NSString {
//                                        if let theOrder = resultItem["subject_task_order"] as? Int {
//                                            //print("vamos4 = \(theDesc) \(theAltDesc) \(theOrder)")
//                                            
//                                            // Load data
//                                            self.assignments.append(Assignment(name:theDesc as String, desc: theAltDesc as String, order: theOrder as Int))
//
//                                        }
//                                    }
//                                }
//                            }
//                        } // for
//                        
//                        // Refresh table
//                        dispatch_async(dispatch_get_main_queue(), {
//                            self.tavleView.reloadData()
//                        })
//                    }
//                }
//            } catch let error as NSError {
//                print(error)
//            }
//        })
//        task.resume()
//        
//        
//        return task
//    }
    

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

