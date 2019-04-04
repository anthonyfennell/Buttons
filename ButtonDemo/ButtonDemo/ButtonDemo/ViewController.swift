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
    
    @IBOutlet weak var button2: DefaultButton!
    @IBOutlet weak var borderButton2: BorderButton!
    
    @IBOutlet weak var disabledButton: DefaultButton!
    @IBOutlet weak var disabledBorderButton: BorderButton!
    
    @IBOutlet weak var ovalStackView: UIStackView!
    
    @IBOutlet weak var buttonColorLabel: UILabel!
    @IBOutlet weak var buttonColorView: UIView!
    @IBOutlet weak var borderColorLabel: UILabel!
    @IBOutlet weak var borderColorView: UIView!
    @IBOutlet weak var highlightColorLabel: UILabel!
    @IBOutlet weak var highlightColorView: UIView!
    @IBOutlet weak var disabledColorLabel: UILabel!
    @IBOutlet weak var disabledColorView: UIView!
    @IBOutlet weak var cornerRadiusLabel: UILabel!
    @IBOutlet weak var borderWidthLabel: UILabel!
    @IBOutlet weak var shadowedLabel: UILabel!
    @IBOutlet weak var backgroundGradientLabel: UILabel!
    @IBOutlet weak var isDisabledLabel: UILabel!
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        colorPurple(button: self.button1)
        colorBlue(button: self.loadingButton1)
        colorOrange(button: self.loadingGradientButton1)
        colorGreen(button: self.cornerButton1)
        colorRed(button: self.edgeButton1)
        colorBlue(button: self.ovalLeftButton)
        colorPurple(button: self.ovalRightButton)
        colorOrange(button: self.diamondButton)
        colorBlue(button: self.triangleButton)
        colorPurple(button: self.triangleFlippedButton)
        colorBlue(button: self.loadingCircularButton)
        colorGreen(button: self.loadingEdgeButton)
        colorPurple(button: self.loadingOrbsButton)
        colorRed(button: self.button2)
        colorYellow(button: self.borderButton2)
        colorGreen(button: self.disabledButton)
        colorOrange(button: self.disabledBorderButton)
        
        self.borderButton1.highlightColor = ColorHex.orange2.color.withAlphaComponent(0.5)
        self.borderButton2.highlightColor = ColorHex.orange2.color.withAlphaComponent(0.5)
        
        self.button2.isGradientEnabled = true
        self.button1.isShadowed = true
        
        self.button1.borderWidth = 4.0
        self.borderButton1.borderWidth = 4.0
        
        self.cornerButton1.cornerRadius = 4.0
        self.diamondButton.cornerRadius = 4.0
        self.loadingOrbsButton.cornerRadius = 4.0
        self.button2.cornerRadius = 5.0
        self.borderButton2.cornerRadius = 5.0
        self.loadingEdgeButton.cornerRadius = 4.0
        
        self.disabledButton.isEnabled = false
        self.disabledBorderButton.isEnabled = false
        
        // Example of adding button programatically
        let circleButton = CircleButton(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
        colorBlue(button: circleButton)
        self.ovalStackView.addArrangedSubview(circleButton)
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.handleTap(_:)))
        tap.cancelsTouchesInView = false
        self.scrollView.addGestureRecognizer(tap)
    }
    
    @IBAction func loadingButtonAction(_ sender: LoadingButton) {
        // Simulate the loading stopped
        Timer.scheduledTimer(withTimeInterval: 6.0, repeats: false) { (_) in
            sender.stopLoadingAnimation()
        }
    }
    
    @IBAction func button2Action(_ sender: Any) {
        setRandomColorFor(button: self.button2)
    }
    
    @IBAction func borderButton2Action(_ sender: Any) {
        setRandomColorForBorder(button: self.borderButton2)
    }
    
    @objc
    func handleTap(_ sender: UITapGestureRecognizer) {
        let point = sender.location(in: self.scrollView)
        if let button = self.scrollView.hitTest(point, with: nil) as? DefaultButton {
            updateDetailsWith(button: button)
        } else if let viewA = self.scrollView.hitTest(point, with: nil) {
            let point = sender.location(in: viewA)
            for subview in viewA.subviews {
                if subview.frame.contains(point), let button = subview as? DefaultButton {
                    updateDetailsWith(button: button)
                }
            }
        }
    }
    
    
    // MARK: - Details
    func updateDetailsWith(button: DefaultButton) {
        self.buttonColorLabel.text = button.buttonColor.toHexString()
        self.buttonColorView.backgroundColor = button.buttonColor
        self.borderColorLabel.text = button.borderColor.toHexString()
        self.borderColorView.backgroundColor = button.borderColor
        self.highlightColorLabel.text = button.highlightColor.toHexString()
        self.highlightColorView.backgroundColor = button.highlightColor
        self.disabledColorLabel.text = button.disabledColor.toHexString()
        self.disabledColorView.backgroundColor = button.disabledColor
        self.cornerRadiusLabel.text = String(format: "%.2f", button.cornerRadius)
        self.borderWidthLabel.text = String(format: "%.1f", button.borderWidth)
        self.shadowedLabel.text = button.isShadowed ? "true" : "false"
        self.backgroundGradientLabel.text = button.isGradientEnabled ? "true" : "false"
        self.isDisabledLabel.text = button.isEnabled ? "true" : "false"
    }
    
    // MARK: - Random colors
    func setRandomColorFor(button: DefaultButton) {
        let randomInt = Int.random(in: 0...6)
        switch randomInt {
        case 0:
            self.colorPurple(button: button)
        case 1:
            self.colorBlue(button: button)
        case 2:
            colorOrange(button: button)
        case 3:
            colorYellow(button: button)
        case 4:
            colorGreen(button: button)
        default:
            colorRed(button: button)
        }
    }
    
    func setRandomColorForBorder(button: BorderButton) {
        let randomInt = Int.random(in: 0...6)
        switch randomInt {
        case 0:
            self.colorPurple(button: button)
            button.highlightColor = ColorHex.purple2.color.withAlphaComponent(0.5)
        case 1:
            self.colorBlue(button: button)
            button.highlightColor = ColorHex.blue2.color.withAlphaComponent(0.5)
        case 2:
            colorOrange(button: button)
            button.highlightColor = ColorHex.orange2.color.withAlphaComponent(0.5)
        case 3:
            colorYellow(button: button)
            button.highlightColor = ColorHex.yellow2.color.withAlphaComponent(0.5)
        case 4:
            colorGreen(button: button)
            button.highlightColor = ColorHex.green2.color.withAlphaComponent(0.5)
        default:
            colorRed(button: button)
            button.highlightColor = ColorHex.red2.color.withAlphaComponent(0.5)
        }
    }
    
    // Color entire button
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
    
    func colorYellow(button: DefaultButton) {
        ButtonUtils.color(button: button, buttonColor: ColorHex.yellow2.color,
                          highlightColor: ColorHex.yellow4.color,
                          borderColor: ColorHex.yellow4.color,
                          disabledColor: ColorHex.yellow2.color.withAlphaComponent(0.35))
    }
    
    func colorRed(button: DefaultButton) {
        ButtonUtils.color(button: button, buttonColor: ColorHex.red2.color,
                          highlightColor: ColorHex.red4.color,
                          borderColor: ColorHex.red4.color,
                          disabledColor: ColorHex.red2.color.withAlphaComponent(0.35))
    }
    
    func colorGreen(button: DefaultButton) {
        ButtonUtils.color(button: button, buttonColor: ColorHex.green2.color,
                          highlightColor: ColorHex.green4.color,
                          borderColor: ColorHex.green4.color,
                          disabledColor: ColorHex.green2.color.withAlphaComponent(0.35))
    }
    
    
}

