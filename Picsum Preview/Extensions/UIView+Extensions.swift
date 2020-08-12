//
//  UIView+Extensions.swift
//  Picsum Preview
//
//  Created by TrieuLD on 8/11/20.
//  Copyright © 2020 TrieuLD. All rights reserved.
//

import UIKit

extension UIView {
    var left: CGFloat {
        get {
            return frame.origin.x
        }
        set {
            frame.origin.x = newValue
        }
    }
    
    var top: CGFloat {
        get {
            return frame.origin.y
        }
        set {
            frame.origin.y = newValue
        }
    }

    var right: CGFloat {
        get {
            return left + width
        }
        set {
            left = newValue - width
        }
    }

    var bottom: CGFloat {
        get {
            return top + height
        }
        set {
            top = newValue - height
        }
    }

    var width: CGFloat {
        get {
            return bounds.width
        }
        set {
            frame.size.width = newValue
        }
    }
    
    var height: CGFloat {
        get {
            return bounds.height
        }
        set {
            frame.size.height = newValue
        }
    }
}
