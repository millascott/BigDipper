//
//  UIButton+Init.swift
//  ProjectDemoSwift
//
//  Created by yons on 2018/10/16.
//  Copyright © 2018年 yons. All rights reserved.
//

import Foundation
import UIKit

extension UIButton {
    
    convenience init(title: String, font: UIFont) {
        self.init(title: title, titleColor: UIColor.darkText, font: font)
    }
    
    convenience init(title: String, titleColor: UIColor, font: UIFont) {
        self.init(title: title, titleColor: titleColor, font: font, image: nil, backgroundImage: nil)
    }
    
    convenience init(title: String, font: UIFont, image: UIImage) {
        self.init(title: title, titleColor: UIColor.darkText, font: font, image: image)
    }
    
    convenience init(title: String, titleColor: UIColor, font: UIFont, image: UIImage) {
        self.init(title: title, titleColor: titleColor, font: font, image: image, backgroundImage: nil)
    }
    
    convenience init(title: String, font: UIFont, backgroundImage: UIImage) {
        self.init(title: title, titleColor: UIColor.darkText, font: font, backgroundImage: backgroundImage)
    }
    
    convenience init(title: String, titleColor: UIColor, font: UIFont, backgroundImage: UIImage) {
        self.init(title: title, titleColor: titleColor, font: font, image: nil, backgroundImage: backgroundImage)
    }
    
    convenience init(title: String?, titleColor: UIColor?, font: UIFont, image: UIImage?, backgroundImage: UIImage?) {
        self.init()
        self.setTitle(title, for: .normal)
        self.setTitleColor(titleColor, for: .normal)
        self.titleLabel?.font = font
        self.setImage(image, for: .normal)
        self.setBackgroundImage(backgroundImage, for: .normal)
    }
}
