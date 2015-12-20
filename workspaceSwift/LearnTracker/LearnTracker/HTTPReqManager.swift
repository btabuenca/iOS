//
//  HTTPReqManager.swift
//  LearnTracker
//
//  Created by Bernardo Tabuenca on 09/12/15.
//  Copyright © 2015 Bernardo Tabuenca. All rights reserved.
//

import UIKit


//
// Singleton class
//
class HTTPReqManager{
    

    class var sharedInstance : HTTPReqManager {
        struct Static {
            static let instance : HTTPReqManager = HTTPReqManager()
        }
        return Static.instance
    }

    var session : Session!
    var assignments = [Assignment]()
    var courses = [Course]()
    var activities = [Activity]()
    
    
    
    

    private init() {
        print(__FUNCTION__)
        

        let date = NSDate()
        let calendar = NSCalendar.currentCalendar()
        
        let components = calendar.components([.Year, .Month, .Day, .Hour, .Minute, .Second], fromDate: date)
        
        print("Init user to \(components.year)\(components.month)\(components.day)\(components.hour)\(components.minute)\(components.second)")
        
        session = Session(name: "\(components.year)\(components.month)\(components.day)\(components.hour)\(components.minute)\(components.second)", course: "LT2R1")
        
        let isSuccessfulSave = NSKeyedArchiver.archiveRootObject(session, toFile: Session.ArchiveURL.path!)
        if !isSuccessfulSave {
            print("Failed to save user...")
        }
        
        
    }
    
    
//    func printUser() {
//        print("\(__FUNCTION__) \(session.name)")
//    }

    
    //
    // Load subjects for the selected course
    //
    func loadAssignments(url: String) -> NSURLSessionTask {
        
        
        let requestURL = NSURL(string: url)!
        let request = NSMutableURLRequest(URL: requestURL)
        request.HTTPMethod = "GET"
        
        let session = NSURLSession.sharedSession()
        let task = session.dataTaskWithRequest(request, completionHandler: {(data, response, error) in
//            print(data)
//            print(response)
//            print(error)
            
            if error != nil {
                print("Error loading assignments =\(error)")
                return
            }
            
            
            do {
                let jsonResult:AnyObject? = try NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.MutableLeaves) as? NSDictionary
                
                if let result = jsonResult as? NSDictionary {
                    if let theItems = result["items"] as? NSArray {
                        for anItem : AnyObject in theItems {
                            //print("vamos3 = \(anItem)")
                            if let resultItem = anItem as? NSDictionary {
                                if let theDesc = resultItem["subject_task_desc"] as? NSString {
                                    if let theAltDesc = resultItem["subject_task_alternative_desc"] as? NSString {
                                        if let theOrder = resultItem["subject_task_order"] as? Int {
                                            print("-> \(theDesc) \(theAltDesc) \(theOrder)")
                                            
                                            // Load data
                                            self.assignments.append(Assignment(name:theDesc as String, desc: theAltDesc as String, order: theOrder as Int))
                                            
                                        }
                                    }
                                }
                            }
                        } // for
                        
                        // Refresh table
//                        dispatch_async(dispatch_get_main_queue(), {
//                            self.tavleView.reloadData()
//                        })
                    }
                }
            } catch let error as NSError {
                print(error)
            }
        })
        task.resume()
        
        
        return task
    }
    
    
    
    //
    // Load existing courses
    //
    func loadCourses() -> NSURLSessionTask {
        

        let requestURL = NSURL(string: "https://lifelong-learning-hub.appspot.com/_ah/api/subjectendpoint/v1/courses/")!
        let request = NSMutableURLRequest(URL: requestURL)
        request.HTTPMethod = "GET"
        
        let session = NSURLSession.sharedSession()
        let task = session.dataTaskWithRequest(request, completionHandler: {(data, response, error) in
            
            if error != nil {
                print("Error loading courses =\(error)")
                return
            }
            
            
            do {
                let jsonResult:AnyObject? = try NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.MutableLeaves) as? NSDictionary
                
                if let result = jsonResult as? NSDictionary {
                    if let theItems = result["items"] as? NSArray {
                        for anItem : AnyObject in theItems {
                            print("Course -> \(anItem)")
                            if let resultItem = anItem as? NSDictionary {
                                print("nsdictionary")
                                
                                
                                
//                                if let theDesc = resultItem["subject_task_desc"] as? NSString {
//                                    if let theAltDesc = resultItem["subject_task_alternative_desc"] as? NSString {
//                                        if let theOrder = resultItem["subject_task_order"] as? Int {
//                                            print("-> \(theDesc) \(theAltDesc) \(theOrder)")
//                                            
//                                            // Load data
//                                            self.assignments.append(Assignment(name:theDesc as String, desc: theAltDesc as String, order: theOrder as Int))
//                                            
//                                        }
//                                    }
//                                }
                            }else{
                                print("NOT nsdictionary")
                                
                            }
                            
                        } // for
                        
                        // Refresh table
                        //                        dispatch_async(dispatch_get_main_queue(), {
                        //                            self.tavleView.reloadData()
                        //                        })
                    }
                }
            } catch let error as NSError {
                print(error)
            }
        })
        task.resume()
        
        
        return task
    }
    
    
    
    //
    // Load activites for the selected course and user
    //
    func loadActivities(url: String) -> NSURLSessionTask {
        
        
        let requestURL = NSURL(string: url)!
        let request = NSMutableURLRequest(URL: requestURL)
        request.HTTPMethod = "GET"
        
        let session = NSURLSession.sharedSession()
        let task = session.dataTaskWithRequest(request, completionHandler: {(data, response, error) in

            
            if error != nil {
                print("Error loading activities =\(error)")
                return
            }
            
            
            do {
                let jsonResult:AnyObject? = try NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.MutableLeaves) as? NSDictionary
                
                if let result = jsonResult as? NSDictionary {
                    if let theItems = result["items"] as? NSArray {
                        for anItem : AnyObject in theItems {
                            print("Activity -> \(anItem)")
                            
                            
                            if let resultItem = anItem as? NSDictionary {
                                print("NSDictionary")
                                
                                if let fieldA = resultItem["id_subject"] as? NSString {
                                    

                                    if let fieldB = resultItem["activity_date_checkin"] as? NSString {
                                        if let fieldC = resultItem["activity_date_checkout"] as? NSString {
                                            print("-> \(fieldA) \(fieldB) \(fieldC)")
                                            
                                            
                                            self.activities.append(Activity(idUser:"Karin" as String, idSubject: fieldA as String, dateCheckIn: fieldB.longLongValue, dateCheckOut: fieldC.longLongValue, recordMode: 0))
                                            
                                            

                                        }
                                    }
                                }
                                
                                
                                
                                
                            }
                            
                            
                            
                        } // for
                        
                        // Refresh table
                        //                        dispatch_async(dispatch_get_main_queue(), {
                        //                            self.tavleView.reloadData()
                        //                        })
                    }
                }
            } catch let error as NSError {
                print(error)
            }
        })
        task.resume()
        
        
        return task
    }
    
    
    func loadFakeData(){
    
    
    self.assignments = [Assignment(name:"Lesson 1", desc: "aa", order: 1), Assignment(name:"Lesson 2", desc: "bbb", order: 2), Assignment(name:"Lesson 3", desc: "cc", order: 3), Assignment(name:"Lesson 4", desc: "dd", order: 4), Assignment(name:"Lesson 5", desc: "ee", order: 5), Assignment(name:"Lesson 6", desc: "ff", order: 6), Assignment(name:"Lesson 7", desc: "gg", order: 7), Assignment(name:"Lesson 8", desc: "hh", order: 8), Assignment(name:"Lesson 9", desc: "ii", order: 9)]
        
        
        
        self.courses = [Course(id: "NS1010", desc: "Geographical Information Systems", active: true), Course(id: "N2322", desc: "German", active: false)]
        
        
        
        self.activities = [Activity(idUser: "btb", idSubject: "Lesson 1", dateCheckIn: 1449734125056, dateCheckOut: 1449734195056, recordMode: 0), Activity(idUser: "btb", idSubject: "Lesson 1", dateCheckIn: 1449734225056, dateCheckOut: 1449734495056, recordMode: 0), Activity(idUser: "btb", idSubject: "Lesson 1", dateCheckIn: 1449734525056, dateCheckOut: 1449734995056, recordMode: 0)]
        
        
    }
    
    func loadSession (session: Session){
        self.session = session
    }
    
    

    func deleteActivityDB() {
        // Here you have to make httprequest to delete activiti
    }
        
    
}

