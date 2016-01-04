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

    // Persist
    var persistance : Persistence!
    
    
    // Non persist data
    var assignments = [Assignment]()
    var courses = [Course]()
    var activities = [Activity]()
    
    
    
    

    private init() {
        print(__FUNCTION__)
    }
    

    
    //
    // Load subjects for the selected course
    //
    func loadAssignments(url: String) -> NSURLSessionTask {
        
        
        let requestURL = NSURL(string: url)!
        print("New REQUEST. \(url)")
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
                        
                        // Empty old items
                        self.assignments.removeAll()
                        
                        for anItem : AnyObject in theItems {
                            //print("vamos3 = \(anItem)")
                            if let resultItem = anItem as? NSDictionary {
                                if let theDesc = resultItem["subject_task_desc"] as? NSString {
                                    if let theAltDesc = resultItem["subject_task_alternative_desc"] as? NSString {
                                        if let theId = resultItem["id"] as? NSString {
                                            if let theOrder = resultItem["subject_task_order"] as? Int {
                                                print("-> \(theId) \(theDesc) \(theAltDesc) \(theOrder)")
                                            
                                                // Load data
                                                self.assignments.append(Assignment(id:theId as String, name:theDesc as String, desc: theAltDesc as String, order: theOrder as Int))
                                            }
                                        }
                                            
                                    }
                                }
                            }
                        } // for
                        

                        // Order array
//                        var images : [imageFile] = []
//                        images.sort({ $0.fileID > $1.fileID })


                        
                        // When finished
                        dispatch_async(dispatch_get_main_queue(), {
                            
                            self.assignments.sortInPlace({ $0.order < $1.order })
                            //self.printAssignments(self.assignments)

                        })
                        
                        
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
        

        print("New REQUEST. https://lifelong-learning-hub.appspot.com/_ah/api/subjectendpoint/v1/courses/")
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
                        
                        // Empty old items
                        self.courses.removeAll()
                        
                        for anItem : AnyObject in theItems {
                            print("Course append -> \(anItem)")
                            
                            self.courses.append(Course(id: anItem as! String, desc: "empty", active: false))
                            
                            print("Number of items -> \(self.courses.count) - ")
                        } // for
                        
                        
                        // When finished
                        dispatch_async(dispatch_get_main_queue(), {
                            
                            self.courses.sortInPlace({ $0.desc < $1.desc })
                        })

                        
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
        

        print("New REQUEST. \(url)")
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
                        
                        // Empty old items
                        self.activities.removeAll()
                        
                        for anItem : AnyObject in theItems {
                            print("Activity -> \(anItem)")
                            
                            
                            if let resultItem = anItem as? NSDictionary {
                                //print("NSDictionary")
                                
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
                        
                        
                        // When finished
                        dispatch_async(dispatch_get_main_queue(), {
                            print("Ordering activities array ...")
                            self.activities.sortInPlace({ $0.dateCheckIn < $1.dateCheckIn })
                            
                            
                        })
                        
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
    
    
        self.assignments = [Assignment(id:"111", name:"Lesson 1", desc: "aa", order: 1), Assignment(id:"222", name:"Lesson 2", desc: "bbb", order: 2), Assignment(id:"333", name:"Lesson 3", desc: "cc", order: 3), Assignment(id:"444", name:"Lesson 4", desc: "dd", order: 4), Assignment(id:"555", name:"Lesson 5", desc: "ee", order: 5), Assignment(id:"666", name:"Lesson 6", desc: "ff", order: 6), Assignment(id:"777", name:"Lesson 7", desc: "gg", order: 7), Assignment(id:"888", name:"Lesson 8", desc: "hh", order: 8), Assignment(id:"999", name:"Lesson 9", desc: "ii", order: 9)]
        
        self.courses = [Course(id: "NS1010", desc: "Geographical Information Systems", active: true), Course(id: "N2322", desc: "German", active: false)]
        
        self.activities = [Activity(idUser: "btb", idSubject: "Lesson 1", dateCheckIn: 1449734125056, dateCheckOut: 1449734195056, recordMode: 0), Activity(idUser: "btb", idSubject: "Lesson 1", dateCheckIn: 1449734225056, dateCheckOut: 1449734495056, recordMode: 0), Activity(idUser: "btb", idSubject: "Lesson 1", dateCheckIn: 1449734525056, dateCheckOut: 1449734995056, recordMode: 0), Activity(idUser: "btb", idSubject: "Lesson 2", dateCheckIn: 1449734525056, dateCheckOut: 1449734995056, recordMode: 0), Activity(idUser: "btb", idSubject: "Lesson 3", dateCheckIn: 1449734525056, dateCheckOut: 1449734995056, recordMode: 0), Activity(idUser: "btb", idSubject: "Lesson 2", dateCheckIn: 1449734525056, dateCheckOut: 1449734995056, recordMode: 0), Activity(idUser: "btb", idSubject: "Lesson 4", dateCheckIn: 1449734525056, dateCheckOut: 1449734995056, recordMode: 0)]
        
        
    }
    
    func deleteActivity(checkin: String, user: String){
        
        let s = "https://lifelong-learning-hub.appspot.com/_ah/api/activityendpoint/v1/activity/checkin/" + checkin + "/user/" + user
        
        print("New DELETE. \(s)")
        
//
// https://lifelong-learning-hub.appspot.com/_ah/api/activityendpoint/v1/activity/checkin/1451323109462/user/ppp
//
        
        
//https://github.com/btabuenca/Android/blob/master/workspaceLearnTracker/3LHub/src/org/ounl/lifelonglearninghub/learntracker/gis/ou/db/ws/ActivityWSDeleteAsyncTask.java
        
        let requestURL = NSURL(string:s)!
        
        var request = NSMutableURLRequest(URL: requestURL)
        request.HTTPMethod = "DELETE"
        
        let session = NSURLSession.sharedSession()
        
        
        let task = NSURLSession.sharedSession().dataTaskWithRequest(request){ data, response, error in
            if error != nil{
                print("Error -> \(error)")
                return
            }
            
            do {
                let result = try NSJSONSerialization.JSONObjectWithData(data!, options: []) as? [String:AnyObject]
                
                print("Result -> \(result)")
                
            } catch {
                print("Error -> \(error)")
            }
        }
        
        
        task.resume()
    }
    
    
    
    
    
    func insertActivity(activity: Activity) -> NSURLSessionTask {
        
        
        let json = [ Activity.KEY_IDUSER : activity.idUser, Activity.KEY_IDSUBJECT : activity.idSubject, Activity.KEY_RECORDMODE : "3", Activity.KEY_LOCATION_LONGITUDE : "0",Activity.KEY_LOCATION_LATITUDE : "0", Activity.KEY_CHECKIN : String(activity.dateCheckIn), Activity.KEY_CHECKOUT : String(activity.dateCheckOut) ]
        
        
        do {
            
            let jsonData = try NSJSONSerialization.dataWithJSONObject(json, options: .PrettyPrinted)
            
            // create post request
            print("New INSERT.  https://lifelong-learning-hub.appspot.com/_ah/api/activityendpoint/v1/activity")
            let url = NSURL(string: "https://lifelong-learning-hub.appspot.com/_ah/api/activityendpoint/v1/activity")!
            let request = NSMutableURLRequest(URL: url)
            request.HTTPMethod = "POST"
            
            // insert json data to the request
            request.setValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")
            request.HTTPBody = jsonData
            
            
            let task = NSURLSession.sharedSession().dataTaskWithRequest(request){ data, response, error in
                if error != nil{
                    print("Error -> \(error)")
                    return
                }

                do {
                    let result = try NSJSONSerialization.JSONObjectWithData(data!, options: []) as? [String:AnyObject]

                    print("Result -> \(result)")
                    
                } catch {
                    print("Error -> \(error)")
                }
            }
            
            task.resume()
            return task

            
            
        } catch {
            print(error)
        }
        
        return NSURLSessionTask()
    }
    

    
    
    func printAssignments(assig : [Assignment]){
        
        print("-------------Start --------------------------------------")
        for a in assig {
            print("Assign -> \(a.order) *  \(a.name) * \(a.desc) *")
        }
        print("-------------End --------------------------------------")
        
    }
    
    
    func getSummary()->Dictionary<String, Int64>{
        
        let key = activities[0].idSubject
        let value = Int64(0)
        var summary = [key: value]
        
        
        for a in activities {
            
            if summary[a.idSubject] == nil {
                // Add element
                summary[a.idSubject] = (a.dateCheckOut - a.dateCheckIn)
                print("Add -> \(a.idSubject) *  \(a.idUser) * \(a.dateCheckIn) * \(a.dateCheckOut) * \(a.dateCheckOut - a.dateCheckIn)")
                
            }else{
                // Increase value of existing element
                let val = summary[a.idSubject]
                let dif = (a.dateCheckOut - a.dateCheckIn)
                summary[a.idSubject] = val! + dif
                print("Inc -> \(a.idSubject) *  \(a.idUser) * \(a.dateCheckIn) * \(a.dateCheckOut) * \(a.dateCheckOut - a.dateCheckIn)")
                
            }
            
        }
        
        return summary
        
    }
    

    func printSummary(){
        
        var summary = getSummary()
        
        for (key, value) in summary {
            
            
            let seconds = Double(value) / 1000
            let mins = seconds.minute
            
            print("\(key) -> mills \(value) -> mins \(mins)")
            
            
        }
        
    }
    
}




