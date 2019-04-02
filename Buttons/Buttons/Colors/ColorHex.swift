//
//  ColorHex.swift
//  ButtonPlay
//
//  Created by Anthony Fennell on 1/24/19.
//  Copyright © 2019 Anthony Fennell. All rights reserved.
//

import UIKit

public enum ColorHex: Int, CaseIterable {
    case red1=0xCD6155, red2=0xC0392B, red3=0xA93226, red4=0x922B21, red5=0x7B241C
    case pink1=0xF1948A, pink2=0xEC7063, pink3=0xE74C3C, pink4=0xCB4335, pink5=0xB03A2E
    case purple1=0xBB8FCE, purple2=0xA569BD, purple3=0x8E44AD, purple4=0x7D3C98, purple5=0x6C3483
    case blue1=0x5DADE2, blue2=0x3498DB, blue3=0x2E86C1, blue4=0x2874A6, blue5=0x21618C
    case lightGreen1=0x48C9B0, lightGreen2=0x1ABC9C, lightGreen3=0x17A589, lightGreen4=0x148F77, lightGreen5=0x117864
    case green1=0x73C6B6, green2=0x45B39D, green3=0x16A085, green4=0x138D75, green5=0x117A65
    case yellow1=0xF9E79F, yellow2=0xF7DC6F, yellow3=0xF4D03F, yellow4=0xF1C40F, yellow5=0xd4AC0D
    case orange1=0xFAD7A0, orange2=0xF8C471, orange3=0xF5B041, orange4=0xF39C12, orange5=0xD68910
    case gray1=0xAAB7B8, gray2=0x95A5A6, gray3=0x839192, gray4=0x717D7E, gray5=0x5F6A6A
    case black1=0xABB2B9, black2=0x808B96, black3=0x566573, black4=0x2C3E50, black5=0x212F3D
    
    public var color: UIColor {
        return UIColor(hex: self.rawValue)
    }
}
