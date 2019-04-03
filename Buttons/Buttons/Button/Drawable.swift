//
//  Drawable.swift
//  ButtonPlay
//
//  Created by Anthony Fennell on 1/24/19.
//  Copyright © 2019 Anthony Fennell. All rights reserved.
//

import UIKit

protocol Drawable {
    func getPath(bounds: CGRect, borderWidth: CGFloat, cornerRadius: CGFloat) -> UIBezierPath
}

extension Drawable {
    
    // MARK: - Draw Normal Image
    func buttonNormalImage(with config: ButtonConfig) -> UIImage {
        let context = beginImageContext(size: config.size)
        let bounds = CGRect(origin: CGPoint.zero, size: config.size)
        drawNormalImageIn(context: context, bounds: bounds, config: config)
        return endImageContext()
    }
    
    func drawNormalImageIn(context: CGContext, bounds: CGRect, config: ButtonConfig) {
        let rect = bounds
        drawButtonIn(context: context, bounds: rect, config: config)
    }
    
    // MARK: - Draw Highlighted Image
    func buttonHighlightedImage(with config: ButtonConfig) -> UIImage {
        let context = beginImageContext(size: config.size)
        let bounds = CGRect(origin: CGPoint.zero, size: config.size)
        drawHighlightedImageIn(context: context, bounds: bounds, config: config)
        return endImageContext()
    }
    
    func drawHighlightedImageIn(context: CGContext, bounds: CGRect, config: ButtonConfig) {
        let rect = bounds
        drawButtonIn(context: context, bounds: rect, config: config)
    }

    // MARK: - Draw Background
    func drawButtonIn(context: CGContext, bounds: CGRect, config: ButtonConfig) {
        context.setStrokeColor(config.borderColor.cgColor)
        context.setLineWidth(config.borderWidth)
        let fillColor = config.isBackgroundGradient ? UIColor.clear.cgColor : config.backgroundColor.cgColor
        context.setFillColor(fillColor)
        
        context.beginPath()
        let path = getPath(bounds: bounds, borderWidth: config.borderWidth, cornerRadius: config.cornerRadius)
        path.addClip()
        context.addPath(path.cgPath)
        context.closePath()
        
        if config.isBackgroundFilled {
            context.drawPath(using: .fillStroke)
        } else {
            context.drawPath(using: .stroke)
        }
        
        if config.isBackgroundGradient {
            let lightColor = config.backgroundColor.withAlphaComponent(0.5).cgColor
            let darkColor = config.backgroundColor.cgColor
            let colors = [lightColor, darkColor, darkColor, darkColor, lightColor]
            let colorSpace = CGColorSpaceCreateDeviceRGB()
            let locations: [CGFloat] = [0.0, 0.4, 0.5, 0.6, 1.0]
            let gradient = CGGradient(colorsSpace: colorSpace, colors: colors as CFArray, locations: locations)!
            let startPoint = CGPoint.zero
            let endPoint = CGPoint(x: 0, y: bounds.height)
            context.drawLinearGradient(gradient, start: startPoint, end: endPoint, options: [])
        }
    }
    
    // MARK: - Helpers
    func beginImageContext(size: CGSize) -> CGContext {
        UIGraphicsBeginImageContextWithOptions(size, false, 0)
        return UIGraphicsGetCurrentContext()!
    }
    
    func endImageContext() -> UIImage {
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image!
    }
    
}
