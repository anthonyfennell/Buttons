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
        if config.shadowed {
            let shadowRect = getShadowRect(bounds: bounds)
            drawShadowGradientIn(context: context, bounds: bounds, config: config)
            //drawShadowImageIn(context: context, bounds: shadowRect, borderWidth: borderWidth, cornerRadius: cornerRadius)
        }
        let rect = config.shadowed ? getRect(bounds: bounds) : bounds
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
        let rect = config.shadowed ? getRect(bounds: bounds) : bounds
//        if shadowed {
//            rect = getShadowRect(bounds: bounds)
//        }
        drawButtonIn(context: context, bounds: rect, config: config)
    }

    // MARK: - Draw Background
    func drawShadowImageIn(context: CGContext, bounds: CGRect, config: ButtonConfig) {
        context.setStrokeColor(UIColor(hex: 0xD0D0D0).cgColor)
        context.setLineWidth(config.borderWidth)
        context.setFillColor(UIColor(hex: 0xD0D0D0).cgColor)
        context.beginPath()
        context.addPath(getPath(bounds: bounds, borderWidth: config.borderWidth, cornerRadius: config.cornerRadius).cgPath)
        context.drawPath(using: .fillStroke)
    }
    
    func drawButtonIn(context: CGContext, bounds: CGRect, config: ButtonConfig) {
        context.setStrokeColor(config.borderColor.cgColor)
        context.setLineWidth(config.borderWidth)
        context.setFillColor(config.backgroundColor.cgColor)
        context.beginPath()
        context.addPath(getPath(bounds: bounds, borderWidth: config.borderWidth, cornerRadius: config.cornerRadius).cgPath)
        context.closePath()
        if config.isBackgroundFilled {
            context.drawPath(using: .fillStroke)
        } else {
            context.drawPath(using: .stroke)
        }
    }
    
    func drawShadowGradientIn(context: CGContext, bounds: CGRect, config: ButtonConfig) {
        let path = getPath(bounds: bounds, borderWidth: config.borderWidth, cornerRadius: config.cornerRadius)
        context.saveGState()
        path.addClip()
        let colors = [UIColor(hex: 0xF0F0F0).cgColor, UIColor(hex: 0xD0D0D0).cgColor]
        guard let gradient = CGGradient(colorsSpace: nil, colors: colors as CFArray, locations: nil) else { return }
        context.drawLinearGradient(gradient, start: bounds.origin, end: CGPoint(x: bounds.maxX, y: bounds.maxY), options: [])
        context.restoreGState()
    }
    
    // MARK: - Draw String
    func drawTitleIn(context: CGContext, text: String, bounds: CGRect, fontSize: CGFloat, color: UIColor) {
        let nsString = text as NSString
        let attributes: [NSAttributedString.Key: Any] = [
            NSAttributedString.Key.foregroundColor: color,
            NSAttributedString.Key.font: UIFont.systemFont(ofSize: fontSize)
        ]
        nsString.draw(in: bounds, withAttributes: attributes)
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
    
    func getRect(bounds: CGRect) -> CGRect {
        //let offsetX: CGFloat = 4
        //let offsetY: CGFloat = 4
        //let slice = bounds.divided(atDistance: offsetX, from: .minXEdge).remainder
        //return slice.divided(atDistance: offsetY, from: .maxYEdge).remainder
        return bounds.inset(by: UIEdgeInsets(top: 3, left: 3, bottom: 3, right: 3))
    }
    
    func getShadowRect(bounds: CGRect) -> CGRect {
        //let offsetX: CGFloat = 4
        //let offsetY: CGFloat = 4
        //let slice = bounds.divided(atDistance: offsetY, from: .minYEdge).remainder
        //return slice.divided(atDistance: offsetX, from: .maxXEdge).remainder
        return bounds
    }
    
}
