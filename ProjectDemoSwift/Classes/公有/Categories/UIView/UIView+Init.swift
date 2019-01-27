//
//  UIView+Init.swift
//  ProjectDemoSwift
//
//  Created by pingguo on 2018/12/14.
//  Copyright © 2018年 yons. All rights reserved.
//

import Foundation

extension UIView {
    convenience init(color: UIColor?) {
        self.init()
        self.backgroundColor = color
    }
}
