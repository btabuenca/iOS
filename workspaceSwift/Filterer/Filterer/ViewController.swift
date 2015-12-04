//
//  ViewController.swift
//  Filterer
//
//  Created by Bernardo Tabuenca on 20/11/15.
//  Copyright © 2015 Bernardo Tabuenca. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var filteredImage: UIImage?

    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var uilabelOriginal: UILabel!

    
    //
    // Filter button
    //
    @IBOutlet weak var bFilter: UIButton!
    @IBAction func onbFilter(sender: AnyObject) {
        showFiltered()
    }
    
    
    //
    // Toggle (compare) button
    //
    @IBOutlet weak var imageToggle: UIButton!
    @IBAction func onImageToggle(sender: AnyObject) {
        
        if imageToggle.selected{
            showOriginal()
        } else {
            showFiltered()
        }
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Init original image
        let image = UIImage(named: "btabuenca")!
        imgView.image = image
        
        // Add gesture recognizer
        let tapGestureRecognizer = UITapGestureRecognizer(target:self, action:Selector("imageTapped:"))
        imgView.userInteractionEnabled = true
        imgView.addGestureRecognizer(tapGestureRecognizer)
        
        // Init filtered image
        let rgbaImageA = RGBAImage(image: image)!
        rgbaImageA.applyEffect("Blue", gradient: 2)
        //rgbaImageA.applyEffect("Green", gradient: 0)
        //rgbaImageA.applyEffect("Red", gradient: 3)
        filteredImage = rgbaImageA.toUIImage()!
        
        // Handle overlay textview

        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    //
    // Tap on image
    //
    func imageTapped(img: AnyObject)
    {
        // Your action
        if imageToggle.selected{
            showOriginal()
        } else {
            showFiltered()
        }
    }
    
    
    func showFiltered(){
        imgView.image = filteredImage
        imageToggle.selected = true
        //uilabelOriginal.hidden = !uilabelOriginal.hidden
        uilabelOriginal.textColor = UIColor.whiteColor()
    }
    
    func showOriginal(){
        let image = UIImage(named: "btabuenca")!
        imgView.image = image
        imageToggle.selected = false
        uilabelOriginal.textColor = UIColor.blackColor()
    }
    

}
