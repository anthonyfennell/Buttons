//
//  DiamondButton.swift
//  ButtonPlay
//
//  Created by Anthony Fennell on 3/15/19.
//  Copyright © 2019 Anthony Fennell. All rights reserved.
//

import UIKit

public class DiamondButton: DefaultButton {
    public override func configure() {
        super.configure()
        self.drawable = DiamondButtonDrawable()
    }
    
    public override func touchUpInsideEvent() {
        super.touchUpInsideEvent()
        
        let rotation = CABasicAnimation(keyPath: "transform.rotation.z")
        rotation.duration = 0.22
        rotation.fromValue = 0
        rotation.toValue = CGFloat.pi / 2
        rotation.isCumulative = true
        rotation.repeatCount = 0
        self.layer.add(rotation, forKey: nil)
    }
}

struct DiamondButtonDrawable: Drawable {
    func getPath(bounds: CGRect, borderWidth: CGFloat, cornerRadius: CGFloat) -> UIBezierPath {
        if cornerRadius != 0 {
            return getCornerRadiusPath(bounds: bounds, borderWidth: borderWidth, cornerRadius: cornerRadius)
        } else {
            return getDefaultPath(bounds: bounds, borderWidth: borderWidth, cornerRadius: cornerRadius)
        }
    }
    
    func getCornerRadiusPath(bounds: CGRect, borderWidth: CGFloat, cornerRadius: CGFloat) -> UIBezierPath {
        let path = UIBezierPath()
        let left = bounds.minX + borderWidth / 2
        let right = bounds.maxX - borderWidth / 2
        let top = bounds.minY + borderWidth / 2
        let bottom = bounds.maxY - borderWidth / 2
        let middleX = bounds.maxX / 2
        let middleY = bounds.maxY / 2
        let radius = cornerRadius
        
        let cornerOffset = radius * 2
        let startPoint = CGPoint(x: middleX - cornerOffset, y: top + cornerOffset)
        var beforeCurvePoint = startPoint
        let topControlY = top
        
        // Start at midX, top
        path.move(to: startPoint)
        
        // Top Curve
        var endPoint = CGPoint(x: middleX + cornerOffset, y: top + cornerOffset)
        var controlPoint = CGPoint(x: middleX, y: topControlY)
        path.addQuadCurve(to: endPoint, controlPoint: controlPoint)
        
        // To right, midY
        beforeCurvePoint = CGPoint(x: right - cornerOffset, y: middleY - cornerOffset)
        path.addLine(to: beforeCurvePoint)
        
        // Right Curve
        endPoint = CGPoint(x: right - cornerOffset, y: middleY + cornerOffset)
        controlPoint = CGPoint(x: right, y: middleY)
        path.addQuadCurve(to: endPoint, controlPoint: controlPoint)
        
        // To bottom, midX
        beforeCurvePoint = CGPoint(x: middleX + cornerOffset, y: bottom - cornerOffset)
        path.addLine(to: beforeCurvePoint)
        
        // Bottom Curve
        endPoint = CGPoint(x: middleX - cornerOffset, y: bottom - cornerOffset)
        controlPoint = CGPoint(x: middleX, y: bottom)
        path.addQuadCurve(to: endPoint, controlPoint: controlPoint)
        
        // To left, midY
        beforeCurvePoint = CGPoint(x: left + cornerOffset, y: middleY + cornerOffset)
        path.addLine(to: beforeCurvePoint)
        
        // Left Curve
        endPoint = CGPoint(x: left + cornerOffset, y: middleY - cornerOffset)
        controlPoint = CGPoint(x: left, y: middleY)
        path.addQuadCurve(to: endPoint, controlPoint: controlPoint)

        // To start point
        path.addLine(to: startPoint)
        
        return path
    }
    
    func getDefaultPath(bounds: CGRect, borderWidth: CGFloat, cornerRadius: CGFloat) -> UIBezierPath {
        let path = UIBezierPath()
        let left = bounds.minX
        let right = bounds.maxX
        let top = bounds.minY
        let bottom = bounds.maxY
        let middleX = bounds.maxX / 2
        let middleY = bounds.maxY / 2
        path.lineWidth = borderWidth
        
        let startPoint = CGPoint(x: middleX, y: top)
        path.move(to: startPoint)
        path.addLine(to: CGPoint(x: right, y: middleY))
        path.addLine(to: CGPoint(x: middleX, y: bottom))
        path.addLine(to: CGPoint(x: left, y: middleY))
        path.addLine(to: startPoint)
        return path
    }
}
