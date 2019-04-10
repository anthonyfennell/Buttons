//
//  TriangleButton.swift
//  ButtonPlay
//
//  Created by Anthony Fennell on 1/25/19.
//  Copyright © 2019 Anthony Fennell. All rights reserved.
//

import UIKit

public class TriangleButton: DefaultButton {
    public override func configure() {
        super.configure()
        self.drawable = TriangleButtonDrawable()
    }
}

public class TriangleFlippedButton: DefaultButton {
    public override func configure() {
        super.configure()
        self.drawable = TriangleFlippedButtonDrawable()
    }
}

struct TriangleButtonDrawable: Drawable {
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
        let radius = cornerRadius
        
        var x = (left + radius * 2)
        let startPoint = CGPoint(x: x, y: bottom)
        let bottomControlY = bottom
        
        // Start at bottom left
        path.move(to: startPoint)
        
        // Curve
        var endPoint = CGPoint(x: x, y: bottom - radius * 2)
        var controlPoint = CGPoint(x: left + radius, y: bottomControlY)
        path.addQuadCurve(to: endPoint, controlPoint: controlPoint)
        path.addLine(to: CGPoint(x: middleX - radius, y: top + radius))
        
        // Top
        endPoint = CGPoint(x: middleX + radius, y: top + radius)
        controlPoint = CGPoint(x: middleX, y: 0)
        path.addQuadCurve(to: endPoint, controlPoint: controlPoint)
        
        // Bottom Right
        x = right - radius * 2
        path.addLine(to: CGPoint(x: x, y: bottom - radius * 2))
        endPoint = CGPoint(x: x, y: bottom)
        controlPoint = CGPoint(x: right - radius, y: bottomControlY)
        path.addQuadCurve(to: endPoint, controlPoint: controlPoint)
        path.addLine(to: startPoint)
        return path
    }
    
    func getDefaultPath(bounds: CGRect, borderWidth: CGFloat, cornerRadius: CGFloat) -> UIBezierPath {
        let path = UIBezierPath()
        let left = bounds.minX + borderWidth / 2
        let right = bounds.maxX - borderWidth / 2
        let top = bounds.minY + borderWidth / 2
        let bottom = bounds.maxY - borderWidth / 2
        let middleX = bounds.maxX / 2
        path.lineWidth = borderWidth
        
        let startPoint = CGPoint(x: left, y: bottom)
        path.move(to: startPoint)
        path.addLine(to: CGPoint(x: middleX, y: top))
        path.addLine(to: CGPoint(x: right, y: bottom))
        path.addLine(to: startPoint)
        return path
    }
}

struct TriangleFlippedButtonDrawable: Drawable {
    func getPath(bounds: CGRect, borderWidth: CGFloat, cornerRadius: CGFloat) -> UIBezierPath {
         return getDefaultPath(bounds: bounds, borderWidth: borderWidth, cornerRadius: cornerRadius)
    }
    
    func getCornerRadiusPath(bounds: CGRect, borderWidth: CGFloat, cornerRadius: CGFloat) -> UIBezierPath {
        
        // TODO: - This method is not finished
        
        let path = UIBezierPath()
        let left = bounds.minX
        let right = bounds.maxX
        let top = bounds.minY
        let bottom = bounds.maxY
        let middleX = bounds.maxX / 2
        let radius = cornerRadius
        
        var x = (left + radius * 2)
        let startPoint = CGPoint(x: x, y: bottom)
        let bottomControlY = bottom
        
        // Start at bottom left
        path.move(to: startPoint)
        
        // Curve
        var endPoint = CGPoint(x: x, y: bottom - radius * 2)
        var controlPoint = CGPoint(x: left + radius, y: bottomControlY)
        path.addQuadCurve(to: endPoint, controlPoint: controlPoint)
        path.addLine(to: CGPoint(x: middleX - radius, y: top + radius))
        
        // Top
        endPoint = CGPoint(x: middleX + radius, y: top + radius)
        controlPoint = CGPoint(x: middleX, y: 0)
        path.addQuadCurve(to: endPoint, controlPoint: controlPoint)
        
        // Bottom Right
        x = right - radius * 2
        path.addLine(to: CGPoint(x: x, y: bottom - radius * 2))
        endPoint = CGPoint(x: x, y: bottom)
        controlPoint = CGPoint(x: right - radius, y: bottomControlY)
        path.addQuadCurve(to: endPoint, controlPoint: controlPoint)
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
        path.lineWidth = borderWidth
        
        let startPoint = CGPoint(x: left, y: top)
        path.move(to: startPoint);
        path.addLine(to: CGPoint(x: right, y: top));
        path.addLine(to: CGPoint(x: middleX, y: bottom))
        path.addLine(to: startPoint)
        return path
    }
}
