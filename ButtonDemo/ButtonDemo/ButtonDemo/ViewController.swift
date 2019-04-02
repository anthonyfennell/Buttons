//
//  ViewController.swift
//  ButtonDemo
//
//  Created by Anthony Fennell on 3/30/19.
//  Copyright © 2019 Anthony Fennell. All rights reserved.
//

import UIKit
import Buttons

class ViewController: UIViewController {

    @IBOutlet weak var button1: DefaultButton!
    @IBOutlet weak var loadingButton1: LoadingFillButton!
    @IBOutlet weak var loadingGradientButton1: LoadingGradientButton!
    
    @IBOutlet weak var borderButton1: BorderButton!
    @IBOutlet weak var cornerButton1: DefaultButton!
    @IBOutlet weak var edgeButton1: SlidingEdgesButton!
    @IBOutlet weak var ovalLeftButton: OvalLeftButton!
    @IBOutlet weak var ovalRightButton: OvalRightButton!
    
    @IBOutlet weak var diamondButton: DiamondButton!
    @IBOutlet weak var triangleButton: TriangleButton!
    @IBOutlet weak var triangleFlippedButton: TriangleFlippedButton!
    
    @IBOutlet weak var loadingCircularButton: LoadingCircularButton!
    @IBOutlet weak var loadingEdgeButton: LoadingEdgeButton!
    
    @IBOutlet weak var loadingOrbsButton: LoadingOrbsButton!
    
    @IBOutlet weak var ovalStackView: UIStackView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        colorPurple(button: self.button1)
        colorBlue(button: self.loadingButton1)
        colorOrange(button: self.loadingGradientButton1)
        colorOrange(button: self.cornerButton1)
        colorPurple(button: self.edgeButton1)
        colorBlue(button: self.ovalLeftButton)
        colorPurple(button: self.ovalRightButton)
        colorOrange(button: self.diamondButton)
        colorBlue(button: self.triangleButton)
        colorPurple(button: self.triangleFlippedButton)
        colorBlue(button: self.loadingCircularButton)
        colorPurple(button: self.loadingEdgeButton)
        colorPurple(button: self.loadingOrbsButton)
        
        
        self.borderButton1.highlightColor = ColorHex.orange2.color.withAlphaComponent(0.5)
        self.cornerButton1.cornerRadius = 4.0
        self.diamondButton.cornerRadius = 4.0
        self.loadingOrbsButton.cornerRadius = 4.0
        
        let circleButton = CircleButton(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
        colorBlue(button: circleButton)
        self.ovalStackView.addArrangedSubview(circleButton)
    }
    
    @IBAction func loadingButtonAction(_ sender: Any) {
        Timer.scheduledTimer(withTimeInterval: 6.0, repeats: false) { (_) in
            self.loadingButton1.stopLoadingAnimation()
        }
    }
    
    @IBAction func loadingGradientButtonAction(_ sender: Any) {
        Timer.scheduledTimer(withTimeInterval: 6.0, repeats: false) { (_) in
            self.loadingGradientButton1.stopLoadingAnimation()
        }
    }
    
    @IBAction func loadingCircularButtonAction(_ sender: Any) {
        Timer.scheduledTimer(withTimeInterval: 6.0, repeats: false) { (_) in
            self.loadingCircularButton.stopLoadingAnimation()
        }
    }
    
    @IBAction func loadingEdgeButtonAction(_ sender: Any) {
        Timer.scheduledTimer(withTimeInterval: 6.0, repeats: false) { (_) in
            self.loadingEdgeButton.stopLoadingAnimation()
        }
    }
    
    @IBAction func loadingOrbsButtonAction(_ sender: Any) {
        Timer.scheduledTimer(withTimeInterval: 6.0, repeats: false) { (_) in
            self.loadingOrbsButton.stopLoadingAnimation()
        }
    }
    
    
    func colorPurple(button: DefaultButton) {
        ButtonUtils.color(button: button, buttonColor: ColorHex.purple2.color,
                          highlightColor: ColorHex.purple4.color,
                          borderColor: ColorHex.purple4.color,
                          disabledColor: ColorHex.purple2.color.withAlphaComponent(0.35))
    }

    func colorBlue(button: DefaultButton) {
        ButtonUtils.color(button: button, buttonColor: ColorHex.blue2.color,
                          highlightColor: ColorHex.blue4.color,
                          borderColor: ColorHex.blue4.color,
                          disabledColor: ColorHex.blue2.color.withAlphaComponent(0.35))
    }
    
    func colorOrange(button: DefaultButton) {
        ButtonUtils.color(button: button, buttonColor: ColorHex.orange2.color,
                          highlightColor: ColorHex.orange4.color,
                          borderColor: ColorHex.orange4.color,
                          disabledColor: ColorHex.orange2.color.withAlphaComponent(0.35))
    }
}

