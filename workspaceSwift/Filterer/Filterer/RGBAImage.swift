import UIKit



public struct Pixel {
    public var value: UInt32
    
    public var red: UInt8 {
        get {
            return UInt8(value & 0xFF)
        }
        set {
            value = UInt32(newValue) | (value & 0xFFFFFF00)
        }
    }
    
    public var green: UInt8 {
        get {
            return UInt8((value >> 8) & 0xFF)
        }
        set {
            value = (UInt32(newValue) << 8) | (value & 0xFFFF00FF)
        }
    }
    
    public var blue: UInt8 {
        get {
            return UInt8((value >> 16) & 0xFF)
        }
        set {
            value = (UInt32(newValue) << 16) | (value & 0xFF00FFFF)
        }
    }
    
    public var alpha: UInt8 {
        get {
            return UInt8((value >> 24) & 0xFF)
        }
        set {
            value = (UInt32(newValue) << 24) | (value & 0x00FFFFFF)
        }
    }
}

public struct RGBAImage : Filter {
    public var pixels: UnsafeMutableBufferPointer<Pixel>
    
    public var width: Int
    public var height: Int
    
    
    public init?(image: UIImage) {
        guard let cgImage = image.CGImage else { return nil }
        
        // Redraw image for correct pixel format
        let colorSpace = CGColorSpaceCreateDeviceRGB()
        
        var bitmapInfo: UInt32 = CGBitmapInfo.ByteOrder32Big.rawValue
        bitmapInfo |= CGImageAlphaInfo.PremultipliedLast.rawValue & CGBitmapInfo.AlphaInfoMask.rawValue
        
        width = Int(image.size.width)
        height = Int(image.size.height)
        let bytesPerRow = width * 4
        
        let imageData = UnsafeMutablePointer<Pixel>.alloc(width * height)
        
        guard let imageContext = CGBitmapContextCreate(imageData, width, height, 8, bytesPerRow, colorSpace, bitmapInfo) else { return nil }
        CGContextDrawImage(imageContext, CGRect(origin: CGPointZero, size: image.size), cgImage)

        pixels = UnsafeMutableBufferPointer<Pixel>(start: imageData, count: width * height)
    }
    
    public func toUIImage() -> UIImage? {
        let colorSpace = CGColorSpaceCreateDeviceRGB()
        var bitmapInfo: UInt32 = CGBitmapInfo.ByteOrder32Big.rawValue
        bitmapInfo |= CGImageAlphaInfo.PremultipliedLast.rawValue & CGBitmapInfo.AlphaInfoMask.rawValue
        
        let bytesPerRow = width * 4

        let imageContext = CGBitmapContextCreateWithData(pixels.baseAddress, width, height, 8, bytesPerRow, colorSpace, bitmapInfo, nil, nil)
        
        guard let cgImage = CGBitmapContextCreateImage(imageContext) else {return nil}
        let image = UIImage(CGImage: cgImage)
        
        return image
    }
    
    //
    // Returns average R G B colours
    //  for image
    //
    public func getAvgRGB() -> (iAvgR: Int, iAvgG: Int, iAvgB: Int) {
        
        var totalR = 0
        var totalG = 0
        var totalB = 0
                
        for pixel in pixels {
            totalR += Int(pixel.red)
            totalG += Int(pixel.green)
            totalB += Int(pixel.blue)
            
            var myPixel = pixel
            myPixel.red = 0
            myPixel.green = 0
            myPixel.blue = 0
        }
        
        let avgR = totalR / pixels.count
        let avgG = totalG / pixels.count
        let avgB = totalB / pixels.count
        
        return (avgR, avgG, avgB)
        

    }

    
    //
    // Create the image processor
    // Encapsulate your chosen Filter parameters and/or formulas in a struct/class definition.
    //
    public func applyEffect(effect: String, gradient: Int) {
        
        // Increase contrast for pixels that are brighter than the average
        for y in 0..<height{
            for x in 0..<width{
                let index = y * width + x
                var pixel = pixels[index]
                
                switch effect{
                case "Red", "Blue":
                    //pixel.red = UInt8(255) // Redify
                    pixel.red = getPxEffect(effect, gradient: gradient, pxToModify: pixel.red)
                case "Green", "Pink":
                    //pixel.green = UInt8(255) // Greenefy
                    pixel.green = getPxEffect(effect, gradient: gradient, pxToModify: pixel.green)
                case "Purple", "Yellow":
                    //pixel.blue = UInt8(255) // Purplecify
                    pixel.blue = getPxEffect(effect, gradient: gradient, pxToModify: pixel.blue)
                case "Black":
                    // Fade to black
                    pixel.red = UInt8(255)
                    pixel.green = UInt8(255)
                    pixel.blue = UInt8(255)
                    
                default:
                    pixel.red = UInt8(124) // Not allowed params. To grey
                    pixel.green = UInt8(124)
                    pixel.blue = UInt8(124)
                }
                

                pixels[index] = pixel
                
            }
        }
    }
    

    //
    // Create the image processor
    // Encapsulate your chosen Filter parameters and/or formulas in a struct/class definition.
    //
    func getPxEffect(effect: String, gradient: Int, pxToModify: UInt8) -> UInt8 {

        var g = 40 * gradient
        if g > 255 {
            g = 0
        }
        

        switch effect{
               case "Red":
                    return max(UInt8(255 - g), pxToModify) // Redify
                case "Blue":
                    return min(UInt8(0 + g), pxToModify) // Bluceify
                case "Green":
                    return max(UInt8(255 - g), pxToModify) // Greenefy
                case "Pink":
                    return min(UInt8(0 + g), pxToModify) // Pinkify
                case "Purple":
                    return max(UInt8(255 - g), pxToModify) // Purplecify
                case "Yellow":
                    return min(UInt8(0 + g), pxToModify) // Yellowcify
                default:
                    return UInt8(124)
        }
                
        
        
    }
    
    
    //
    // Create predefined filters
    // Create five reasonable default Filter configurations (e.g. "50% Brightness”, “2x Contrast”), and provide an interface to access instances of such defaults by name.
    // (e.g. could be custom subclasses of a Filter class, or static instances of Filter available in your ImageProcessor interface, or a Dictionary of Filter instances). 
    // There is no requirement to do this in a specific manner, but it’s good to think about the different ways you could go about it.
    //
    //
    public func redcify() {
        applyEffect("Red", gradient: 255)
    }
    public func bluecify() {
        applyEffect("Red", gradient: 0)
    }
    public func greencify() {
        applyEffect("Green", gradient: 255)
    }
    public func purplecify() {
        applyEffect("Blue", gradient: 255)
    }
    public func yellowcify() {
        applyEffect("Blue", gradient: 0)
    }
    
}



protocol Filter {
    //
    // Protocol definition
    //
    func redcify()
    func bluecify()
    func greencify()
    func purplecify()
    func yellowcify()
    
}




