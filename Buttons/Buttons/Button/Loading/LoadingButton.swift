//
//  LoadingButton.swift
//  ButtonPlay
//
//  Created by Anthony Fennell on 3/15/19.
//  Copyright © 2019 Anthony Fennell. All rights reserved.
//

import UIKit

public class LoadingButton: DefaultButton {
    public var animationLayers: [CALayer] = []
    
    public override func animateTouch() {
        super.animateTouch()
        self.isEnabled = false
        animateLoading()
    }
    
    public func animateLoading() {
        // Override with loading animation
        // Add animation layers to `animationLayers` to be removed
        // on finish
    }
    
    public func stopLoadingAnimation() {
        self.isEnabled = true
        for layer in self.animationLayers {
            layer.removeFromSuperlayer()
        }
        self.animationLayers.removeAll()
    }

}
