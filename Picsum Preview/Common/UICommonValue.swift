//
//  UICommonValue.swift
//  Picsum Preview
//
//  Created by TrieuLD on 8/11/20.
//  Copyright © 2020 TrieuLD. All rights reserved.
//

import UIKit

class UICommonValue: NSObject {
    static let defaultCorner: CGFloat = 8
    static let smallSpacing: CGFloat = 8
    static let defaultSpacing: CGFloat = 16
    
    static let isIpad: Bool = UIDevice.current.userInterfaceIdiom == .pad
    
    static var isLandscape: Bool {
        get {
            return UIDevice.current.orientation.isLandscape
        }
    }
    
    static var screenWidth: CGFloat {
        get {
            return UIScreen.main.bounds.width
        }
    }
    static var screenHeight: CGFloat {
        get {
            return UIScreen.main.bounds.height
        }
    }
    
}
