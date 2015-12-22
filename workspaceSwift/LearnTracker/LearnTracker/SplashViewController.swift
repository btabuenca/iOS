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
    
    @IBOutlet weak var logoImageView: UIImageView!
    
    @IBOutlet weak var logoBar: UIView!
    
    @IBOutlet weak var coursesTableView: UITableView!
    
    @IBOutlet var coursesUIView: UIView!
    
    @IBOutlet weak var userLaber: UILabel!
    
    @IBOutlet weak var courseIdLabel: UILabel!
    
    @IBOutlet weak var courseNameLabel: UILabel!
    
    @IBOutlet weak var userButton: UIButton!
    
    
    var selectedCell:UITableViewCell = UITableViewCell(style: UITableViewCellStyle.Subtitle, reuseIdentifier: "cell")
    
    var displayedList:Bool = false
    
    var indexCellSelected:Int = -1
    
    var tField: UITextField!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        if let s = loadSession(){
            userLaber.text =  s.name
            courseIdLabel.text = s.courseId
            courseNameLabel.text = s.courseName
            
            HTTPReqManager.sharedInstance.persistance = s
            persistSession()
        }else{
            if let sI = loadInitialSession() {
                userLaber.text =  sI.name
                courseIdLabel.text = sI.courseId
                courseNameLabel.text = sI.courseName
                
                HTTPReqManager.sharedInstance.persistance = sI
                persistSession()
            }
        }
        

        // Init images
        logoBar.backgroundColor = UIColorFromRGB(0x9CA31E)
        
        let image = UIImage(named: "menu")!
        splashImageView.image = image

        let imgBar = UIImage(named: "ltbar_trasp_x50")!
        logoImageView.image = imgBar
        logoImageView.contentMode = UIViewContentMode.ScaleAspectFit
        
        
        // Init tap recognizers
        splashImageView.userInteractionEnabled = true
        let tapRecognizer = UITapGestureRecognizer(target: self, action: "imageTapped:")
        splashImageView.addGestureRecognizer(tapRecognizer)
                
        
        let longPressRecognizer = UILongPressGestureRecognizer(target: self, action: "longPressedRow:")
        longPressRecognizer.minimumPressDuration = 0.5
        coursesTableView.addGestureRecognizer(longPressRecognizer)
        
        
        
//        displayImageView.userInteractionEnabled = true
//        let tapRecogList = UITapGestureRecognizer(target: self, action: Selector("imageListTapped"))
//        displayImageView.addGestureRecognizer(tapRecogList)
        
        
        self.coursesTableView.delegate = self
        
        
        // Load data
        HTTPReqManager.sharedInstance.loadCourses()
        loadNewCourse()


        
        
        
        
        
//        HTTPReqManager.sharedInstance.loadAssignments("https://lifelong-learning-hub.appspot.com/_ah/api/subjectendpoint/v1/subject/course/N35231")
//        
//        HTTPReqManager.sharedInstance.loadActivities("https://lifelong-learning-hub.appspot.com/_ah/api/activityendpoint/v1/activity/course/S23222/user/Karin")

        // Consider to load this data in th appdelegate on load app
        //HTTPReqManager.sharedInstance.loadFakeData()
        
        
        // Load data
        //self.courses = HTTPReqManager.sharedInstance.courses
        //print("Number of courses \(courses.count) ")
        
        
        
        
    }
    
    
    
    @IBAction func onClickUserButton(sender: AnyObject) {

        
        var alert = UIAlertController(title: "Update user", message: HTTPReqManager.sharedInstance.persistance.name, preferredStyle: UIAlertControllerStyle.Alert)
        
        alert.addTextFieldWithConfigurationHandler(configurationTextField)
        alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertActionStyle.Cancel, handler:handleCancel))
        alert.addAction(UIAlertAction(title: "Done", style: UIAlertActionStyle.Default, handler:{ (UIAlertAction)in
                    print("Done !!")
                    print("Item : \(self.tField.text)")
            
                    self.userLaber.text =  self.tField.text
            
                    HTTPReqManager.sharedInstance.persistance.name = self.tField.text!
                    self.persistSession()
        
                }))
                self.presentViewController(alert, animated: true, completion: {
                    print("completion block")
                })
        
        
    }

    
    
    func configurationTextField(textField: UITextField!)
    {
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
            
            // Load view
            coursesTableView.reloadData()
            
            // Display courses list
            view.addSubview(coursesUIView)
            
            let height = coursesUIView.frame.size.height
            let width = coursesUIView.frame.size.width
            
            coursesUIView.frame = CGRectMake(0, 102, width, height)
            
            let bottomConstraint = coursesUIView.bottomAnchor.constraintEqualToAnchor(coursesTableView.bottomAnchor)
            let topConstraint = coursesUIView.topAnchor.constraintEqualToAnchor(coursesTableView.topAnchor)
            let leftConstraint = coursesUIView.leftAnchor.constraintEqualToAnchor(coursesTableView.leftAnchor)
            let rightConstraint = coursesUIView.rightAnchor.constraintEqualToAnchor(coursesTableView.rightAnchor)
            
            NSLayoutConstraint.activateConstraints([bottomConstraint, topConstraint, leftConstraint, rightConstraint])
            
            view.layoutIfNeeded()
            
        }
        
        displayedList = !displayedList
        
        
        
        
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
                    courseIdLabel.text = textCell
                    courseIdLabel.numberOfLines = 0
                    courseIdLabel.lineBreakMode = NSLineBreakMode.ByWordWrapping
                    courseIdLabel.sizeToFit()
                    HTTPReqManager.sharedInstance.persistance.courseId = textCell
                }
                if let detailTextCell = selectedCell.detailTextLabel?.text {
                    courseNameLabel.text = detailTextCell
                    courseNameLabel.numberOfLines = 0
                    courseNameLabel.lineBreakMode = NSLineBreakMode.ByWordWrapping
                    courseNameLabel.sizeToFit()
                    HTTPReqManager.sharedInstance.persistance.courseName = detailTextCell
                }
                persistSession()
                
                // Reload data for selected courses from DB
                loadNewCourse()
                
                
                
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
            
            
                // HACER LA TRAINSICION DE LA LISTA DE ARRIBA A ABAJO Y VICEVERSA
            
            
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
        return HTTPReqManager.sharedInstance.courses.count
    }
    
    // Content of the cells
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell:UITableViewCell = UITableViewCell(style: UITableViewCellStyle.Subtitle, reuseIdentifier: "cell")
        
        let c = HTTPReqManager.sharedInstance.courses[indexPath.row]
        
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
    


    // Load archived data into Persistance object
    func loadSession() -> Persistence? {
        return NSKeyedUnarchiver.unarchiveObjectWithFile(Persistence.ArchiveURL.path!) as? Persistence
    }
    
    // Load initial data into Persistenceobject
    func loadInitialSession() -> Persistence? {
        let date = NSDate()
        let calendar = NSCalendar.currentCalendar()
        
        let components = calendar.components([.Year, .Month, .Day, .Hour, .Minute, .Second], fromDate: date)
        
        print("Init user to \(components.year)\(components.month)\(components.day)\(components.hour)\(components.minute)\(components.second)")
        
        return Persistence(name: "\(components.year)\(components.month)\(components.day)\(components.hour)\(components.minute)\(components.second)", courseId: "LT2R1", courseName: "Sample course")
        
    }
    
    
    func persistSession() {
        
        print("Persist session Name =\(HTTPReqManager.sharedInstance.persistance.name) , CourseId =\(HTTPReqManager.sharedInstance.persistance.courseId), CourseName =\(HTTPReqManager.sharedInstance.persistance.courseName)")
        
        let isSuccessfulSave = NSKeyedArchiver.archiveRootObject(HTTPReqManager.sharedInstance.persistance, toFile: Persistence.ArchiveURL.path!)
        if !isSuccessfulSave {
            print("Failed to persist session ...")
        }
        
        
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
    
    

    func loadNewCourse(){
        HTTPReqManager.sharedInstance.loadAssignments("https://lifelong-learning-hub.appspot.com/_ah/api/subjectendpoint/v1/subject/course/" + HTTPReqManager.sharedInstance.persistance.courseId)
        
         ESTA ES LA BUENA PORUQ ETSA FILTRADA POR USUARIO PERO PETA EN EL BACKEND
//      at org.ounl.lifelonglearninghub.db.ActivityEndpoint.listActivityCourseUser(ActivityEndpoint.java:123)
        
//        PETA CON ESTA QUERY
//        
//        https://lifelong-learning-hub.appspot.com/_ah/api/activityendpoint/v1/activity/course/LT2R1/user/btb
//        
//        
//        E 2015-12-22 17:57:53.730  500     117 B  1.86 s E 17:57:55.582 /_ah/spi/org.ounl.lifelonglearninghub.db.ActivityEndpoint.listActivityCourseUser
//        2a02:908:f322:ba00:999f:68ce:702e:8d55 - - [22/Dec/2015:08:57:53 -0800] "POST /_ah/spi/org.ounl.lifelonglearninghub.db.ActivityEndpoint.listActivityCourseUser HTTP/1.1" 500 117 - "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_11_2) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/47.0.2526.106 Safari/537.36" "lifelong-learning-hub.appspot.com" ms=1857 cpu_ms=1200 cpm_usd=1.3075e-05 instance=00c61b117cb85219b9bced8d9a9f34421fcb8418 app_engine_release=1.9.30 trace_id=87245da644bb6641a833c131a370c987
//        E 17:57:55.582 com.google.api.server.spi.SystemService invokeServiceMethod: null
//        java.lang.NullPointerException
//        at java.lang.String$CaseInsensitiveComparator.compare(String.java:1177)
//        at java.lang.String$CaseInsensitiveComparator.compare(String.java:1170)
//        at java.lang.String.compareToIgnoreCase(String.java:1220)
//------->>>>        at org.ounl.lifelonglearninghub.db.ActivityEndpoint.listActivityCourseUser(ActivityEndpoint.java:123)
//        at sun.reflect.NativeMethodAccessorImpl.invoke0(Native Method)
//        at sun.reflect.NativeMethodAccessorImpl.invoke(NativeMethodAccessorImpl.java:57)
//        at sun.reflect.DelegatingMethodAccessorImpl.invoke(DelegatingMethodAccessorImpl.java:43)
//        at java.lang.reflect.Method.invoke(Method.java:44)
//        at com.google.api.server.spi.SystemService.invokeServiceMethod(SystemService.java:359)
//        at com.google.api.server.spi.SystemServiceServlet.execute(SystemServiceServlet.java:160)
//        at com.google.api.server.spi.SystemServiceServlet.doPost(SystemServiceServlet.java:118)
//        at javax.servlet.http.HttpServlet.service(HttpServlet.java:637)
//        at javax.servlet.http.HttpServlet.service(HttpServlet.java:717)
//        at org.mortbay.jetty.servlet.ServletHolder.handle(ServletHolder.java:511)
//        at org.mortbay.jetty.servlet.ServletHandler$CachedChain.doFilter(ServletHandler.java:1166)
//        at org.mortbay.jetty.servlet.ServletHandler$CachedChain.doFilter(ServletHandler.java:1157)
//        at org.mortbay.jetty.servlet.ServletHandler$CachedChain.doFilter(ServletHandler.java:1157)
//        at org.mortbay.jetty.servlet.ServletHandler$CachedChain.doFilter(ServletHandler.java:1157)
//        at org.mortbay.jetty.servlet.ServletHandler$CachedChain.doFilter(ServletHandler.java:1157)
//        at org.mortbay.jetty.servlet.ServletHandler.handle(ServletHandler.java:388)
//        at org.mortbay.jetty.security.SecurityHandler.handle(SecurityHandler.java:216)
//        at org.mortbay.jetty.servlet.SessionHandler.handle(SessionHandler.java:182)
//        at org.mortbay.jetty.handler.ContextHandler.handle(ContextHandler.java:765)
//        at org.mortbay.jetty.webapp.WebAppContext.handle(WebAppContext.java:418)
//        at org.mortbay.jetty.handler.HandlerWrapper.handle(HandlerWrapper.java:152)
//        at org.mortbay.jetty.Server.handle(Server.java:326)
//        at org.mortbay.jetty.HttpConnection.handleRequest(HttpConnection.java:542)
//        at org.mortbay.jetty.HttpConnection$RequestHandler.headerComplete(HttpConnection.java:923)
//        at org.mortbay.jetty.HttpConnection.handle(HttpConnection.java:404)
//        at com.google.tracing.TraceContext$TraceContextRunnable.runInContext(TraceContext.java:437)
//        at com.google.tracing.TraceContext$TraceContextRunnable$1.run(TraceContext.java:444)
//        at com.google.tracing.CurrentContext.runInContext(CurrentContext.java:256)
//        at com.google.tracing.TraceContext$AbstractTraceContextCallback.runInInheritedContextNoUnref(TraceContext.java:308)
//        at com.google.tracing.TraceContext$AbstractTraceContextCallback.runInInheritedContext(TraceContext.java:300)
//        at com.google.tracing.TraceContext$TraceContextRunnable.run(TraceContext.java:441)
//        at java.lang.Thread.run(Thread.java:745)
        
        
        
        
        
        
        
//        HTTPReqManager.sharedInstance.loadActivities("https://lifelong-learning-hub.appspot.com/_ah/api/activityendpoint/v1/activity/course/" + HTTPReqManager.sharedInstance.persistance.courseId + "/user/" + HTTPReqManager.sharedInstance.persistance.name)
        
        
        HTTPReqManager.sharedInstance.loadActivities("https://lifelong-learning-hub.appspot.com/_ah/api/activityendpoint/v1/activity/course/" + HTTPReqManager.sharedInstance.persistance.courseId + "/")
        
        
    }


}
