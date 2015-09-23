//
//  ViewController.swift
//  MyFirstSwiftApp
//
//  Created by Bernardo Tabuenca on 15/09/15.
//  Copyright (c) 2015 Bernardo Tabuenca. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    // These variables are declared as a connection between appa code and interface
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var label: UILabel!
    
    @IBOutlet var numberOfRoommatesTF : UITextField!
    @IBOutlet var numberOfNightsTF : UITextField!
    @IBOutlet var pricePerNightTF : UITextField!
    @IBOutlet var priceToPayL : UILabel!
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
        //if let image = UIImage(named: "Pumpkin") {
        //    imageView.image = image
        //}
        
        // This text was added for testing
        // numberOfRoommatesTF.text = "Hello room mates!!"
        // numberOfNightsTF.text = "2"
        // pricePerNightTF.text = "50"
        
        
        

        
        
 //       let image = UIImage(named: "Pumpkin")
 //       imageView.image = image
        
        //self.label.text = @"Hello";
        
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


}

