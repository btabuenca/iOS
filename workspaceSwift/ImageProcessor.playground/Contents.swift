//: Playground - noun: a place where people can play

import UIKit

let image = UIImage(named: "sample")!

// Process the image!

// These are different instances of the image 
// to distinguish the effects
let rgbaImageA = RGBAImage(image: image)!
let rgbaImageB = RGBAImage(image: image)!
let rgbaImageC = RGBAImage(image: image)!
let rgbaImageD = RGBAImage(image: image)!
let rgbaImageE = RGBAImage(image: image)!
let rgbaImageF = RGBAImage(image: image)!
let rgbaImageG = RGBAImage(image: image)!
let rgbaImageH = RGBAImage(image: image)!
let rgbaImageI = RGBAImage(image: image)!

let rgbaImageBattery = RGBAImage(image: image)!

//
// STEP 2: Create a simple filter
// Start by writing some code to apply a basic filter formula to each pixel in the image and test it.
//
rgbaImageA.applyEffect("Green", gradient: 0)
//rgbaImageA.applyEffect("Red", gradient: 3)
let newImageA = rgbaImageA.toUIImage()!

rgbaImageB.applyEffect("Green", gradient: 1)
//rgbaImageB.applyEffect("Green", gradient: 0)
let newImageB = rgbaImageB.toUIImage()!


rgbaImageC.applyEffect("Green", gradient: 2)
//rgbaImageC.applyEffect("Blue", gradient: 0)
let newImageC = rgbaImageC.toUIImage()!


rgbaImageD.applyEffect("Green", gradient: 3)
//rgbaImageD.applyEffect("Blue", gradient: 0)
let newImageD = rgbaImageD.toUIImage()!



//
// STEP 3: Create the image processor
//
// Create and test an ImageProcessor class/struct to manage an arbitrary number Filter instances to apply to an image. 
// It should allow you to specify the order of application for the Filters.
//
//
// Accepted names
// Accepted gradients 0 1 2 3
//      Values higher than 3 imply no filter applied
// Accepted orders 1 .. .n
var effectsBattery = [
    Effect(name: "Blue", gradient: 0, order: 5),
    Effect(name: "Yellow", gradient: 5, order: 1),
    Effect(name: "Red", gradient: 5, order: 2),
    Effect(name: "Green", gradient: 5, order: 3),
    Effect(name: "Red", gradient: 5, order: 4)
]

let testBattery = TestSet(name: "Battery 1", effects: effectsBattery, image: rgbaImageBattery)
let resultingImage = testBattery.applyAllEffects(false).toUIImage()!
// In this case, there is no difference in the final imagen when the order of the effects is varied
let resultingOrderedImage = testBattery.applyAllEffects(true).toUIImage()!

//
//
// STEP 4: Create predefined filters
// Create five reasonable default Filter configurations (e.g. "50% Brightness”, “2x Contrast”), 
//  and provide an interface to access instances of such defaults by name.
// (e.g. could be custom subclasses of a Filter class, or static instances of Filter available in 
// your ImageProcessor interface, or a Dictionary of Filter instances).
// There is no requirement to do this in a specific manner, but it’s good to think about the different ways you could go about it.
//
// Plese note that Protocol Filter has been created for this implmenteation

rgbaImageE.redcify()
let newImageE = rgbaImageE.toUIImage()!

//
// STEP 5: Apply predefined filters
// In the ImageProcessor interface create a new method to apply a predefined filter giving its name as a String parameter. 
// The ImageProcessor interface should be able to look up the filter and apply it.
//
let testPredefined = TestSet(name: "Battery 2", effects: effectsBattery, image: rgbaImageBattery)
let resultPredefinedImage = testPredefined.applyPredifinedEffect("GreencifyImage").toUIImage()!




