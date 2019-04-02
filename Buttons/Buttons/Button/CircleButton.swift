//
//  CircleButton.swift
//  ButtonPlay
//
//  Created by Anthony Fennell on 1/25/19.
//  Copyright © 2019 Anthony Fennell. All rights reserved.
//

import UIKit

public class CircleButton: DefaultButton {
    public override func configure() {
        super.configure()
        self.drawable = CircleButtonDrawable()
    }
}

struct CircleButtonDrawable: Drawable {
    func getPath(bounds: CGRect, borderWidth: CGFloat, cornerRadius: CGFloat) -> UIBezierPath {
        let path = UIBezierPath()
        let halfBorderWidth = borderWidth / 2
        let width = bounds.width
        let height = bounds.height
        let radius = bounds.maxX < bounds.maxY ? width / 2 - halfBorderWidth : height / 2 - halfBorderWidth
        let right = bounds.midX + radius - halfBorderWidth
        path.lineWidth = borderWidth
        
        let startPoint = CGPoint(x: right, y: bounds.midY)
        let center = CGPoint(x: bounds.origin.x + width / 2, y: bounds.origin.y + height / 2)
        path.move(to: startPoint)
        path.addArc(withCenter: center, radius: radius, startAngle: 0, endAngle: 2 * .pi, clockwise: true)
        return path
    }
}
