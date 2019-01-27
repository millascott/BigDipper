//
//  UIImage+Tool.swift
//  ProjectDemoSwift
//
//  Created by yons on 2018/10/24.
//  Copyright © 2018年 yons. All rights reserved.
//

import Foundation
import UIKit

extension UIImage {
    static func GetImageWith(color: UIColor) -> UIImage? {
        UIGraphicsBeginImageContext(UIScreen.main.bounds.size)
        let context = UIGraphicsGetCurrentContext()!
        context.setFillColor(color.cgColor)
        context.fill(UIScreen.main.bounds)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image
    }
}
