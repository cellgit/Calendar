//
//  UIColor+Extension.swift
//  Calendar
//
//  Created by 刘宏立 on 2020/9/26.
//

import UIKit
import Foundation

extension UIColor {
    /// Hex color
    /// - Parameter hex: hex value
    @objc(initWithRGB:) convenience init(_ hex: Int) {
        self.init(hex, 1.0)
    }
        
    @objc(initWithRGB:alpha:) convenience init(_ hex: Int, _ alpha: CGFloat) { /// 0.0342130064964294 / 100
        let r = CGFloat((hex & 0xFF0000) >> 16) / 255.0
        let g = (CGFloat)((hex & 0x00FF00) >> 8) / 255.0
        let b = (CGFloat)(hex & 0x0000FF) / 255.0
        self.init(red: r, green: g, blue: b, alpha: alpha)
    }
}

struct ThemeColor {
    static var orange: UIColor = UIColor.init(0xFDC552)
    static var green: UIColor = UIColor.init(0x13BB74)
    static var gray: UIColor = UIColor.init(0x333333)
    static var midGray: UIColor = UIColor.init(0x666666)
    static var lightGray: UIColor = UIColor.init(0x999999)
    static var tinyGray: UIColor = UIColor.init(0xF3F4F5)
}
