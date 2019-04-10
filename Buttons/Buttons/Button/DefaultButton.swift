//
//  DefaultButton.swift
//  ButtonPlay
//
//  Created by Anthony Fennell on 1/24/19.
//  Copyright © 2019 Anthony Fennell. All rights reserved.
//

import UIKit

public class DefaultButton: UIButton, CAAnimationDelegate {
    
    public var buttonColor: UIColor = ColorHex.orange3.color {
        didSet {
            setNeedsBackgroundRedraw()
        }
    }
    
    public var borderColor: UIColor = ColorHex.orange5.color {
        didSet {
            setNeedsBackgroundRedraw()
        }
    }
    
    public var highlightColor: UIColor = ColorHex.orange5.color {
        didSet {
            setNeedsBackgroundRedraw()
        }
    }
    
    public var disabledColor: UIColor = ColorHex.orange3.color.withAlphaComponent(0.35) {
        didSet {
            setNeedsBackgroundRedraw()
        }
    }
    
    public var isShadowed: Bool = false {
        didSet {
            updateShadowLayer()
        }
    }
    
    public var isBackgroundFilled: Bool = true {
        didSet {
            setNeedsBackgroundRedraw()
        }
    }
    
    public var isGradientEnabled: Bool = false {
        didSet {
            setNeedsBackgroundRedraw()
        }
    }
    
    public var cornerRadius: CGFloat = 0 {
        didSet {
            setNeedsBackgroundRedraw()
        }
    }
    
    public var borderWidth: CGFloat = 2.0 {
        didSet {
            setNeedsBackgroundRedraw()
        }
    }
    
    public var isHapticEnabled: Bool = false
    var drawable: Drawable = ButtonDrawable()
    private var lastImageSize: CGSize = CGSize.zero
    
    
    // MARK: - Initializers
    public override func awakeFromNib() {
        super.awakeFromNib()
        configure()
    }
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        configure()
    }
    
    public func configure() {
        updateTitleColor()
        self.addTarget(self, action: #selector(touchUpInsideEvent), for: .touchUpInside)
        self.addTarget(self, action: #selector(animateScaleDown), for: .touchDown)
        self.addTarget(self, action: #selector(animateScaleDown), for: .touchDragEnter)
        self.addTarget(self, action: #selector(animateToIdentity), for: .touchCancel)
        self.addTarget(self, action: #selector(animateToIdentity), for: .touchDragExit)
    }
    
    // MARK: - Redraw Images
    public func setNeedsBackgroundRedraw() {
        lastImageSize = CGSize.zero
        setNeedsLayout()
        updateTitleColor()
    }
    
    public func updateTitleColor() {
        setTitleColor(UIColor.white, for: .normal)
        setTitleColor(UIColor.white, for: .highlighted)
        setTitleColor(UIColor.white, for: .disabled)
    }
    
    func updateShadowLayer() {
        if self.isShadowed {
            self.layer.shadowPath = self.drawable.getPath(bounds: self.bounds, borderWidth: self.borderWidth, cornerRadius: self.cornerRadius).cgPath
            self.layer.shadowOpacity = 0.6 // Higher the value harder to see the shadow
            self.layer.shadowColor = self.buttonColor.cgColor
            self.layer.shadowRadius = 3.0 // Higher the value the more blur
            self.layer.shadowOffset = CGSize(width: 2.0, height: 2.0) // Offset in points. Sending to bottom right corner
        } else {
            self.layer.shadowPath = nil
        }
    }
    
    // MARK: - Draw Image
    public override func layoutSubviews() {
        super.layoutSubviews()
        redrawImagesIfNeeded()
    }
    
    func redrawImagesIfNeeded() {
        let currentSize: CGSize = bounds.size
        if lastImageSize.width != currentSize.width || lastImageSize.height != currentSize.height {
            lastImageSize = currentSize
            updateBackgroundImages()
        }
    }
    
    func updateBackgroundImages() {
        let normalImage = getNormalImage(size: lastImageSize)
        let highlightedImage = getHighlightedImage(size: lastImageSize)
        let disabledImage = getDisabledImage(size: lastImageSize)
        setBackgroundImage(normalImage, for: .normal)
        setBackgroundImage(highlightedImage, for: .highlighted)
        setBackgroundImage(disabledImage, for: .disabled)
    }
    
    // MARK: - Image types
    func getNormalImage(size: CGSize) -> UIImage {
        let config = getButtonConfig(for: .normal, size: size)
        return drawable.buttonNormalImage(with: config)
    }
    
    func getHighlightedImage(size: CGSize) -> UIImage {
        let config = getButtonConfig(for: .highlighted, size: size)
        return drawable.buttonHighlightedImage(with: config)
    }
    
    func getDisabledImage(size: CGSize) -> UIImage {
        let config = getButtonConfig(for: .disabled, size: size)
        return drawable.buttonNormalImage(with: config)
    }
    
    // MARK: - Button Config
    func getButtonConfig(for state: UIControl.State, size: CGSize) -> ButtonConfig {
        let borderColor: UIColor
        let backgroundColor: UIColor
        let isBackgroundFilled: Bool
        switch state {
        case .normal:
            borderColor = self.borderColor
            backgroundColor = self.buttonColor
            isBackgroundFilled = self.isBackgroundFilled
        case .highlighted:
            borderColor = self.borderColor
            backgroundColor = self.highlightColor
            // isBackgroundFilled is true here in order to fill the background
            // for highlighted BorderButtons
            //isBackgroundFilled = true
            
            // Have no background fill for highlight for a border button
            isBackgroundFilled = self.isBackgroundFilled
        case .disabled:
            borderColor = self.borderColor.withAlphaComponent(0.35)
            backgroundColor = self.disabledColor
            isBackgroundFilled = self.isBackgroundFilled
            
        default:
            borderColor = self.borderColor
            backgroundColor = self.buttonColor
            isBackgroundFilled = self.isBackgroundFilled
        }
        
        let config = ButtonConfig(size: size,
                                  borderWidth: self.borderWidth,
                                  cornerRadius: self.cornerRadius,
                                  isShadowed: self.isShadowed,
                                  isBackgroundFilled: isBackgroundFilled,
                                  isGradientEnabled: self.isGradientEnabled,
                                  borderColor: borderColor,
                                  backgroundColor: backgroundColor)
        return config
    }
    
    // MARK: - Tappable Point
    public override func point(inside point: CGPoint, with event: UIEvent?) -> Bool {
        let path = self.drawable.getPath(bounds: self.bounds, borderWidth: borderWidth, cornerRadius: cornerRadius)
        return path.contains(point) && super.point(inside: point, with: event)
    }
    
    // MARK: - Touch Animations
    @objc
    public func touchUpInsideEvent() {
        if self.isHapticEnabled {
            let impact = UIImpactFeedbackGenerator()
            impact.impactOccurred()
        }
        
        self.transform = .identity
        let bounce = CASpringAnimation(keyPath: "transform.scale")
        bounce.fromValue = 0.85
        bounce.toValue = 1.0
        bounce.initialVelocity = 1.0 // default 0
        //bounce.damping = 1.0 // default 1.0
        bounce.stiffness = 500.0 // default 100.0
        bounce.mass = 0.5 // Default 1.0
        bounce.duration = bounce.settlingDuration //0.22
        bounce.setValue("bounce", forKey: "animation")
        bounce.delegate = self
        self.layer.add(bounce, forKey: nil)
    }
    
    @objc
    public func animateScaleDown() {
        let animator = UIViewPropertyAnimator(duration: 0.15, curve: .linear) {
            self.transform = CGAffineTransform(scaleX: 0.95, y: 0.95)
        }
        animator.startAnimation()
    }
    
    @objc
    public func animateToIdentity() {
        let animator = UIViewPropertyAnimator(duration: 0.15, curve: .linear) {
            self.transform = .identity
        }
        animator.startAnimation()
    }
    
    // MARK: - CAAnimationDelegate
    public func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        if let value = anim.value(forKey: "animation") as? String, value == "bounce" {
            self.touchUpInsideAnimationDidEnd()
        }
    }
    
    public func touchUpInsideAnimationDidEnd() {
        // Could remove this if we will not override
        // When overriding and adding a loading animation here,
        // the animation doesn't quite start right after the bounce
    }
}

struct ButtonDrawable: Drawable {
    func getPath(bounds: CGRect, borderWidth: CGFloat, cornerRadius: CGFloat) -> UIBezierPath {
        if cornerRadius == 0 {
            return getDefaultPath(bounds: bounds, borderWidth: borderWidth, cornerRadius: cornerRadius)
        } else {
            return getCornerRadiusPath(bounds: bounds, borderWidth: borderWidth, cornerRadius: cornerRadius)
        }
    }
    
    func getDefaultPath(bounds: CGRect, borderWidth: CGFloat, cornerRadius: CGFloat) -> UIBezierPath {
        let path = UIBezierPath()
        let left = bounds.minX
        let right = bounds.maxX
        let top = bounds.minY
        let bottom = bounds.maxY
        path.lineWidth = borderWidth
        
        path.move(to: CGPoint(x: left, y: top));
        path.addLine(to: CGPoint(x: right, y: top));
        path.addLine(to: CGPoint(x: right, y: bottom))
        path.addLine(to: CGPoint(x: left, y: bottom))
        path.addLine(to: CGPoint(x: left, y: top))
        return path
    }
    
    func getCornerRadiusPath(bounds: CGRect, borderWidth: CGFloat, cornerRadius: CGFloat) -> UIBezierPath {
        let path = UIBezierPath()
        let left = bounds.minX
        let right = bounds.maxX
        let top = bounds.minY
        let bottom = bounds.maxY
        let radius = cornerRadius
        
        path.move(to: CGPoint(x: (left + radius), y: top));
        path.addLine(to: CGPoint(x: right - radius, y: top));
        var x = right - radius
        var y = top + radius
        path.addArc(withCenter: CGPoint(x: x, y: y), radius: radius, startAngle: 3 * .pi / 2, endAngle: 0, clockwise: true) // top right corner
        path.addLine(to: CGPoint(x: right, y: bottom - radius))
        y = bottom - radius
        path.addArc(withCenter: CGPoint(x: x, y: y), radius: radius, startAngle: 0, endAngle: .pi / 2, clockwise: true) // bottom right corner
        path.addLine(to: CGPoint(x: left + radius, y: bottom))
        x = left + radius
        path.addArc(withCenter: CGPoint(x: x, y: y), radius: radius, startAngle: .pi / 2, endAngle: .pi, clockwise: true) // bottom left corner
        path.addLine(to: CGPoint(x: left, y: top + radius))
        y = top + radius
        path.addArc(withCenter: CGPoint(x: x, y: y), radius: radius, startAngle: .pi, endAngle: 3 * .pi / 2, clockwise: true) // top left corner
        return path
    }
}
