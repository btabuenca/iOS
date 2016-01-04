//
//  FirstViewController.swift
//  LearnTracker
//
//  Created by Bernardo Tabuenca on 08/12/15.
//  Copyright © 2015 Bernardo Tabuenca. All rights reserved.
//

import UIKit

//
// Track Controller
//
class FirstViewController: UIViewController, UITableViewDelegate {


    @IBOutlet weak var subjectsTable: UITableView!
    @IBOutlet weak var logoImageView: UIImageView!

    @IBOutlet weak var emptyLeftImageView: UIImageView!
    @IBOutlet weak var emptyRightImageView: UIImageView!
    @IBOutlet weak var topBarUIView: UIView!
    
    //var assignments = [Assignment]()
    
    var selectedCell:UITableViewCell = UITableViewCell(style: UITableViewCellStyle.Subtitle, reuseIdentifier: "cell")
    
    var cellSelected:Bool = false
    
    var recImage:UIImage = UIImage(named: "rec")!
    
    var playImage:UIImage = UIImage(named: "start")!
    
    var timestampCI:Int64 = 0
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Init images
        emptyLeftImageView.backgroundColor = UIColorFromRGB(0x9CA31E)
        emptyLeftImageView.contentMode = UIViewContentMode.ScaleAspectFit
        emptyRightImageView.backgroundColor = UIColorFromRGB(0x9CA31E)
        emptyRightImageView.contentMode = UIViewContentMode.ScaleAspectFit
        topBarUIView.backgroundColor = UIColorFromRGB(0x9CA31E)
        logoImageView.backgroundColor = UIColorFromRGB(0x9CA31E)
        logoImageView.contentMode = UIViewContentMode.ScaleAspectFit
        
        
        self.subjectsTable.delegate = self
    }
    
    override func viewWillAppear(animated: Bool) {
        subjectsTable.reloadData()
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
        return HTTPReqManager.sharedInstance.assignments.count
    }
    
    
    
    // Content of the cells
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell:UITableViewCell = UITableViewCell(style: UITableViewCellStyle.Subtitle, reuseIdentifier: "cell")
        
        let assig = HTTPReqManager.sharedInstance.assignments[indexPath.row]
        cell.textLabel?.text = assig.name
        cell.imageView?.image = UIImage(named: "start")
        cell.detailTextLabel?.text = assig.desc
        
        return cell
    }
    
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath){
        

        let index = subjectsTable.indexPathForSelectedRow
        selectedCell = subjectsTable.cellForRowAtIndexPath(index!)! as UITableViewCell
        cellSelected = !cellSelected
        
        
        NSLog("You selected cell number #\(indexPath.row)!")
        print("Text \(selectedCell.textLabel!.text) ")
        print("Alternate? \(cellSelected) ")
        print("Selected? \(selectedCell.selected) ")

        
        let seconds: NSTimeInterval = NSDate().timeIntervalSince1970
        let millsTimestamp:Int64 = Int64(seconds * 1000)
        
        if selectedCell.imageView?.image == playImage{

            print("Check in ...")
            selectedCell.imageView?.image = recImage
            selectedCell.imageView?.alpha = 1
            
            
            UIView.animateWithDuration(0.6, delay: 0.3, options:[.Repeat, .Autoreverse], animations: { _ in
                            self.selectedCell.imageView?.alpha = 0 }, completion: nil)
            print("->Check in!! \(millsTimestamp)")
            
            timestampCI = millsTimestamp

            
        }else{
            
            print("... check out!")
            selectedCell.imageView?.image = playImage
            selectedCell.imageView?.alpha = 1
            selectedCell.imageView?.layer.removeAllAnimations()

            print("->Check out!! \(millsTimestamp)")
            
            let assig = HTTPReqManager.sharedInstance.assignments[indexPath.row]
            
            if selectedCell.textLabel!.text == assig.name {
                
                let ac = Activity(idUser:HTTPReqManager.sharedInstance.persistance.name as String, idSubject: assig.id as String, dateCheckIn: timestampCI, dateCheckOut: millsTimestamp, recordMode: 3)
                
                HTTPReqManager.sharedInstance.insertActivity(ac)
                HTTPReqManager.sharedInstance.activities.append(ac)
                
                print("Inserted actiity !")
                
            }else{
                print("Error. The order of the rows must match their position within the table. Mabye orders were not assigned properly in the backend")
            }
            
            
            //add also item into  activities array
            
        }

        
        
//        if (!selectedCell.selected) {
//            // Cell is not s
//            
//            print("... check out!")
//            
//            selectedCell.imageView?.image = playImage
//            
//            
////            selectedCell.imageView?.alpha = 1
////            selectedCell.imageView?.layer.removeAllAnimations()
//        } else {
//            print("Check in ...")
//            
//            selectedCell.imageView?.image = recImage
//            
//            
//            
//            
////            let imgRec = UIImage(named: "rec")
////            recImageView.image = imgRec
//            
////            selectedCell.imageView?.alpha = 1
////            UIView.animateWithDuration(0.6, delay: 0.3, options:[.Repeat, .Autoreverse], animations: { _ in
////                self.selectedCell.alpha = 0 }, completion: nil)
//        }
        
        

        
//
//        if (cellSelected) {
//            hideCheckInOutView()
//            selectedCell.selected = false
//            print("selected")
//        } else {
//            showCheckInOutView()
//            selectedCell.selected = true
//            print("non selecte")
//        }

            
    }
    
    
    //-----------------------------------------------------------------------------------------
    //MARK: - Secondary Menu's
    //-----------------------------------------------------------------------------------------
//    
//    func showCheckInOutView() {
//        view.addSubview(checkInOutView)
//        
//        let bottomConstraint = checkInOutView.bottomAnchor.constraintEqualToAnchor(view.bottomAnchor)
//        let leftConstraint = checkInOutView.leftAnchor.constraintEqualToAnchor(view.leftAnchor)
//        let rightConstraint = checkInOutView.rightAnchor.constraintEqualToAnchor(view.rightAnchor)
//        let heightConstraint = checkInOutView.heightAnchor.constraintEqualToConstant(44)
//        
//        
//        NSLayoutConstraint.activateConstraints([bottomConstraint, leftConstraint, rightConstraint, heightConstraint])
//        
//        view.layoutIfNeeded()
//        
//        self.checkInOutView.alpha = 0
//        UIView.animateWithDuration(0.4) {
//            self.checkInOutView.alpha = 1.0
//        }
//    }
//    
//    func hideCheckInOutView(animated : Bool = true) {
//        UIView.animateWithDuration(0.4, animations: {
//            self.checkInOutView.alpha = 0
//            }) { completed in
//                if completed == true {
//                    self.checkInOutView.removeFromSuperview()
//                }
//        }
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
    
    
}

