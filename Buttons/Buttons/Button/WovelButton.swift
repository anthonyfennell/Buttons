//
//  WovelButton.swift
//  ButtonPlay
//
//  Created by Anthony Fennell on 1/24/19.
//  Copyright © 2019 Anthony Fennell. All rights reserved.
//

import UIKit

public class WovelButton: DefaultButton {
    public override func configure() {
        super.configure()
        self.drawable = WovelButtonDrawable()
    }
}

struct WovelButtonDrawable: Drawable {
    func getPath(bounds: CGRect, borderWidth: CGFloat, cornerRadius: CGFloat) -> UIBezierPath {
        let path = UIBezierPath()
        let left = bounds.minX + borderWidth / 2
        let right = bounds.maxX - borderWidth / 2
        let top = bounds.minY + borderWidth / 2
        let bottom = bounds.maxY - borderWidth / 2
        let width = right - left
        let rightEdge = bounds.maxX
        let middleY = bounds.maxY / 2
        let offset = right * 0.20
        path.lineWidth = borderWidth
        
        path.move(to: CGPoint(x: left + offset, y: middleY));
        var endPoint = CGPoint(x: right - offset, y: middleY)
        var control1 = CGPoint(x: (-width * 0.3), y: top)
        var control2 = CGPoint(x: (rightEdge + width * 0.3), y: top)
        path.addCurve(to: endPoint, controlPoint1: control1, controlPoint2: control2)
        
        endPoint = CGPoint(x: left + offset, y: middleY)
        control1 = CGPoint(x: (rightEdge + width * 0.4), y: bottom - bottom * 0.2)
        control2 = CGPoint(x: (-width * 0.4), y: bottom - bottom * 0.2)
        path.addCurve(to: endPoint, controlPoint1: control1, controlPoint2: control2)
        return path
    }
}
