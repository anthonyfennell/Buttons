//
//  LoadingOrbsButton.swift
//  Buttons
//
//  Created by Anthony Fennell on 4/2/19.
//  Copyright © 2019 Anthony Fennell. All rights reserved.
//

import Foundation

public class LoadingOrbsButton: LoadingButton {
    private let circleDiameter: CGFloat = 6.0
    private let circleRadius: CGFloat = 3.0
    private let spacing: CGFloat = 30
    private let duration: TimeInterval = 0.6
    private var title: String? = nil
    
    public override func animateLoading() {
        self.title = self.title(for: .normal)
        self.setTitle(nil, for: .normal)
        
        let y = self.center.y - circleRadius
        let middleRect = CGRect(x: self.center.x - circleRadius, y: y, width: circleDiameter, height: circleDiameter)
        let rightRect = CGRect(x: self.center.x + circleRadius + spacing, y: y, width: circleDiameter, height: circleDiameter)
        let leftRect = CGRect(x: self.center.x - circleRadius - spacing - circleDiameter, y: y, width: circleDiameter, height: circleDiameter)
        
        let leftLayer = getCircleLayer(rect: leftRect)
        let middleLayer = getCircleLayer(rect: middleRect)
        let rightLayer = getCircleLayer(rect: rightRect)
        self.layer.addSublayer(leftLayer)
        self.layer.addSublayer(middleLayer)
        self.layer.addSublayer(rightLayer)
        
        self.animationLayers.append(leftLayer)
        self.animationLayers.append(middleLayer)
        self.animationLayers.append(rightLayer)
        
        animateFadeInFor(left: leftLayer, middle: middleLayer, right: rightLayer)
    }
    
    public override func stopLoadingAnimation() {
        super.stopLoadingAnimation()
        self.setTitle(self.title, for: .normal)
    }
    
    func animateFadeInFor(left: CAShapeLayer, middle: CAShapeLayer, right: CAShapeLayer) {
        let fade = CABasicAnimation(keyPath: "opacity")
        fade.duration = 0.5
        fade.fromValue = 0.0
        fade.toValue = 1.0
        fade.fillMode = .both
        fade.timingFunction = CAMediaTimingFunction(name: .easeIn)
        left.add(fade, forKey: nil)
        
        let delay: TimeInterval = 0.3
        fade.beginTime = CACurrentMediaTime() + delay
        middle.add(fade, forKey: nil)
        
        fade.beginTime = CACurrentMediaTime() + delay * 2.0
        fade.setValue("end", forKey: "fade")
        fade.delegate = self
        right.add(fade, forKey: nil)
    }
    
    func animateSlideAndCircleBackWith(delay: TimeInterval) {
        guard let left = self.animationLayers.first as? CAShapeLayer,
            let middle = self.animationLayers[1] as? CAShapeLayer,
            let right = self.animationLayers.last as? CAShapeLayer else {
                return
        }
        
        animateToRight(layer: left, delay: delay)
        animateToRight(layer: middle, delay: delay)
        
        let randomChoice = Int.random(in: 0...1)
        if randomChoice == 0 {
            animateUpAndAround(layer: right, delay: delay)
        } else {
            animateDownAndAround(layer: right, delay: delay)
        }
    }
    
    func animateToRight(layer: CAShapeLayer, delay: TimeInterval) {
        let animation = CABasicAnimation(keyPath: "position.x")
        animation.fromValue = layer.frame.origin.x
        animation.beginTime = CACurrentMediaTime() + delay
        animation.toValue = layer.frame.origin.x + circleDiameter + spacing
        animation.duration = self.duration
        animation.fillMode = .backwards
        layer.add(animation, forKey: nil)
    }
    
    func animateUpAndAround(layer: CAShapeLayer, delay: TimeInterval) {
        let path = UIBezierPath()
        let x = layer.frame.origin.x
        let y = layer.frame.origin.y
        let endX = layer.frame.origin.x - spacing * 2 - circleDiameter * 2
        path.move(to: CGPoint(x: x, y: y))
        path.addLine(to: CGPoint(x: x, y: y + 10))
        path.addLine(to: CGPoint(x: endX, y: y + 10))
        path.addLine(to: CGPoint(x: endX, y: y))
        animateRight(layer: layer, delay: delay, path: path.cgPath)
    }
    
    func animateDownAndAround(layer: CAShapeLayer, delay: TimeInterval) {
        let path = UIBezierPath()
        let x = layer.frame.origin.x
        let y = layer.frame.origin.y
        let endX = layer.frame.origin.x - spacing * 2 - circleDiameter * 2
        path.move(to: CGPoint(x: x, y: y))
        path.addLine(to: CGPoint(x: x, y: y - 10))
        path.addLine(to: CGPoint(x: endX, y: y - 10))
        path.addLine(to: CGPoint(x: endX, y: y))
        animateRight(layer: layer, delay: delay, path: path.cgPath)
    }
    
    func animateRight(layer: CAShapeLayer, delay: TimeInterval, path: CGPath) {
        let animation = CAKeyframeAnimation(keyPath: "position")
        animation.path = path
        animation.beginTime = CACurrentMediaTime() + delay
        animation.duration = self.duration
        animation.fillMode = .backwards
        animation.delegate = self
        animation.setValue("circle", forKey: "animation")
        layer.add(animation, forKey: nil)
    }
    
    func getCircleLayer(rect: CGRect) -> CAShapeLayer {
        let layer = CAShapeLayer()
        layer.path = UIBezierPath(ovalIn: rect).cgPath
        layer.fillColor = UIColor.white.cgColor
        return layer
    }
    
    public override func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        
        if let value = anim.value(forKey: "fade") as? String, value == "end" {
            self.animateSlideAndCircleBackWith(delay: 0.0)
        } else if let value = anim.value(forKey: "animation") as? String, value == "circle" {
            self.animateSlideAndCircleBackWith(delay: 0.3)
        }

    }
    
}
