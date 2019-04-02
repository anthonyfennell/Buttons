//
//  LoadingButton.swift
//  ButtonPlay
//
//  Created by Anthony Fennell on 3/15/19.
//  Copyright © 2019 Anthony Fennell. All rights reserved.
//


// Idea here is that after the button is selected,
// then a loading animation starts

// 1. Could be a constent line rotating around the border
// 2. Could turn into a circle loading indicator (designed by me)

import UIKit

public class LoadingButton: DefaultButton {
    public var animationLayers: [CALayer] = []
    
    public override func animateTouch() {
        super.animateTouch()
        self.isEnabled = false
        animateLoading()
    }
    
    public func animateLoading() {
        
    }
    
    public func stopLoadingAnimation() {
        self.isEnabled = true
        for layer in self.animationLayers {
            layer.removeFromSuperlayer()
        }
        self.animationLayers.removeAll()
    }

}
