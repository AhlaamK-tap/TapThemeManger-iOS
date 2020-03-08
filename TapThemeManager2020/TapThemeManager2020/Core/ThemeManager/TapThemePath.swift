//
//  TapThemePath.swift
//  TapThemeManager2020
//
//  Created by Osama Rabie on 08/03/2020.
//  Copyright © 2020 Osama Rabie. All rights reserved.
//

import Foundation

/// The enum to decide if we are loading the theme from JSON, PLIST
@objc public final class TapThemePath: NSObject {

    /**
    - The method for rettrning the path of a plist file
    - Parameter fileName: The name of the plist file that has the needed theme
    */
    public func themePlistPath(fileName: String) -> String? {
        return themeFilePath(fileName: fileName, ofType: "plist")
    }
    
    /**
    - The method for rettrning the path of a JSON file
    - Parameter fileName: The name of the JSON file that has the needed theme
    */
    public func themeJsonPath(fileName: String) -> String? {
        return themeFilePath(fileName: fileName, ofType: "json")
    }
    
    /**
    - The method for calcilating the path of a given file
    - Parameter fileName: The name of the file
    - Parameter type:     The type of the file
    */
    private func themeFilePath(fileName: String, ofType type: String) -> String? {
        return Bundle.main.path(forResource: fileName, ofType: type)
    }
}