//
//  ViewController.swift
//  MyFirstSwiftApp
//
//  Created by Bernardo Tabuenca on 15/09/15.
//  Copyright (c) 2015 Bernardo Tabuenca. All rights reserved.
//

import UIKit

class ViewController: UIViewController, SSRadioButtonControllerDelegate {
    
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
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        // This peace of text is for removing the keyboard
        // Looks for single or multiple taps.
        var tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "DismissKeyboard")
        view.addGestureRecognizer(tap)
        

        // Handle radio buttons
        radioButtonController = SSRadioButtonsController(buttons: bPUT, bGET, bPOST)
        radioButtonController!.delegate = self
        radioButtonController!.shouldLetDeSelect = true
        
        // Handle check in/out buttons
        //  check in
        let tapGestureRecognizerCI = UITapGestureRecognizer(target: self, action: "tappedCI:")
        bCheckIn.addGestureRecognizer(tapGestureRecognizerCI)
        let longPressRecognizerCI = UILongPressGestureRecognizer(target: self, action: "longPressedCI:")
        longPressRecognizerCI.minimumPressDuration = 0.5
        bCheckIn.addGestureRecognizer(longPressRecognizerCI)
        //  check out
        let tapGestureRecognizerCO = UITapGestureRecognizer(target: self, action: "tappedCO:")
        bCheckOut.addGestureRecognizer(tapGestureRecognizerCO)
        let longPressRecognizerCO = UILongPressGestureRecognizer(target: self, action: "longPressedCO:")
        longPressRecognizerCO.minimumPressDuration = 0.5
        bCheckOut.addGestureRecognizer(longPressRecognizerCO)
        
        
        // This text was added for testing
        // numberOfRoommatesTF.text = "Hello room mates!!"
        // numberOfNightsTF.text = "2"
        // pricePerNightTF.text = "50"
        
        
        

        
        
 //       let image = UIImage(named: "Pumpkin")
 //       imageView.image = image
        
        //self.label.text = @"Hello";
        
    }
    
    
    
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
//        if but.tag == BUTTON_CHECKIN {
//            print(" - check in")
//        } else if but.tag == BUTTON_CHECKOUT {
//            print(" - check out")
//        }



        
        //print(b)

        
        //Different code
    }
    
    

}

