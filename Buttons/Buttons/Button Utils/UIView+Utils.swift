//
//  UIView+Utils.swift
//  ButtonPlay
//
//  Created by Anthony Fennell on 3/16/19.
//  Copyright © 2019 Anthony Fennell. All rights reserved.
//

import UIKit

extension UIView {
    func animateHopPath() {
        //let path = self.getHopPath()
        let circlePath = self.getCirclePath(radius: 5)
        
        let layer = CAShapeLayer()
        layer.path = circlePath.cgPath
        layer.fillColor = ColorHex.pink4.color.cgColor
        self.layer.addSublayer(layer)
        
        let animation = CAKeyframeAnimation(keyPath: "position.y")
        animation.repeatCount = .infinity
        animation.duration = 2.0
        animation.values = [self.bounds.maxY, -90, -100, -90, self.bounds.maxY]
        animation.keyTimes = [0, 0.45, 0.5, 0.55, 1.0]
        animation.isAdditive = true
        layer.add(animation, forKey: "bounce")
    }
    
    func animateStrokePath(_ path: UIBezierPath) {
        let layer = CAShapeLayer()
        layer.path = path.cgPath
        layer.strokeEnd = 0
        layer.lineWidth = 1
        layer.strokeColor = ColorHex.black4.color.cgColor
        layer.fillColor = UIColor.clear.cgColor
        self.layer.addSublayer(layer)
        
        let animation = CABasicAnimation(keyPath: "strokeEnd")
        animation.toValue = 1
        animation.duration = 2
        animation.autoreverses = false
        animation.repeatCount = .infinity
        layer.add(animation, forKey: "line")
    }
    
    func animateAroundPath(_ path: UIBezierPath) {
        let circlePath = getCirclePath(radius: 4.0)
        let layer = CAShapeLayer()
        layer.path = circlePath.cgPath
        layer.fillColor = ColorHex.pink3.color.cgColor
        self.layer.addSublayer(layer)
        
        let animation = CAKeyframeAnimation(keyPath: "position")
        animation.path = path.cgPath
        animation.rotationMode = CAAnimationRotationMode.rotateAuto
        animation.speed = 1
        animation.duration = 1
        animation.repeatCount = .infinity
        animation.calculationMode = CAAnimationCalculationMode.paced
        layer.add(animation, forKey: "loading_animation")
    }
    
    func getCirclePath(radius: CGFloat) -> UIBezierPath {
        let path = UIBezierPath()
        path.addArc(withCenter: CGPoint(x: radius, y: radius), radius: radius, startAngle: 0, endAngle: CGFloat.pi * 2, clockwise: true)
        return path
    }
    
    func getLinePath(width: CGFloat, length: CGFloat) -> UIBezierPath {
        let path = UIBezierPath()
        path.move(to: CGPoint.zero)
        path.addLine(to: CGPoint(x: length, y: 0))
        path.addLine(to: CGPoint(x: length, y: width))
        path.addLine(to: CGPoint(x: 0, y: width))
        path.close()
        return path
    }
    
    func getHopPath() -> UIBezierPath {
        let path = UIBezierPath()
        let x = self.bounds.maxX / 2
        path.move(to: CGPoint(x: x, y: self.bounds.maxY))
        path.move(to: CGPoint(x: x, y: 0))
        path.move(to: CGPoint(x: x, y: self.bounds.maxY))
        return path
    }
    
    
    
    func foo() {
        let width: CGFloat = 3
        
        let replicatorLayer = CAReplicatorLayer()
        replicatorLayer.frame.size = self.frame.size
        replicatorLayer.masksToBounds = true
        self.layer.addSublayer(replicatorLayer)
        
        // add shape or image to replicator layer
        let squareLayer = getSquareLayer()
        replicatorLayer.addSublayer(squareLayer)
        let instanceCount = self.frame.width / width / 2
        replicatorLayer.instanceCount = Int(ceil(instanceCount))
        
        // Shift each instance
        replicatorLayer.instanceTransform = CATransform3DMakeTranslation(width * 2, 0, 0)
        // Reduce the red & green color component of each instance,
        // effectively making each copy more and more blue
        let colorOffset = -1 / Float(replicatorLayer.instanceCount)
        replicatorLayer.instanceRedOffset = colorOffset
        replicatorLayer.instanceGreenOffset = colorOffset
        
        
        let verticalReplicatorLayer = CAReplicatorLayer()
        verticalReplicatorLayer.frame.size = self.frame.size
        verticalReplicatorLayer.masksToBounds = true
        verticalReplicatorLayer.instanceBlueOffset = colorOffset
        self.layer.addSublayer(verticalReplicatorLayer)
        let verticalInstanceCount = self.frame.height / width / 2
        verticalReplicatorLayer.instanceCount = Int(verticalInstanceCount)
        verticalReplicatorLayer.instanceTransform = CATransform3DMakeTranslation(0, width * 2, 0)
        verticalReplicatorLayer.addSublayer(replicatorLayer)
        
        // Animation delay
        let delay = TimeInterval(0.1)
        replicatorLayer.instanceDelay = delay
        verticalReplicatorLayer.instanceDelay = delay
        
        let animation = CABasicAnimation(keyPath: "transform.scale")
        animation.duration = 2
        animation.fromValue = 0.1
        animation.toValue = 1
        animation.autoreverses = false
        animation.repeatCount = .infinity
        squareLayer.add(animation, forKey: "hypnoscale")
    }
    
    func getSquareLayer() -> CAShapeLayer {
        let layer = CAShapeLayer()
        let path = UIBezierPath(rect: CGRect(x: 0, y: 0, width: 3, height: 3))
        layer.path = path.cgPath
        layer.fillColor = UIColor.black.cgColor
        return layer
    }
}
