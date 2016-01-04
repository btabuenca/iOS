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
    @IBOutlet weak var topBarUIView: UIView!
    @IBOutlet weak var logoImageView: UIImageView!
    @IBOutlet weak var emptyLeftImageView: UIImageView!
    @IBOutlet weak var emptyRightImageView: UIImageView!
    
    
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
        

        //self.tavleView = HTTPReqManager.sharedInstance.activities
        
        self.tavleView.delegate = self

        
    }
    
    override func viewWillAppear(animated: Bool) {
        tavleView.reloadData()
    }
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    // Returns the number of chunks in the table
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    
    // Returns the number of rows
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return HTTPReqManager.sharedInstance.activities.count
    }
    
    // Content of the coverride ells
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd hh:mm:ss"
        
        let act = HTTPReqManager.sharedInstance.activities[indexPath.row]
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
        
        let a = HTTPReqManager.sharedInstance.activities[rowIndex]
        HTTPReqManager.sharedInstance.deleteActivity(String(a.dateCheckIn), user: a.idUser)
        HTTPReqManager.sharedInstance.activities.removeAtIndex(rowIndex)
        

        //ESTO ESTA POR PROBAR
        
        
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

