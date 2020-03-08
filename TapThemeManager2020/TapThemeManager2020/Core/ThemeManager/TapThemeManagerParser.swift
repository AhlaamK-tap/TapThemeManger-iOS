//
//  TapThemeManagerParser.swift
//  TapThemeManager2020
//
//  Created by Osama Rabie on 08/03/2020.
//  Copyright © 2020 Osama Rabie. All rights reserved.
//
import UIKit


/// All the methods required to parse String values provided in the theme file into readable iOS values like UIColor, UIFont, etc.
@objc extension TapThemeManager {
    
    /**
    - The method for getting a certain value in the current theme dictrionary
    - Parameter keyPath: The key of the value needed
    - Returns: The value of the key, could be another object, String, Number, etc.
    */
    public class func value(for keyPath: String) -> Any? {
        return currentTheme?.value(forKeyPath: keyPath)
    }
    
    /**
    - The method for getting a STRING value from the current theme dictionary
    - Parameter keyPath: The key of the string needed
    - Returns: The STRING value of the key, and nil if doesn't exist
    */
    public class func stringValue(for keyPath: String) -> String? {
        guard let parsedString = currentTheme?.value(forKeyPath: keyPath) as? String else {
            print("TapThemeManager WARNING: Not found string key path: \(keyPath)")
            return nil
        }
        return parsedString
    }
    
    /**
    - The method for getting a Numeric value from the current theme dictionary
    - Parameter keyPath: The key of the Number needed
    - Returns: The NSNumber value of the key, and nil if doesn't exist
    */
    public class func numberValue(for keyPath: String) -> NSNumber? {
        guard let parsedNumber = currentTheme?.value(forKeyPath: keyPath) as? NSNumber else {
            print("TapThemeManager WARNING: Not found number key path: \(keyPath)")
            return nil
        }
        return parsedNumber
    }
    
    /**
    - The method for getting a dictionary value from the current theme dictionary
    - Parameter keyPath: The key of the dictionary needed
    - Returns: The dictionary value of the key, and nil if doesn't exist
    */
    public class func dictionaryValue(for keyPath: String) -> NSDictionary? {
        guard let parsedDictionary = currentTheme?.value(forKeyPath: keyPath) as? NSDictionary else {
            print("TapThemeManager WARNING: Not found dictionary key path: \(keyPath)")
            return nil
        }
        return parsedDictionary
    }
    
    
    /**
    - The method for getting a UIColor value from the current theme dictionary
    - Parameter keyPath: The key of the UIColor needed
    - Returns: The UIColor value of the key, and nil if doesn't exist
    */
    public class func colorValue(for keyPath: String) -> UIColor? {
        // First we need to gett tthe HEX value as string
        guard let parsedRGBString = stringValue(for: keyPath) else { return nil }
        // Now we use our hex extenstion
        guard let parsedColor = try? UIColor(tap_hex: parsedRGBString) else {
            print("TapThemeManager WARNING: Not convert RGBA Hex string \(parsedRGBString) at key path: \(keyPath)")
            return nil
        }
        return parsedColor
    }
    
    /**
       - The method for getting a UIImage value from the current theme dictionary
       - Parameter keyPath: The key of the UIImage needed
       - Returns: The UIImage value of the key, and nil if doesn't exist
       */
    public class func imageValue(for keyPath: String) -> UIImage? {
        guard let parsedImageName = stringValue(for: keyPath) else { return nil }
        // Incase we will add afterwards reading from different paths other than the Main Bundle
        if let filePath = currentThemePath?.themeURL?.appendingPathComponent(parsedImageName).path {
           return imageValue(fromLocalURL: filePath)
        } else {
            // Try to parse the image from the main bundle
            return imageValue(imageName: parsedImageName)
        }
    }
    
    
    /**
    - The method for getting a UIImage value from a given URL
    - Parameter fromLocalURL: The path of the UIImage needed
    - Returns: The UIImage value of the key, and nil if doesn't exist
    */
    private class func imageValue(fromLocalURL:String) -> UIImage? {
        guard let parsedImage = UIImage(contentsOfFile: fromLocalURL) else {
            print("TapThemeManager WARNING: Not found image at file path: \(fromLocalURL)")
            return nil
        }
        return parsedImage
    }
    
    
    /**
    - The method for getting a UIImage value from the main bundle
    - Parameter imageName: The needed image name
    - Returns: The UIImage value of the key, and nil if doesn't exist
    */
    private class func imageValue(imageName:String) -> UIImage? {
        guard let parsedImage = UIImage(named: imageName) else {
            print("TapThemeManager WARNING: Not found image name at main bundle: \(imageName)")
            return nil
        }
        return parsedImage
    }
    
}
