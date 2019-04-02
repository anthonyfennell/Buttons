//
//  LoadingEdgeButton.swift
//  Buttons
//
//  Created by Anthony Fennell on 4/1/19.
//  Copyright © 2019 Anthony Fennell. All rights reserved.
//

import Foundation

public class LoadingEdgeButton: LoadingButton {
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
        animateStrokeEnd(layer: layer, value: "counter", delay: delay, start: 1.0, end: 0.0)
    }
    
    func addLayer(clockwise: Bool) -> CAShapeLayer {
        let layer = CAShapeLayer()
        layer.path = self.drawable.getPath(bounds: self.bounds, borderWidth: self.borderWidth, cornerRadius: self.cornerRadius).cgPath
        layer.lineWidth = self.borderWidth
        layer.lineCap = .round
        layer.strokeColor = self.borderColor.cgColor
        layer.fillColor = nil
        self.layer.addSublayer(layer)
        self.animationLayers.append(layer)
        return layer
    }
    
    func animateStrokeEnd(layer: CAShapeLayer, value: String, delay: TimeInterval, start: CGFloat = 0.0, end: CGFloat = 1.0) {
        let stroke: CABasicAnimation = CABasicAnimation(keyPath: "strokeEnd")
        stroke.fromValue = start
        stroke.toValue = end
        stroke.duration = 1.5
        stroke.fillMode = .backwards
        stroke.timingFunction = CAMediaTimingFunction(name: .easeIn)
        stroke.beginTime = delay
        stroke.setValue(value, forKey: "end")
        stroke.setValue(layer, forKey: "layer")
        stroke.delegate = self
        layer.add(stroke, forKey: nil)
    }
    
    func animateStrokeStart(layer: CAShapeLayer, value: String, delay: TimeInterval, start: CGFloat = 0.0, end: CGFloat = 1.0) {
        let strokeStart: CABasicAnimation = CABasicAnimation(keyPath: "strokeStart")
        strokeStart.fromValue = start
        strokeStart.toValue = end
        strokeStart.duration = 1.5
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
                self.animateStrokeStart(layer: layer, value: "clockwise", delay: CACurrentMediaTime())
            } else if value == "counter" {
                self.animateStrokeStart(layer: layer, value: "counter", delay: CACurrentMediaTime(), start: 1.0, end: 0.0)
            }
        }
    }
}
