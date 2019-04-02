//
//  LoadingFillButton.swift
//  Buttons
//
//  Created by Anthony Fennell on 4/2/19.
//  Copyright © 2019 Anthony Fennell. All rights reserved.
//

import Foundation

public class LoadingFillButton: LoadingButton {
    
    public override func animateLoading() {
        let path = self.drawable.getPath(bounds: self.bounds, borderWidth: self.borderWidth, cornerRadius: self.cornerRadius)
        let layer = CAShapeLayer()
        layer.path = path.cgPath
        layer.lineWidth = self.borderWidth
        self.layer.addSublayer(layer)
        animateBorderStrokeWithColor(color: self.borderColor, on: layer)
        self.animationLayers.append(layer)
    }
    
    func animateBorderStrokeWithColor(color: UIColor, on layer: CAShapeLayer) {
        layer.strokeColor = color.cgColor
        layer.fillColor = nil
        let strokeAnimation: CABasicAnimation = CABasicAnimation(keyPath: "strokeEnd")
        strokeAnimation.fromValue = 0.0
        strokeAnimation.toValue = 1.0
        strokeAnimation.duration = 0.6
        strokeAnimation.setValue("stroke", forKey: "animation")
        strokeAnimation.delegate = self
        layer.add(strokeAnimation, forKey: nil)
    }
    
    func animateFill() {
        let layer = CAShapeLayer()
        layer.strokeColor = self.borderColor.cgColor
        layer.fillColor = self.borderColor.cgColor
        self.layer.addSublayer(layer)
        self.animationLayers.append(layer)
        
        let animationDuration: CFTimeInterval = 0.6
        let width: CGFloat = self.bounds.width
        var rect = self.bounds.divided(atDistance: self.cornerRadius * 2, from: .minXEdge).slice
        let pathPre = self.drawable.getPath(bounds: rect, borderWidth: self.borderWidth, cornerRadius: self.cornerRadius)
        rect = self.bounds.divided(atDistance: width / 4, from: .minXEdge).slice
        let pathLow = self.drawable.getPath(bounds: rect, borderWidth: self.borderWidth, cornerRadius: self.cornerRadius)
        let arcAnimationPre: CABasicAnimation = CABasicAnimation(keyPath: "path")
        arcAnimationPre.fromValue = pathPre.cgPath
        arcAnimationPre.toValue = pathLow.cgPath
        arcAnimationPre.duration = animationDuration
        
        rect = self.bounds.divided(atDistance: width * 2 / 4, from: .minXEdge).slice
        let pathMid = self.drawable.getPath(bounds: rect, borderWidth: self.borderWidth, cornerRadius: self.cornerRadius)
        let arcAnimationMid: CABasicAnimation = CABasicAnimation(keyPath: "path")
        arcAnimationMid.fromValue = pathLow.cgPath
        arcAnimationMid.toValue = pathMid.cgPath
        arcAnimationMid.beginTime = arcAnimationPre.beginTime + arcAnimationPre.duration
        arcAnimationMid.duration = animationDuration
        
        rect = self.bounds.divided(atDistance: width * 3 / 4, from: .minXEdge).slice
        let pathHigh = self.drawable.getPath(bounds: rect, borderWidth: self.borderWidth, cornerRadius: self.cornerRadius)
        let arcAnimationHigh: CABasicAnimation = CABasicAnimation(keyPath: "path")
        arcAnimationHigh.fromValue = pathMid.cgPath
        arcAnimationHigh.toValue = pathHigh.cgPath
        arcAnimationHigh.beginTime = arcAnimationMid.beginTime + arcAnimationMid.duration
        arcAnimationHigh.duration = animationDuration
        
        let pathComplete = self.drawable.getPath(bounds: self.bounds, borderWidth: self.borderWidth, cornerRadius: self.cornerRadius)
        let arcAnimationComplete: CABasicAnimation = CABasicAnimation(keyPath: "path")
        arcAnimationComplete.fromValue = pathHigh.cgPath
        arcAnimationComplete.toValue = pathComplete.cgPath
        arcAnimationComplete.beginTime = arcAnimationHigh.beginTime + arcAnimationHigh.duration
        arcAnimationComplete.duration = animationDuration
        
        let arcAnimationGroup: CAAnimationGroup = CAAnimationGroup()
        arcAnimationGroup.animations = [arcAnimationPre, arcAnimationMid, arcAnimationHigh, arcAnimationComplete]
        arcAnimationGroup.duration = arcAnimationComplete.beginTime + arcAnimationComplete.duration
        arcAnimationGroup.fillMode = CAMediaTimingFillMode.forwards
        arcAnimationGroup.repeatCount = .infinity
        
        layer.add(arcAnimationGroup, forKey: nil)
    }
    
    func getPrePath() -> UIBezierPath {
        let path = UIBezierPath()
        let left = bounds.minX + borderWidth / 2
        let top = bounds.minY + borderWidth / 2
        let bottom = bounds.maxY - borderWidth / 2
        let radius = cornerRadius
        
        let x = left + radius
        var y = bottom - radius
        // bottom left before radius
        path.move(to: CGPoint(x: (left + radius), y: bottom))
        path.addArc(withCenter: CGPoint(x: x, y: y), radius: radius, startAngle: .pi / 2, endAngle: .pi, clockwise: true) // bottom left corner
        path.addLine(to: CGPoint(x: left, y: top + radius))
        y = top + radius
        path.addArc(withCenter: CGPoint(x: x, y: y), radius: radius, startAngle: .pi, endAngle: 3 * .pi / 2, clockwise: true) // top left corner
        path.addLine(to: CGPoint(x: left + radius, y: bottom))
        return path
    }
    
    override public func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        super.animationDidStop(anim, finished: flag)
        
        guard let value = anim.value(forKey: "animation") as? String, value == "stroke" else {
            return
        }
        
        animateFill()
    }
    
}
