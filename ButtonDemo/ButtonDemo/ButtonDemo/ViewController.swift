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
    
    @IBOutlet weak var hideButton1: DefaultButton!
    @IBOutlet weak var hideButton2: DefaultButton!
    @IBOutlet weak var hideButton3: DefaultButton!
    
    @IBOutlet weak var stack1: UIStackView!
    @IBOutlet weak var stack2: UIStackView!
    @IBOutlet weak var stack3: UIStackView!
    
    @IBOutlet weak var button3: DefaultButton!
    @IBOutlet weak var button4: DefaultButton!
    @IBOutlet weak var button5: DefaultButton!
    
    @IBOutlet weak var cornerButton3: DefaultButton!
    @IBOutlet weak var cornerButton4: DefaultButton!
    @IBOutlet weak var cornerButton5: DefaultButton!
    
    @IBOutlet weak var borderButton3: BorderButton!
    @IBOutlet weak var borderButton4: BorderButton!
    @IBOutlet weak var borderButton5: BorderButton!

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
    @IBOutlet weak var loadingHopButton: LoadingHopButton!
    
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
        colorGreen(button: self.loadingHopButton)
        colorPurple(button: self.cornerButton3)
        colorPurple(button: self.cornerButton4)
        colorPurple(button: self.cornerButton5)
        colorBlue(button: self.borderButton3)
        colorBlue(button: self.borderButton4)
        colorBlue(button: self.borderButton5)
        
        // Assign a light highlight color for border buttons
        self.borderButton1.highlightColor = ColorHex.orange2.color.withAlphaComponent(0.5)
        self.borderButton2.highlightColor = ColorHex.orange2.color.withAlphaComponent(0.5)
        
        // Enable gradient
        self.button2.isGradientEnabled = true
        self.hideButton1.isGradientEnabled = true
        self.hideButton2.isGradientEnabled = true
        self.hideButton3.isGradientEnabled = true
        
        // Enable shadow
        self.button1.isShadowed = true
        
        // Assign a border width
        self.button1.borderWidth = 4.0
        self.borderButton1.borderWidth = 4.0
        self.cornerButton1.borderWidth = 0.0
        
        // Increase corner radius
        self.hideButton1.cornerRadius = self.hideButton1.frame.height / 2
        self.hideButton2.cornerRadius = self.hideButton2.frame.height / 2
        self.hideButton3.cornerRadius = self.hideButton3.frame.height / 2
        
        // Increase border width left to right
        self.button3.borderWidth = 0.0
        self.button4.borderWidth = 4.0
        self.button5.borderWidth = 8.0
        
        // Increase corner radius left to right
        self.cornerButton3.cornerRadius = 5.0
        self.cornerButton4.cornerRadius = 10.0
        self.cornerButton5.cornerRadius = 20.0
        
        // Increase border width
        self.borderButton3.borderWidth = 0.0
        self.borderButton4.borderWidth = 4.0
        self.borderButton5.borderWidth = 8.0
        self.borderButton5.cornerRadius = 8.0
        
        // Assign corner radius
        self.cornerButton1.cornerRadius = 4.0
        self.diamondButton.cornerRadius = 4.0
        self.loadingOrbsButton.cornerRadius = 4.0
        self.button2.cornerRadius = self.button2.frame.height / 2
        self.borderButton2.cornerRadius = self.borderButton2.frame.height / 2
        self.loadingEdgeButton.cornerRadius = 4.0
        
        // Disable buttons
        self.disabledButton.isEnabled = false
        self.disabledBorderButton.isEnabled = false
        
        // Example of adding button programatically
        let circleButton = CircleButton(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
        circleButton.isGradientEnabled = true
        colorBlue(button: circleButton)
        self.ovalStackView.addArrangedSubview(circleButton)
        
        // Extra details
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
    
    
    
    
    // MARK: - Details
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
    
    // Color Buttons
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
        ButtonUtils.color(button: button, buttonColor: ColorHex.red1.color,
                          highlightColor: ColorHex.red2.color,
                          borderColor: ColorHex.red2.color,
                          disabledColor: ColorHex.red1.color.withAlphaComponent(0.35))
    }
    
    func colorGreen(button: DefaultButton) {
        ButtonUtils.color(button: button, buttonColor: ColorHex.green2.color,
                          highlightColor: ColorHex.green4.color,
                          borderColor: ColorHex.green4.color,
                          disabledColor: ColorHex.green2.color.withAlphaComponent(0.35))
    }
    
    
    // MARK: - Show / Hide buttons
    @IBAction func hideButtonAction(_ sender: DefaultButton) {
        var hide = false
        var view: UIView!
        if sender == self.hideButton1 {
            hide = !self.stack1.isHidden
            view = self.stack1
        } else if sender == self.hideButton2 {
            hide = !self.stack2.isHidden
            view = self.stack2
        } else if sender == self.hideButton3 {
            hide = !self.stack3.isHidden
            view = self.stack3
        }
        sender.setTitle(hide ? "Show" : "Hide", for: .normal)
        if hide {
            hideAnimator(view: view).startAnimation()
        } else {
            showAnimator(view: view).startAnimation()
        }
    }
    
    func showAnimator(view: UIView) -> UIViewPropertyAnimator {
        let frame = view.frame
        view.frame = CGRect(x: frame.origin.x, y: frame.origin.y, width: frame.width, height: 0.01)
        view.alpha = 0.0
        let animator = UIViewPropertyAnimator(duration: 0.33, curve: .easeIn)
        animator.addAnimations {
            view.alpha = 1.0
        }
        animator.addAnimations {
            view.frame = frame
        }
        animator.addAnimations {
            view.isHidden = false
        }
        return animator
    }
    
    func hideAnimator(view: UIView) -> UIViewPropertyAnimator {
        let frame = view.frame
        let toFrame = CGRect(x: frame.origin.x, y: frame.origin.y, width: frame.width, height: 0.01)
        let animator = UIViewPropertyAnimator(duration: 0.33, curve: .easeIn)
        animator.addAnimations {
            view.alpha = 0.0
        }
        animator.addAnimations {
            view.frame = toFrame
        }
        animator.addAnimations {
            view.isHidden = true
        }
        return animator
    }
    
}

