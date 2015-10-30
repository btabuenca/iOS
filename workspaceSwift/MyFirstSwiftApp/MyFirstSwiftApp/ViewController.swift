//
//  ViewController.swift
//  MyFirstSwiftApp
//
//  Created by Bernardo Tabuenca on 15/09/15.
//  Copyright (c) 2015 Bernardo Tabuenca. All rights reserved.
//

import UIKit

class ViewController: UIViewController, SSRadioButtonControllerDelegate, UITableViewDataSource {

    
    //
    // These variables are declared as a connection between app code and interface
    //
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var label: UILabel!
    
    @IBOutlet var numberOfRoommatesTF : UITextField!
    @IBOutlet var numberOfNightsTF : UITextField!
    @IBOutlet var pricePerNightTF : UITextField!
    @IBOutlet var priceToPayL : UILabel!
    
    @IBOutlet weak var bPUT : UIButton!
    @IBOutlet weak var bGET : UIButton!
    @IBOutlet weak var bPOST : UIButton!
    
    
    @IBOutlet weak var bCheckIn : UIButton!
    @IBOutlet weak var bCheckOut : UIButton!
    

    
    var radioButtonController: SSRadioButtonsController?
    
    
    //
    // Datasource mangement
    //
    var assignments = [Assignment]()
    
    // Returns the number of chunks in the table
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    
    // Returns the number of rows
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    // Content of the cells
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = UITableViewCell()
        cell.textLabel?.text = "Lesson 1"
        return cell
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.assignments = [Assignment(name: "Lesson 1"), Assignment(name: "Lesson 2"), Assignment(name: "Lesson 3"), Assignment(name: "Lesson 4"), Assignment(name: "Lesson 5")]
        
        

    }
    
    
    

//    override func viewDidLoad() {
//        super.viewDidLoad()
//        // Do any additional setup after loading the view, typically from a nib.
//        
//        // This peace of text is for removing the keyboard
//        // Looks for single or multiple taps.
//        var tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "DismissKeyboard")
//        view.addGestureRecognizer(tap)
//        
//
//        // Handle radio buttons
//        radioButtonController = SSRadioButtonsController(buttons: bPUT, bGET, bPOST)
//        radioButtonController!.delegate = self
//        radioButtonController!.shouldLetDeSelect = true
//        
//        // Handle check in/out buttons
//        //  check in
//        let tapGestureRecognizerCI = UITapGestureRecognizer(target: self, action: "tappedCI:")
//        bCheckIn.addGestureRecognizer(tapGestureRecognizerCI)
//        let longPressRecognizerCI = UILongPressGestureRecognizer(target: self, action: "longPressedCI:")
//        longPressRecognizerCI.minimumPressDuration = 0.5
//        bCheckIn.addGestureRecognizer(longPressRecognizerCI)
//        //  check out
//        let tapGestureRecognizerCO = UITapGestureRecognizer(target: self, action: "tappedCO:")
//        bCheckOut.addGestureRecognizer(tapGestureRecognizerCO)
//        let longPressRecognizerCO = UILongPressGestureRecognizer(target: self, action: "longPressedCO:")
//        longPressRecognizerCO.minimumPressDuration = 0.5
//        bCheckOut.addGestureRecognizer(longPressRecognizerCO)
//        
//
//        
//        // Get Subjects
//        // https://lifelong-learning-hub.appspot.com/_ah/api/subjectendpoint/v1/subject
//        // https://lifelong-learning-hub.appspot.com/_ah/api/subjectendpoint/v1/subject/course/N35231
//        // GET
//        
//        
//        //SWIFT REQUEST START
//        let myUrl = NSURL(string: "https://lifelong-learning-hub.appspot.com/_ah/api/subjectendpoint/v1/subject/course/N35231");
//        let request = NSMutableURLRequest(URL:myUrl!);
//        
//        //request.HTTPMethod = "POST";
//        request.HTTPMethod = "GET";
//        
//
//        
//        let task = NSURLSession.sharedSession().dataTaskWithRequest(request) {
//            data, response, error in
//            
//            if error != nil
//            {
//                print("error=\(error)")
//                return
//            }
//            
//            // You can print out response object
//            //print("response = \(response)")
//            
//            // Print out response body
//            let responseString = NSString(data: data!, encoding: NSUTF8StringEncoding)
//            //print("responseString = \(responseString)")
//            
//            //Let’s convert response sent from a server side script to a NSDictionary object:
//            do {
//                var jsonResult:AnyObject? = try NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.MutableLeaves) as? NSDictionary
//                //print("responseJSON = \(jsonResult)")
//                
//                
//                
//                if let result = jsonResult as? NSDictionary {
//                    print("vamos1")
//                    if let theItems = result["items"] as? NSArray {
//                        print("vamos2 = \(theItems)")
//                        
//                        
//                        // Aqui estas iterando sobre un NSArray de NSDictionaries
//                        for anItem : AnyObject in theItems {
//                            
//                            print("vamos3 = \(anItem)")
//
//                            
//                        }
//                        
//                    }
//                }
//                
//
//
//            } catch let error as NSError {
//                print(error)
//            }
//            
//            
//
//            
//        }
//        
//        task.resume()
//
//        
//    }
    
    
    
    //
    // Keyboad handling
    // Calls this function when the tap is recognized.
    //
    func DismissKeyboard(){
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
    
    
    //
    // Radio button handling
    //
    func didSelectButton(aButton: UIButton?) {
        print(aButton)
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    @IBAction func Calculate(){
        
        NSLog("Calculate button pressed")
        
        let nrm = Int(numberOfRoommatesTF.text!)
        let non = Int(numberOfNightsTF.text!)
        let ppn = Int(pricePerNightTF.text!)
        
        let ptp = ((ppn! * non!) / nrm!)
        
        priceToPayL.text = String(ptp)
        
        //priceToPayL.text = "dddd"
        
        
    }

    @IBAction func tappedCI(sender: UITapGestureRecognizer)
    {
        print("tapped CI")
        //Your animation code.
    }
    
    @IBAction func longPressedCI(sender: UILongPressGestureRecognizer)
    {
        // This is to avoid twice calling
        if sender.state != UIGestureRecognizerState.Ended {
            return
        }
        
        print("longpressed CI")

    }

    @IBAction func tappedCO(sender: UITapGestureRecognizer)
    {
        print("tapped CO")
        //Your animation code.
    }
    
    @IBAction func longPressedCO(sender: UILongPressGestureRecognizer)
    {
        

        // This is to avoid twice calling
        if sender.state != UIGestureRecognizerState.Ended {
            return
        }
        
        print("longpressed CO")
        
        let but = sender.view as! UIButton

    }
    
    

}

