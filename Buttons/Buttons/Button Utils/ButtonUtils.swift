//
//  DefaultButtonUtils.swift
//  ButtonPlay
//
//  Created by Anthony Fennell on 3/14/19.
//  Copyright © 2019 Anthony Fennell. All rights reserved.
//

import Foundation

public struct ButtonUtils {
    public static func color(button: DefaultButton, buttonColor: UIColor, highlightColor: UIColor, borderColor: UIColor, disabledColor: UIColor) {
        button.buttonColor = buttonColor
        button.highlightColor = highlightColor
        button.borderColor = borderColor
        button.disabledColor = disabledColor
    }
}
