//
//  UIColor+Init.swift
//  ProjectDemoSwift
//
//  Created by yons on 2018/10/17.
//  Copyright © 2018年 yons. All rights reserved.
//

import Foundation
import UIKit

extension UIColor {
    convenience init?(hexString: String) {
        self.init(hexString: hexString, alpha: -1)
    }
    
    // alpha == -1表示不设置透明度
    convenience init?(hexString: String, alpha: CGFloat) {
        
        var str = hexString.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        if str.contains("#") {
            str = String(str[str.index(after: str.startIndex)..<str.endIndex])
        } else if str.contains("0X") {
            str = String(str[str.index(str.startIndex, offsetBy: 2)..<str.endIndex])
        }
        var r, g, b, a : CGFloat
        switch str.count {
        case 3:
            r = CGFloat(String(str[0..<1]).hexToInt()) / 255
            g = CGFloat(String(str[1..<2]).hexToInt()) / 255
            b = CGFloat(String(str[2..<3]).hexToInt()) / 255
            a = CGFloat(1)
        case 4:
            a = CGFloat(String(str[0..<1]).hexToInt()) / 255
            r = CGFloat(String(str[1..<2]).hexToInt()) / 255
            g = CGFloat(String(str[2..<3]).hexToInt()) / 255
            b = CGFloat(String(str[3..<4]).hexToInt()) / 255
        case 6:
            r = CGFloat(String(str[0..<2]).hexToInt()) / 255
            g = CGFloat(String(str[2..<4]).hexToInt()) / 255
            b = CGFloat(String(str[4..<6]).hexToInt()) / 255
            a = CGFloat(1)
        case 8:
            a = CGFloat(String(str[0..<2]).hexToInt()) / 255
            r = CGFloat(String(str[2..<4]).hexToInt()) / 255
            g = CGFloat(String(str[4..<6]).hexToInt()) / 255
            b = CGFloat(String(str[6..<8]).hexToInt()) / 255
        default:
            return nil
        }
        
        if (alpha >= 0 && alpha <= 1) {
            a = alpha
        }
        
        self.init(red: r, green: g, blue: b, alpha: a)
    }
    

}

