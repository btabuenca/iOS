//
//  DataProvider.swift
//  LearnTracker
//
//  Created by Bernardo Tabuenca on 03/11/15.
//  Copyright © 2015 Bernardo Tabuenca. All rights reserved.
//

import UIKit

typealias ServiceResponse = (NSDictionary?, NSError?) -> Void

class DataProvider: NSObject {
    let LOGIN_URL = "/api/v1/login"
    
    class var sharedInstance:DataProvider {
        struct Singleton {
            static let instance = DataProvider()
        }
        return Singleton.instance
    }
    
    
    func loginWithEmailPassword(url:String, onCompletion: ServiceResponse) -> Void {
        

        let requestURL = NSURL(string: url)!
        let request = NSMutableURLRequest(URL: requestURL)
        request.HTTPMethod = "GET"
        
        let session = NSURLSession.sharedSession()
        let task = session.dataTaskWithRequest(request, completionHandler: {(data, response, error) in
            print(data)
            print(response)
            print(error)
            
            /// kkk
            if error != nil {
                print("error=\(error)")
                return
            }
            
            
            do {
                var jsonResult:AnyObject? = try NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.MutableLeaves) as? NSDictionary
                
                
                if let result = jsonResult as? NSDictionary {
                    print("vamos1")
                    if let theItems = result["items"] as? NSArray {
                        print("vamos2 = \(theItems)")
                        
                        for anItem : AnyObject in theItems {
                            
                            print("vamos3 = \(anItem)")
                            
                            
                            if let resultItem = anItem as? NSDictionary {
                                if let theDesc = resultItem["subject_task_desc"] as? NSString {
                                    
                                    if let theAltDesc = resultItem["subject_task_alternative_desc"] as? NSString {
                                        print("vamos4 = \(theDesc) \(theAltDesc)")
                                        
                                        //self.assignments.append(Assignment(name:theDesc as String, desc: theAltDesc as String))
                                        
                                        
                                    }
                                }
                            }
                        } // for
                    } // vamos 2
                } // vamos 1
                
                
                
            } catch let error as NSError {
                print(error)
            }
            
            
            
            
            
            /// kkk
            
        })
        
        
        
        task.resume()
        
        
    }
    
    
    
//    
//    func loginWithEmailPassword(email:String, password:String, onCompletion: ServiceResponse) -> Void {
//        self.client!.POST(LOGIN_URL, parameters: ["email":email, "password":password] , success: {(operation:AFHTTPRequestOperation!, responseObject:AnyObject!) -> Void in
//            
//            self.setupClientWithBaseURLString("http://somebaseurl.com")
//            
//            let responseDict = responseObject as NSDictionary
//            // Note: This is where you would serialize the nsdictionary in the responseObject into one of your own model classes (or core data classes)
//            onCompletion(responseDict, nil)
//            }, failure: {(operation: AFHTTPRequestOperation!, error:NSError!) -> Void  in
//                onCompletion(nil, error)
//        })
//    }
//    
    
    
}
