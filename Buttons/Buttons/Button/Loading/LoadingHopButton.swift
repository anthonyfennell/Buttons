//
//  LoadingHopButton.swift
//  Buttons
//
//  Created by Anthony Fennell on 4/4/19.
//  Copyright © 2019 Anthony Fennell. All rights reserved.
//

import UIKit

public class LoadingHopButton: LoadingButton {
    private let circleDiameter: CGFloat = 6.0
    private let circleRadius: CGFloat = 3.0
    private let spacing: CGFloat = 30
    private let duration: TimeInterval = 0.4
    private var title: String? = nil
    
    public override func animateLoading() {
        self.title = self.title(for: .normal)
        self.setTitle(nil, for: .normal)
        
        // 0-0+ x +0-0
        
        let y = self.center.y - circleRadius
        let rightRect1 = CGRect(x: self.center.x + 0.5 * spacing, y: y, width: circleDiameter, height: circleDiameter)
        let rightRect2 = CGRect(x: self.center.x + 1.5 * spacing + circleDiameter, y: y, width: circleDiameter, height: circleDiameter)
        let leftRect1 = CGRect(x: self.center.x - 1.5 * spacing - circleDiameter * 2, y: y, width: circleDiameter, height: circleDiameter)
        let leftRect2 = CGRect(x: self.center.x - 0.5 * spacing - circleDiameter, y: y, width: circleDiameter, height: circleDiameter)
        
        let leftLayer1 = getCircleLayer(rect: leftRect1)
        let leftLayer2 = getCircleLayer(rect: leftRect2)
        let rightLayer1 = getCircleLayer(rect: rightRect1)
        let rightLayer2 = getCircleLayer(rect: rightRect2)
        self.layer.addSublayer(leftLayer1)
        self.layer.addSublayer(leftLayer2)
        self.layer.addSublayer(rightLayer1)
        self.layer.addSublayer(rightLayer2)
        
        self.animationLayers.append(leftLayer1)
        self.animationLayers.append(leftLayer2)
        self.animationLayers.append(rightLayer1)
        self.animationLayers.append(rightLayer2)
        
        animateFadeInFor(left1: leftLayer1, left2: leftLayer2, right1: rightLayer1, right2: rightLayer2)
    }
    
    public override func stopLoadingAnimation() {
        super.stopLoadingAnimation()
        self.setTitle(self.title, for: .normal)
    }
    
    func animateFadeInFor(left1: CAShapeLayer, left2: CAShapeLayer, right1: CAShapeLayer, right2: CAShapeLayer) {
        let fade = CABasicAnimation(keyPath: "opacity")
        fade.duration = 0.5
        fade.fromValue = 0.0
        fade.toValue = 1.0
        fade.fillMode = .both
        fade.timingFunction = CAMediaTimingFunction(name: .easeIn)
        left1.add(fade, forKey: nil)
        
        let delay: TimeInterval = 0.2
        fade.beginTime = CACurrentMediaTime() + delay
        left2.add(fade, forKey: nil)
        
        fade.beginTime = CACurrentMediaTime() + delay * 2.0
        right1.add(fade, forKey: nil)
        
        fade.beginTime = CACurrentMediaTime() + delay * 3.0
        fade.setValue("end", forKey: "fade")
        fade.delegate = self
        right2.add(fade, forKey: nil)
    }
    
    func animateHopWith(delay: TimeInterval) {
        guard let left1 = self.animationLayers.first as? CAShapeLayer,
            let left2 = self.animationLayers[1] as? CAShapeLayer,
            let right1 = self.animationLayers[2] as? CAShapeLayer,
            let right2 = self.animationLayers.last as? CAShapeLayer else {
                return
        }
        
        animateHop(layer: left1, delay: delay, value: "0")
        animateHop(layer: left2, delay: delay + self.duration * 0.2, value: "1")
        animateHop(layer: right1, delay: delay + self.duration * 0.4, value: "2")
        animateHop(layer: right2, delay: delay + self.duration * 0.6, value: "3")
    }
    
    func animateHop(layer: CAShapeLayer, delay: TimeInterval, value: String) {
        let offset: CGFloat = self.frame.height / 2 - self.borderWidth - self.circleRadius - 5.0
        let animation =  CAKeyframeAnimation(keyPath: "position.y")
        animation.values = [layer.frame.origin.y, layer.frame.origin.y - offset, layer.frame.origin.y]
        animation.keyTimes = [0.0, 0.5, 1.0]
        
        let color = CAKeyframeAnimation(keyPath: "fillColor")
        color.values = [UIColor.white.cgColor, UIColor.red.cgColor, UIColor.white.cgColor]
        color.keyTimes = [0.0, 0.5, 1.0]
        
        let group = CAAnimationGroup()
        group.animations = [color, animation]
        group.beginTime = CACurrentMediaTime() + delay
        group.duration = self.duration
        group.setValue(value, forKey: "animation")
        group.setValue(layer, forKey: "layer")
        group.delegate = self
        layer.add(group, forKey: nil)
    }
    
    func getCircleLayer(rect: CGRect) -> CAShapeLayer {
        let layer = CAShapeLayer()
        layer.path = UIBezierPath(ovalIn: rect).cgPath
        layer.fillColor = UIColor.white.cgColor
        return layer
    }
    
    public override func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        
        if let value = anim.value(forKey: "fade") as? String, value == "end" {
            self.animateHopWith(delay: 0.0)
        } else if let value = anim.value(forKey: "animation") as? String, value == "3" {
            self.animateHopWith(delay: 0.0)
        }
        
    }
}
