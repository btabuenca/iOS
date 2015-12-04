//
//  ImageProcessorInterface.swift
//
//  Copyright © 2015 Bernardo Tabuenca. All rights reserved.
//

//
// Create and test an ImageProcessor class/struct to manage an arbitrary number Filter instances to apply to an image.
// It should allow you to specify the order of application for the Filters.
//

import UIKit

public class Effect {

    let name: String
    let gradient: Int
    let order: Int
    
    public init(name: String, gradient: Int, order: Int) {
        self.gradient = gradient
        self.name = name
        self.order = order
    }
}

public class TestSet {

    let name: String
    let effects: [Effect]
    let image: RGBAImage
    
    public init(name: String, effects: [Effect], image:RGBAImage){
        self.name = name
        self.effects = effects
        self.image = image
    }
    

    public func applyAllEffects(ordered: Bool) -> RGBAImage {
        
        if ordered{
            return applyAllEffectsOrdered()
        }else{
            var newImage = self.image
            
            for effect in effects {
                newImage.applyEffect(effect.name, gradient: effect.gradient)
            }
            return newImage
        }

        
    }
        
    func applyAllEffectsOrdered() -> RGBAImage {
        
        var newImage = self.image
        
        for index in 1...5 {
            for effect in effects {
                if effect.order == index{
                    newImage.applyEffect(effect.name, gradient: effect.gradient)
                }
            }
        }
        
        return newImage
        
    }
    
    
    //
    // In the ImageProcessor interface create a new method to apply a predefined filter giving its name as a String parameter.
    // The ImageProcessor interface should be able to look up the filter and apply it.
    //
    public func applyPredifinedEffect(name: String) -> RGBAImage {
        
        var newImage = self.image
        
        switch name{
        case "RedcifyImage":
            newImage.applyEffect("Red", gradient: 0)
        case "GreencifyImage":
            newImage.applyEffect("Green", gradient: 0)
        case "PurplecufyImage":
            newImage.applyEffect("Blue", gradient: 0)
        default:
            newImage.applyEffect("", gradient: 0)
        }

        return newImage

        
        
    }
    
    
    
    
}
