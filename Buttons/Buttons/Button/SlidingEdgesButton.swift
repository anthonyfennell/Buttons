//
//  SlidingEdgesButton.swift
//  ButtonPlay
//
//  Created by Anthony Fennell on 1/25/19.
//  Copyright © 2019 Anthony Fennell. All rights reserved.
//

import UIKit

public class SlidingEdgesButton: DefaultButton {
    public override func configure() {
        super.configure()
        self.drawable = SlidingEdgeButtonDrawable()
    }
}

struct SlidingEdgeButtonDrawable: Drawable {
    func getPath(bounds: CGRect, borderWidth: CGFloat, cornerRadius: CGFloat) -> UIBezierPath {
        let path = UIBezierPath()
        let left = bounds.minX + borderWidth / 2
        let right = bounds.maxX - borderWidth / 2
        let top = bounds.minY + borderWidth / 2
        let bottom = bounds.maxY - borderWidth / 2
        let edgeOffset = bounds.maxX > bounds.maxY ? bounds.maxY * 0.15 : bounds.maxX * 0.15
        path.lineWidth = borderWidth
        
        let startPoint = CGPoint(x: left, y: top + edgeOffset)
        path.move(to: startPoint)
        path.addLine(to: CGPoint(x: left + edgeOffset, y: top)) // top left edge
        path.addLine(to: CGPoint(x: right - edgeOffset, y: top)) // top
        path.addLine(to: CGPoint(x: right, y: top + edgeOffset)) // top right edge
        path.addLine(to: CGPoint(x: right, y: bottom - edgeOffset)) // right
        path.addLine(to: CGPoint(x: right - edgeOffset, y: bottom)) // bottom right edge
        path.addLine(to: CGPoint(x: left + edgeOffset, y: bottom)) // bottom
        path.addLine(to: CGPoint(x: left, y: bottom - edgeOffset)) // left
        path.addLine(to: startPoint)
        return path
    }
}
