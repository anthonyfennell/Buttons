//
//  LoadingGradientButton.swift
//  Buttons
//
//  Created by Anthony Fennell on 3/27/19.
//  Copyright © 2019 Anthony Fennell. All rights reserved.
//

import UIKit

public class LoadingGradientButton: LoadingButton {
    private var title: String?
    
    public override  func animateLoading() {
        title = self.title(for: .normal)
        self.setTitle(nil, for: .normal)
        
        let gradientLayer = getGradientLayer()
        let maskLayer = getMaskLayer()
        self.layer.addSublayer(gradientLayer)
        gradientLayer.mask = maskLayer

        self.animationLayers.append(gradientLayer)
        
        let animation = CABasicAnimation(keyPath: "locations")
        // push colors to the left
        animation.fromValue = [0.0, 0.0, 0.25]
        // push colors to the right
        animation.toValue = [0.75, 1.0, 1.0]
        animation.duration = 3.0
        animation.repeatCount = .infinity
        gradientLayer.add(animation, forKey: nil)
    }
    
    public override func stopLoadingAnimation() {
        super.stopLoadingAnimation()
        self.setTitle(title, for: .normal)
    }
    
    func getGradientLayer() -> CAGradientLayer {
        let gradientLayer = CAGradientLayer()
        
        // Configure the gradient here
        gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.5)
        gradientLayer.endPoint = CGPoint(x: 1.0, y: 0.5)
        let colors = [
            self.borderColor.withAlphaComponent(0.75).cgColor,
            self.buttonColor.withAlphaComponent(0.55).cgColor,
            self.borderColor.withAlphaComponent(0.55).cgColor
        ]
        gradientLayer.colors = colors
        
        let locations: [NSNumber] = [
            0.25,
            0.5,
            0.75
        ]
        gradientLayer.locations = locations
        gradientLayer.frame = CGRect(x: -bounds.size.width,
                                     y: bounds.origin.y,
                                     width: 3 * bounds.size.width,
                                     height: bounds.size.height)
        
        return gradientLayer
    }
    
    func getMaskLayer() -> CAShapeLayer {
        let text = "Loading"
        let image = UIGraphicsImageRenderer(size: bounds.size).image { (_) in
            // Used for animating text with a gradient
            text.draw(in: bounds, withAttributes: textAttributes)
        }
        
        let maskLayer = CAShapeLayer()
        maskLayer.backgroundColor = UIColor.clear.cgColor
        maskLayer.frame = self.bounds.offsetBy(dx: bounds.size.width, dy: 0)
        maskLayer.path = UIBezierPath(rect: self.bounds.inset(by: UIEdgeInsets(top: 3, left: 3, bottom: 3, right: 3))).cgPath
        maskLayer.contents = image.cgImage
        return maskLayer
    }
    
    let textAttributes: [NSAttributedString.Key: Any] = {
        let style = NSMutableParagraphStyle()
        style.alignment = .center
        return [.font: UIFont(name: "HelveticaNeue-Thin", size: 28.0)!, .paragraphStyle: style]
    }()
}
