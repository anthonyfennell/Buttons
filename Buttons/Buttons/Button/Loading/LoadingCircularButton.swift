//
//  LoadingCircularButton.swift
//  Buttons
//
//  Created by Anthony Fennell on 3/31/19.
//  Copyright © 2019 Anthony Fennell. All rights reserved.
//

import Foundation

public class LoadingCircularButton: LoadingButton {
    private var animating: Bool = false

    public override func animateTouch() {
        super.animateTouch()
        self.animating = true
    }
    
    public override func stopLoadingAnimation() {
        super.stopLoadingAnimation()
        self.animating = false
    }
    
    public override func animateLoading() {
        animateClockwise(delay: CACurrentMediaTime())
    }
    
    func animateClockwise(delay: TimeInterval) {
        let layer = addLayer(clockwise: true)
        animateStrokeEnd(layer: layer, value: "clockwise", delay: delay)
    }
    
    func animateCounter(delay: TimeInterval) {
        let layer = addLayer(clockwise: false)
        animateStrokeEnd(layer: layer, value: "counter", delay: delay)
    }
    
    func addLayer(clockwise: Bool) -> CAShapeLayer {
        let layer = CAShapeLayer()
        layer.path = self.getCirclePath(clockwise: clockwise)
        layer.lineWidth = 2.0
        layer.lineCap = .round
        layer.strokeColor = UIColor.white.cgColor
        layer.fillColor = nil
        self.layer.addSublayer(layer)
        self.animationLayers.append(layer)
        return layer
    }
    
    func getCirclePath(clockwise: Bool) -> CGPath {
        let labelEnd = self.titleLabel!.frame.origin.x + self.titleLabel!.frame.width
        
        let width = self.frame.size.width
        let height = self.frame.size.height
        let circleWidth = self.frame.size.width - labelEnd
        let offset: CGFloat = 5.0
        let radius: CGFloat
        
        if circleWidth < height {
            radius = (circleWidth - offset * 2 - self.borderWidth) / 2.0
        } else {
            radius = (height - offset * 2 - self.borderWidth * 2) / 2.0
        }
        
        let centerX: CGFloat = width - self.borderWidth - offset - radius
        let centerY: CGFloat = height / 2.0
        let startAngle: CGFloat = clockwise ? -.pi / 2 : 3 * .pi / 2
        let endAngle: CGFloat = clockwise ? 3 * .pi / 2 : -.pi / 2
        let path = UIBezierPath(arcCenter: CGPoint(x: centerX, y: centerY),
                                         radius: radius,
                                         startAngle: startAngle,
                                         endAngle: endAngle,
                                         clockwise: clockwise)
        return path.cgPath
    }
    
    func animateStrokeEnd(layer: CAShapeLayer, value: String, delay: TimeInterval) {
        let stroke: CABasicAnimation = CABasicAnimation(keyPath: "strokeEnd")
        stroke.fromValue = 0.0
        stroke.toValue = 1.0
        stroke.duration = 0.6
        stroke.fillMode = .backwards
        stroke.timingFunction = CAMediaTimingFunction(name: .easeIn)
        stroke.beginTime = delay
        stroke.setValue(value, forKey: "end")
        stroke.setValue(layer, forKey: "layer")
        stroke.delegate = self
        layer.add(stroke, forKey: nil)
    }
    
    func animateStrokeStart(layer: CAShapeLayer, value: String) {
        let strokeStart: CABasicAnimation = CABasicAnimation(keyPath: "strokeStart")
        strokeStart.fromValue = 0.0
        strokeStart.toValue = 1.0
        strokeStart.duration = 0.6
        strokeStart.fillMode = .backwards
        strokeStart.timingFunction = CAMediaTimingFunction(name: .easeOut)
        strokeStart.setValue(value, forKey: "start")
        strokeStart.setValue(layer, forKey: "layer")
        strokeStart.delegate = self
        layer.add(strokeStart, forKey: nil)
    }
    
    override public func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        super.animationDidStop(anim, finished: flag)
        
        guard self.animating else {
            self.animationLayers.removeAll()
            return
        }
        
        if let value = anim.value(forKey: "start") as? String, let layer = anim.value(forKey: "layer") as? CAShapeLayer {
            if value == "clockwise" {
                layer.removeFromSuperlayer()
                self.animationLayers.removeAll()
                animateCounter(delay: CACurrentMediaTime() + 0.4)
            } else if value == "counter" {
                layer.removeFromSuperlayer()
                self.animationLayers.removeAll()
                animateClockwise(delay: CACurrentMediaTime() + 0.4)
            }
        } else if let value = anim.value(forKey: "end") as? String, let layer = anim.value(forKey: "layer") as? CAShapeLayer {
            if value == "clockwise" {
                self.animateStrokeStart(layer: layer, value: "clockwise")
            } else if value == "counter" {
                self.animateStrokeStart(layer: layer, value: "counter")
            }
        }
    }
    
}
