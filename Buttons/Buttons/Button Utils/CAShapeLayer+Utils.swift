//
//  CAShapeLayer+Utils.swift
//  ButtonPlay
//
//  Created by Anthony Fennell on 3/19/19.
//  Copyright © 2019 Anthony Fennell. All rights reserved.
//

import UIKit

public extension CAShapeLayer {
    func animateStrokeWithColor(color: UIColor) -> CABasicAnimation {
        strokeColor = color.cgColor
        fillColor = nil
        let strokeAnimation: CABasicAnimation = CABasicAnimation(keyPath: "strokeEnd")
        strokeAnimation.fromValue = 0.0
        strokeAnimation.toValue = 1.0
        strokeAnimation.duration = 0.6
        add(strokeAnimation, forKey: nil)
        return strokeAnimation
    }
}
