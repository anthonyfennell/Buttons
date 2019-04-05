//
//  BorderButton.swift
//  ButtonPlay
//
//  Created by Anthony Fennell on 3/18/19.
//  Copyright © 2019 Anthony Fennell. All rights reserved.
//

import UIKit

public class BorderButton: DefaultButton {
    public override func configure() {
        super.configure()
        self.isBackgroundFilled = false
    }
    
    public override func updateTitleColor() {
        setTitleColor(self.borderColor, for: .normal)
        setTitleColor(self.borderColor, for: .highlighted)
        setTitleColor(self.disabledColor, for: .disabled)
    }
}

