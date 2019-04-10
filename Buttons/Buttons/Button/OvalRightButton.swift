//
//  OvalRightButton.swift
//  ButtonPlay
//
//  Created by Anthony Fennell on 1/24/19.
//  Copyright © 2019 Anthony Fennell. All rights reserved.
//

import UIKit

public class OvalRightButton: DefaultButton {
    public override func configure() {
        super.configure()
        self.drawable = OvalRightButtonDrawable()
        self.imageEdgeInsets = UIEdgeInsets(top: 0, left: self.frame.size.width - 35, bottom: 0, right: 0)
    }
}

struct OvalRightButtonDrawable: Drawable {
    func getPath(bounds: CGRect, borderWidth: CGFloat, cornerRadius: CGFloat) -> UIBezierPath {
        let path = UIBezierPath()
        let left = bounds.minX
        let right = bounds.maxX
        let top = bounds.minY
        let bottom = bounds.maxY
        let width = right - left
        
        path.lineWidth = borderWidth
        path.move(to: CGPoint(x: right, y: top));
        let endPoint = CGPoint(x: right, y: bottom)
        let control1 = CGPoint(x: -(width * 0.3), y: (bottom - top) * 0.10)
        let control2 = CGPoint(x: -(width * 0.3), y: (bottom - top) * 0.90)
        path.addCurve(to: endPoint, controlPoint1: control1, controlPoint2: control2)
        path.addLine(to: CGPoint(x: right, y: top))
        return path
    }
}
