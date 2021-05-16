//
//  UIColor+Additions.swift
//  Cookery
//
//  Created by Rosi-Eliz Dzhurkova on 16.05.21.
//

import UIKit

extension UIColor {
    static var mainGreen: UIColor? {
        return UIColor(hex: "#7ED321")
    }
    
    static var secondaryGreen: UIColor? {
        return UIColor(hex: "#B8E986")
    }
    
    static var prominentGreen: UIColor? {
        return UIColor(hex: "#417505")
    }

    static var paleGrey: UIColor? {
        return UIColor(hex: "#F6F6F6")
    }
    
    static var componentGrey: UIColor? {
        return UIColor(hex: "#EFC4C4")
    }
    
    static var primaryTitleText: UIColor? {
        return UIColor(hex: "#4A4A4A")
    }
    
    static var descriptiontText: UIColor? {
        return UIColor(hex: "#999999")
    }
    
    // MARK: - Utilities
    
    public convenience init?(hex: String) {
        let r, g, b, a: CGFloat
        
        guard hex.hasPrefix("#") else {
            return nil
        }
        let start = hex.index(hex.startIndex, offsetBy: 1)
        let hexColor = String(hex[start...])
        
        if hexColor.count == 8 {
            let scanner = Scanner(string: hexColor)
            var hexNumber: UInt64 = 0
            
            if scanner.scanHexInt64(&hexNumber) {
                r = CGFloat((hexNumber & 0xff000000) >> 24) / 255
                g = CGFloat((hexNumber & 0x00ff0000) >> 16) / 255
                b = CGFloat((hexNumber & 0x0000ff00) >> 8) / 255
                a = CGFloat(hexNumber & 0x000000ff) / 255
                
                self.init(red: r, green: g, blue: b, alpha: a)
                return
            }
        }
        return nil
    }
}
