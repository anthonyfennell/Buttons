//
//  UIColor+Utils.swift
//  ButtonPlay
//
//  Created by Anthony Fennell on 1/24/19.
//  Copyright © 2019 Anthony Fennell. All rights reserved.
//

import UIKit

public extension UIColor {
    convenience init(rgba: UInt) {
        let red = CGFloat(rgba >> 24) / 255.0
        let green = CGFloat((rgba >> 16) & 0xFF) / 255.0
        let blue = CGFloat((rgba >> 8) & 0xFF) / 255.0
        let alpha = CGFloat(rgba & 0xFF) / 255.0
        self.init(red: red, green: green, blue: blue, alpha: alpha)
    }
    
    convenience init(hex: Int) {
        let red = CGFloat(hex >> 16) / 255.0
        let green = CGFloat((hex >> 8) & 0xFF) / 255.0
        let blue = CGFloat(hex & 0xFF) / 255.0
        self.init(red: red, green: green, blue: blue, alpha: 1.0)
    }
}
