//
//  ViewController.swift
//  Filterer
//
//

import UIKit

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    var filteredImage: UIImage?
    var timer: NSTimer?
    var lastFilter: String?
    
    @IBOutlet var imageView: UIImageView!
    
    // Menus (containers)
    @IBOutlet var secondaryMenu: UIView!
    @IBOutlet var headingMenu: UIView!
    @IBOutlet var bottomMenu: UIView!
    
    
    @IBOutlet var filterButton: UIButton!
    @IBOutlet weak var compareButton: UIButton!
    
    // Submenu buttons. Filters
    @IBOutlet var fRedButton: [UIButton]!
    
    @IBOutlet weak var fRedButtonNC: UIButton!
    @IBOutlet weak var fGreenButton: UIButton!
    @IBOutlet weak var fBlueButton: UIButton!
    @IBOutlet weak var fYellowButton: UIButton!
    @IBOutlet weak var fPurpleButton: UIButton!
    
    @IBOutlet weak var sliderGradient: UISlider!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        secondaryMenu.backgroundColor = UIColor.whiteColor().colorWithAlphaComponent(0.5)
        secondaryMenu.translatesAutoresizingMaskIntoConstraints = false
        compareButton.enabled = false
        
        // Init original image
        let image = UIImage(named: "gah")!
        imageView.image = image
        
        // Add gesture recognizer
        // The first press will last 0.2 + 1 sec of the NSTimer
        let tapGestureRecognizer = UILongPressGestureRecognizer(target:self, action: "action:")
        tapGestureRecognizer.minimumPressDuration = 0.2
        imageView.userInteractionEnabled = true
        imageView.addGestureRecognizer(tapGestureRecognizer)
        
        
        
        // Init filtered image
        let rgbaImageA = RGBAImage(image: image)!
        rgbaImageA.applyEffect("Blue", gradient: 2)
        filteredImage = rgbaImageA.toUIImage()!
        
        
        fGreenButton.setImage(UIImage(named: "gre_150x"), forState: UIControlState.Normal)
        fBlueButton.setImage(UIImage(named: "blu_150x"), forState: UIControlState.Normal)
        fPurpleButton.setImage(UIImage(named: "pur_150x"), forState: UIControlState.Normal)
        fRedButtonNC.setImage(UIImage(named: "yel_150x"), forState: UIControlState.Normal)
        fYellowButton.setImage(UIImage(named: "yel_150x"), forState: UIControlState.Normal)
        
        sliderGradient.enabled = false
        
        
        
    }

    // MARK: Share
    @IBAction func onShare(sender: AnyObject) {
        let activityController = UIActivityViewController(activityItems: ["Check out our really cool app", imageView.image!], applicationActivities: nil)
        presentViewController(activityController, animated: true, completion: nil)
    }
    
    // MARK: New Photo
    @IBAction func onNewPhoto(sender: AnyObject) {
        let actionSheet = UIAlertController(title: "New Photo", message: nil, preferredStyle: .ActionSheet)
        
        actionSheet.addAction(UIAlertAction(title: "Camera", style: .Default, handler: { action in
            self.showCamera()
        }))
        
        actionSheet.addAction(UIAlertAction(title: "Album", style: .Default, handler: { action in
            self.showAlbum()
        }))
        
        actionSheet.addAction(UIAlertAction(title: "Cancel", style: .Cancel, handler: nil))
        
        self.presentViewController(actionSheet, animated: true, completion: nil)
    }
    
    func showCamera() {
        let cameraPicker = UIImagePickerController()
        cameraPicker.delegate = self
        cameraPicker.sourceType = .Camera
        
        presentViewController(cameraPicker, animated: true, completion: nil)
    }
    
    func showAlbum() {
        let cameraPicker = UIImagePickerController()
        cameraPicker.delegate = self
        cameraPicker.sourceType = .PhotoLibrary
        
        presentViewController(cameraPicker, animated: true, completion: nil)
    }
    
    // MARK: UIImagePickerControllerDelegate
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        dismissViewControllerAnimated(true, completion: nil)
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
            imageView.image = image
        }
    }
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    // MARK: Filter Menu
    @IBAction func onFilter(sender: UIButton) {
        if (sender.selected) {
            hideSecondaryMenu()
            sender.selected = false
            compareButton.enabled = false
            compareButton.selected = false
            sliderGradient.enabled = false
        } else {
            showSecondaryMenu()
            sender.selected = true
            sliderGradient.enabled = true
        }
    }
    
    func showSecondaryMenu() {
        view.addSubview(secondaryMenu)
        
        let bottomConstraint = secondaryMenu.bottomAnchor.constraintEqualToAnchor(bottomMenu.topAnchor)
        let leftConstraint = secondaryMenu.leftAnchor.constraintEqualToAnchor(view.leftAnchor)
        let rightConstraint = secondaryMenu.rightAnchor.constraintEqualToAnchor(view.rightAnchor)
        
        let heightConstraint = secondaryMenu.heightAnchor.constraintEqualToConstant(44)
        
        NSLayoutConstraint.activateConstraints([bottomConstraint, leftConstraint, rightConstraint, heightConstraint])
        
        view.layoutIfNeeded()
        
        self.secondaryMenu.alpha = 0
        UIView.animateWithDuration(0.4) {
            self.secondaryMenu.alpha = 1.0
        }
    }

    func hideSecondaryMenu() {
        UIView.animateWithDuration(0.4, animations: {
            self.secondaryMenu.alpha = 0
            }) { completed in
                if completed == true {
                    self.secondaryMenu.removeFromSuperview()
                }
        }
    }
    
    @IBAction func applyRedFilter(sender: AnyObject) {
        
        // Get original image
        let image = UIImage(named: "gah")!
        lastFilter = "Red"
        
        // Apply filter
        let rgbaImageA = RGBAImage(image: image)!
        rgbaImageA.applyEffect(lastFilter!, gradient: Int(round(sliderGradient.value)))
        filteredImage = rgbaImageA.toUIImage()!
        
        showFiltered()
    
        
    }
    
    
    
    @IBAction func applyGreenFilter(sender: AnyObject) {
        
        // Get original image
        let image = UIImage(named: "gah")!
        lastFilter = "Green"
        
        // Apply filter
        let rgbaImageA = RGBAImage(image: image)!
        rgbaImageA.applyEffect(lastFilter!, gradient: Int(round(sliderGradient.value)))
        filteredImage = rgbaImageA.toUIImage()!
        
        showFiltered()
    
        
    }
    
    
    @IBAction func applyBlueFilter(sender: AnyObject) {
        
        // Get original image
        let image = UIImage(named: "gah")!
        lastFilter = "Blue"
        
        // Apply filter
        let rgbaImageA = RGBAImage(image: image)!
        rgbaImageA.applyEffect(lastFilter!, gradient: Int(round(sliderGradient.value)))
        filteredImage = rgbaImageA.toUIImage()!
        
        showFiltered()
        
    }
    
    
    @IBAction func applyYellowFilter(sender: AnyObject) {
        
        // Get original image
        let image = UIImage(named: "gah")!
        lastFilter = "Yellow"
        
        // Apply filter
        let rgbaImageA = RGBAImage(image: image)!
        rgbaImageA.applyEffect(lastFilter!, gradient: Int(round(sliderGradient.value)))
        filteredImage = rgbaImageA.toUIImage()!
        
        showFiltered()
        
    }
    
    
    @IBAction func applyPurpleFilter(sender: AnyObject) {
        
        // Get original image
        let image = UIImage(named: "gah")!
        lastFilter = "Purple"
        
        // Apply filter
        let rgbaImageA = RGBAImage(image: image)!
        rgbaImageA.applyEffect(lastFilter!, gradient: Int(round(sliderGradient.value)))
        filteredImage = rgbaImageA.toUIImage()!
        
        showFiltered()
        
    }
    
    
    func showFiltered(){
        imageView.image = filteredImage
        compareButton.selected = true
        compareButton.enabled = true
        hideHeading()
    }
    
    func showOriginal(){
        let image = UIImage(named: "gah")!
        imageView.image = image
        compareButton.selected = false
        showHeading()
    }
    
    @IBAction func onCompare(sender: AnyObject) {
        if compareButton.selected{
            showOriginal()
        } else {
            showFiltered()
        }
    }
    

    
    func action(gestureRecognizer:UIGestureRecognizer) {
        
        if gestureRecognizer.state == .Began {
            print("Began!")
            
            timer = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: "onTimeExpired", userInfo: nil, repeats: true)

        } else if gestureRecognizer.state == .Ended{
            print("Ended!")
            
            timer?.invalidate()
            showOriginal()
            
        } else {
            print("Who knows...")
        }

        
    }
    
    
    func onTimeExpired() {
        if compareButton.selected{
            showOriginal()
        } else {
            showFiltered()
        }
        
    }
    
    
    

    func showHeading() {
        
        
        let label = UILabel(frame: CGRectMake(0, 10, UIScreen.mainScreen().bounds.width, 40))
        label.textColor = UIColor.grayColor()
//        label.font = UIFont(name: label.font.fontName, size: 16)
        label.font = UIFont.boldSystemFontOfSize(16)
        label.textAlignment = NSTextAlignment.Center
        label.text = "Original"
        //self.view?.addSubview(label)
        headingMenu.addSubview(label)
        
        
        

        
        view.addSubview(headingMenu)
        
        let bottomConstraint = headingMenu.bottomAnchor.constraintEqualToAnchor(view.topAnchor)
        let leftConstraint = headingMenu.leftAnchor.constraintEqualToAnchor(view.leftAnchor)
        let rightConstraint = headingMenu.rightAnchor.constraintEqualToAnchor(view.rightAnchor)
        let heightConstraint = headingMenu.heightAnchor.constraintEqualToConstant(30)
        
        NSLayoutConstraint.activateConstraints([bottomConstraint, leftConstraint, rightConstraint, heightConstraint])
        
        view.layoutIfNeeded()
        
        
        
        self.headingMenu.alpha = 0
        UIView.animateWithDuration(0.4) {
            self.headingMenu.alpha = 1.0
        }
    }
    
    func hideHeading() {
        UIView.animateWithDuration(0.4, animations: {
            self.headingMenu.alpha = 0
            }) { completed in
                if completed == true {
                    self.headingMenu.removeFromSuperview()
                }
        }
    }
    
    
    func animateImage(no:Int) {
        
//
//        var back: UIImageView!
//        var front: UIImageView!
//        
//        
//        self.front = UIImageView(image: UIImage(named: "heads.png"))
//        self.back = UIImageView(image: UIImage(named: "tails.png"))
//        
//        
//        self.cardView.addSubview(self.back)
//        UIView.transitionFromView(self.back, toView: self.front, duration: 1, options: UIViewAnimationOptions.TransitionFlipFromRight , completion: nil)
//        
        
    }
    
    
    @IBAction func onSliderValueChanged(sender: AnyObject) {
        
        // Apply last filter
        let image = UIImage(named: "gah")!
        let rgbaImageA = RGBAImage(image: image)!
        rgbaImageA.applyEffect(lastFilter!, gradient: Int(round(sliderGradient.value)))
        filteredImage = rgbaImageA.toUIImage()!
        
        showFiltered()
        
    }
    
    
    

}

