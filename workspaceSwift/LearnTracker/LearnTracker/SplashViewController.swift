//
//  SplashViewController.swift
//  LearnTracker
//
//  Created by Bernardo Tabuenca on 08/12/15.
//  Copyright © 2015 Bernardo Tabuenca. All rights reserved.
//

import UIKit

class SplashViewController: UIViewController, UITableViewDelegate {

    
    @IBOutlet weak var splashImageView: UIImageView!
    
    @IBOutlet weak var coursesTableView: UITableView!
    
    @IBOutlet var coursesUIView: UIView!
    
    @IBOutlet weak var userLaber: UILabel!
    
    @IBOutlet weak var courseIdLabel: UILabel!
    
    @IBOutlet weak var courseNameLabel: UILabel!
    
    
    var selectedCell:UITableViewCell = UITableViewCell(style: UITableViewCellStyle.Subtitle, reuseIdentifier: "cell")
    
    var displayedList:Bool = false
    
    var indexCellSelected:Int = -1
    
    var tField: UITextField!
    
    var courses = [Course]()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        // Load any saved meals, otherwise load sample data.
        if let s = loadSession(){
            HTTPReqManager.sharedInstance.loadSession(s)            
        }
        

        // Init images
        let image = UIImage(named: "course_50x")!
        splashImageView.image = image

//        let cImg = UIImage(named: "course_50x")!
//        displayImageView.image = cImg

        
        
        // Init tap recognizers
        splashImageView.userInteractionEnabled = true
        //let tapRecognizer = UITapGestureRecognizer(target: self, action: Selector("imageTapped:"))
        let tapRecognizer = UITapGestureRecognizer(target: self, action: "imageTapped:")
        splashImageView.addGestureRecognizer(tapRecognizer)
        
        
        let longPressRecognizer = UILongPressGestureRecognizer(target: self, action: "longPressedRow:")
        longPressRecognizer.minimumPressDuration = 0.5
        coursesTableView.addGestureRecognizer(longPressRecognizer)
        
        
        
//        displayImageView.userInteractionEnabled = true
//        let tapRecogList = UITapGestureRecognizer(target: self, action: Selector("imageListTapped"))
//        displayImageView.addGestureRecognizer(tapRecogList)
        
        
        self.coursesTableView.delegate = self
        
        

        userLaber.text =  HTTPReqManager.sharedInstance.session.name
        
        
        // Load data
//        HTTPReqManager.sharedInstance.loadCourses()
//        
//        HTTPReqManager.sharedInstance.loadAssignments("https://lifelong-learning-hub.appspot.com/_ah/api/subjectendpoint/v1/subject/course/N35231")
//        
//        HTTPReqManager.sharedInstance.loadActivities("https://lifelong-learning-hub.appspot.com/_ah/api/activityendpoint/v1/activity/course/S23222/user/Karin")

        // Consider to load this data in th appdelegate on load app
        HTTPReqManager.sharedInstance.loadFakeData()
        
        
        // Load data
        self.courses = HTTPReqManager.sharedInstance.courses
        print("Number of courses \(courses.count) ")
        
        
        
        
    }
    
    
    
    func configurationTextField(textField: UITextField!)
    {
        print("generating the TextField")
        textField.placeholder = "Enter new user name ..."
        tField = textField
    }
    
    
    func handleCancel(alertView: UIAlertAction!)
    {
        print("Cancelled !!")
    }
    
    
    func imageTapped(gestureRecognizer: UITapGestureRecognizer) {

        if displayedList {
            
            // Hide courses list
            coursesUIView.removeFromSuperview()
        }else{
            
            // Display courses list
            view.addSubview(coursesUIView)
            
            let height = coursesUIView.frame.size.height
            let width = coursesUIView.frame.size.width
            
            coursesUIView.frame = CGRectMake(0, splashImageView.frame.height + 20, width, height)
            
            let bottomConstraint = coursesUIView.bottomAnchor.constraintEqualToAnchor(coursesTableView.bottomAnchor)
            let topConstraint = coursesUIView.topAnchor.constraintEqualToAnchor(coursesTableView.topAnchor)
            let leftConstraint = coursesUIView.leftAnchor.constraintEqualToAnchor(coursesTableView.leftAnchor)
            let rightConstraint = coursesUIView.rightAnchor.constraintEqualToAnchor(coursesTableView.rightAnchor)
            
            NSLayoutConstraint.activateConstraints([bottomConstraint, topConstraint, leftConstraint, rightConstraint])
            
            view.layoutIfNeeded()
            
        }
        
        displayedList = !displayedList
        
        

        

//
// Nice functionality to prompt user data and store it
//
//        var alert = UIAlertController(title: "Update user", message: HTTPReqManager.sharedInstance.session.name, preferredStyle: UIAlertControllerStyle.Alert)
//        
//        alert.addTextFieldWithConfigurationHandler(configurationTextField)
//        alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertActionStyle.Cancel, handler:handleCancel))
//        alert.addAction(UIAlertAction(title: "Done", style: UIAlertActionStyle.Default, handler:{ (UIAlertAction)in
//            print("Done !!")
//            print("Item : \(self.tField.text)")
//            self.updateUser(self.tField.text!)
//            
//        }))
//        self.presentViewController(alert, animated: true, completion: {
//            print("completion block")
//        })
//        
        
    
        
        
    }
    


    func longPressedRow(gestureRecognizer:UILongPressGestureRecognizer) {
        
        
        if (gestureRecognizer.state == UIGestureRecognizerState.Began) {
            print("STATE Begin")
            
            displayedList = !displayedList
            
            let p = gestureRecognizer.locationInView(coursesTableView)
            
            let indexPath = coursesTableView.indexPathForRowAtPoint(p)
            
            if let index = indexPath {
                var cell = coursesTableView.cellForRowAtIndexPath(index)
                
                indexCellSelected = (indexPath?.row)!
                selectedCell = coursesTableView.cellForRowAtIndexPath(indexPath!)! as UITableViewCell
                
                
                if let textCell = selectedCell.textLabel?.text {
                    courseIdLabel.text = "Course ID \(textCell)"
                }
                if let detailTextCell = selectedCell.detailTextLabel?.text {
                    courseNameLabel.text = "Course Name \(detailTextCell)"
                }
                
                NSLog("Loading new course ... #\(indexPath!.row)!")
                print("Index \(indexCellSelected) ")
                print("Text \(selectedCell.textLabel!.text) ")
                print("Detail \(selectedCell.detailTextLabel?.text) ")
                print("Displayed? \(displayedList) ")
                
                
            } else {
                print("Could not find index path")
            }
            

        }
        else if (gestureRecognizer.state == UIGestureRecognizerState.Ended){
            print("STATE End")
            coursesUIView.removeFromSuperview()
            
        }
        
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
        return courses.count
    }
    
    // Content of the cells
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell:UITableViewCell = UITableViewCell(style: UITableViewCellStyle.Subtitle, reuseIdentifier: "cell")
        
        let c = courses[indexPath.row]
        
//        if c.active {
//            cell.backgroundColor = UIColorFromRGB(0xBABA36)
//        }

        cell.textLabel?.text = c.id
        cell.imageView?.image = UIImage(named: "course_50x")
        cell.detailTextLabel?.text = c.desc
        
        
        return cell
    }
    
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath){
        

        let index = coursesTableView.indexPathForSelectedRow
        indexCellSelected = (index?.row)!
        selectedCell = coursesTableView.cellForRowAtIndexPath(index!)! as UITableViewCell
        displayedList = !displayedList

        
        
        NSLog("You selected cell number #\(indexPath.row)!")
        print("Index \(indexCellSelected) ")
        print("Text \(selectedCell.textLabel!.text) ")
        print("Detail \(selectedCell.detailTextLabel?.text) ")
        print("Displayed? \(displayedList) ")
        
        
//        
//        if (!cellSelected) {
//            print("... check out!")
//            //            selectedCell.imageView?.alpha = 1
//            //            selectedCell.imageView?.layer.removeAllAnimations()
//        } else {
//            print("Check in ...")
//            //            selectedCell.imageView?.alpha = 1
//            //            UIView.animateWithDuration(0.6, delay: 0.3, options:[.Repeat, .Autoreverse], animations: { _ in
//            //                self.selectedCell.alpha = 0 }, completion: nil)
//        }
        
    }
    
    
//    func tableView(tableView: UITableView, editActionsForRowAtIndexPath indexPath: NSIndexPath) -> [AnyObject]? {
//        
//        
//        https://www.youtube.com/watch?v=T0xzTbXhOvE
//        
//        
//        let more = UITableViewRowAction(style: .Normal, title: "More") { action, index in
//            print("more button tapped")
//        }
//        more.backgroundColor = UIColor.lightGrayColor()
//        
//        let favorite = UITableViewRowAction(style: .Normal, title: "Favorite") { action, index in
//            print("favorite button tapped")
//        }
//        favorite.backgroundColor = UIColor.orangeColor()
//        
//        let share = UITableViewRowAction(style: .Normal, title: "Share") { action, index in
//            print("share button tapped")
//        }
//        share.backgroundColor = UIColor.blueColor()
//        
//        return [share, favorite, more]
//    }
//    
    
    
    

    
    
    func UIColorFromRGB(rgbValue: UInt) -> UIColor {
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
    


    func loadSession() -> Session? {
        return NSKeyedUnarchiver.unarchiveObjectWithFile(Session.ArchiveURL.path!) as? Session
    }
    
    //
    // Load data for a course
    //
//    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
//        
//        if editingStyle == UITableViewCellEditingStyle.Delete {
//            print("Delete ...")
//            //deleteItem(indexPath.row)
//            //tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Automatic)
//            
//            //https://www.youtube.com/watch?v=T0xzTbXhOvE
//
//
//        }
//        
//        
//    }
//
    
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        // you need to implement this method too or you can't swipe to display the actions
    }

    
    func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // the cells you would like the actions to appear needs to be editable
        return true
    }
    
    func loadCourse(rowIndex: Int){
        
//        activities.removeAtIndex(rowIndex)
//        HTTPReqManager.sharedInstance.activities.removeAtIndex(rowIndex)
//        HTTPReqManager.sharedInstance.deleteActivityDB()
        
    }


}
