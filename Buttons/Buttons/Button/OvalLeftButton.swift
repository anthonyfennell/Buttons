//
//  OvalLeftButton.swift
//  ButtonPlay
//
//  Created by Anthony Fennell on 1/24/19.
//  Copyright © 2019 Anthony Fennell. All rights reserved.
//

import UIKit

public class OvalLeftButton: DefaultButton {
    public override func configure() {
        super.configure()
        self.drawable = OvalLeftButtonDrawable()
        self.imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: self.frame.size.width - 35)
    }
}

struct OvalLeftButtonDrawable: Drawable {
    func getPath(bounds: CGRect, borderWidth: CGFloat, cornerRadius: CGFloat) -> UIBezierPath {
        let path = UIBezierPath()
        let left = bounds.minX + borderWidth / 2
        let right = bounds.maxX - borderWidth / 2
        let top = bounds.minY + borderWidth / 2
        let bottom = bounds.maxY - borderWidth / 2
        let width = right - left
        let rightEdge = bounds.maxX
        path.lineWidth = borderWidth
        
        path.move(to: CGPoint(x: left, y: top));
        let endPoint = CGPoint(x: left, y: bottom)
        let control1 = CGPoint(x: (rightEdge + width * 0.3), y: (bottom - top) * 0.10)
        let control2 = CGPoint(x: (rightEdge + width * 0.3), y: (bottom - top) * 0.90)
        path.addCurve(to: endPoint, controlPoint1: control1, controlPoint2: control2)
        path.addLine(to: CGPoint(x: left, y: top))
        return path
    }
}
