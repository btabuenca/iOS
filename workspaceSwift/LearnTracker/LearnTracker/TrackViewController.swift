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
    //@IBOutlet var checkInOutView: UIView!

    
    var assignments = [Assignment]()
    
    var selectedCell:UITableViewCell = UITableViewCell(style: UITableViewCellStyle.Subtitle, reuseIdentifier: "cell")
    
    var cellSelected:Bool = false
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.assignments = HTTPReqManager.sharedInstance.assignments
        print("Number of assignments \(assignments.count) ")
        
        
        
        
        self.subjectsTable.delegate = self
        //self.subjectsTable.dataSource = self
        
//        
//        checkInOutView.backgroundColor = UIColor.lightGrayColor().colorWithAlphaComponent(0.95)
//        checkInOutView.translatesAutoresizingMaskIntoConstraints = false
//        self.checkInOutView.backgroundColor = UIColor.clearColor()

        
        
        
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
        return assignments.count
    }
    
    
    
    // Content of the cells
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell:UITableViewCell = UITableViewCell(style: UITableViewCellStyle.Subtitle, reuseIdentifier: "cell")
        
        let assig = assignments[indexPath.row]
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
        print("Switch? \(cellSelected) ")
        
        if (!cellSelected) {
            print("... check out!")
//            selectedCell.imageView?.alpha = 1
//            selectedCell.imageView?.layer.removeAllAnimations()
        } else {
            print("Check in ...")
//            selectedCell.imageView?.alpha = 1
//            UIView.animateWithDuration(0.6, delay: 0.3, options:[.Repeat, .Autoreverse], animations: { _ in
//                self.selectedCell.alpha = 0 }, completion: nil)
        }
        
        

        
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
    

}

