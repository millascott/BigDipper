//
//  UILabel+Init.swift
//  ProjectDemoSwift
//
//  Created by yons on 2018/10/16.
//  Copyright © 2018年 yons. All rights reserved.
//

import Foundation
import UIKit

extension UILabel {
    convenience init(title: String, font: UIFont) {
        self.init(title: title, titleColor: UIColor.darkText, font: font)
    }
    
    convenience init(title: String, titleColor: UIColor, font: UIFont) {
        self.init()
        self.text = title
        self.textColor = titleColor
        self.font = font
    }
}
