//
//  UIButton+ImagePosition.swift
//  ProjectDemoSwift
//
//  Created by yons on 2018/10/17.
//  Copyright © 2018年 yons. All rights reserved.
//

import Foundation
import UIKit

enum ImagePosition {
    case left
    case right
    case top
    case bottom
}

extension UIButton {
    
    /**
     *  利用UIButton的titleEdgeInsets和imageEdgeInsets来实现文字和图片的自由排列
     *  注意：这个方法需要在设置图片和文字之后才可以调用，且button正常显示
     *
     *  @param spacing 图片和文字的间隔
     */
    func SetImagePosition(position: ImagePosition, spacing: CGFloat) {
        let imageWidth = self.imageView!.image!.size.width
        let imageHeight = self.imageView!.image!.size.height
        let labelWidth = self.titleLabel!.frame.size.width
        let labelHeight = self.titleLabel!.frame.size.height
        print("labelWidth:\(labelWidth)    labelheight:\(labelHeight)")
        
        let imageOffsetX = (imageWidth + labelWidth) / 2 - imageWidth / 2
        let imageOffsetY = labelHeight / 2 + spacing / 2
        let labelOffsetX = (imageWidth + labelWidth / 2) - (imageWidth + labelWidth) / 2
        let labelOffsetY = imageHeight / 2 + spacing / 2
        
        switch position {
        case .left:
            self.imageEdgeInsets = UIEdgeInsets.init(top: 0, left: -spacing/2, bottom: 0, right: spacing/2)
            self.titleEdgeInsets = UIEdgeInsets.init(top: 0, left: spacing/2, bottom: 0, right: -spacing/2)
        case .right:
            self.imageEdgeInsets = UIEdgeInsets.init(top: 0, left: labelWidth+spacing/2, bottom: 0, right: -(labelWidth+spacing/2))
            self.titleEdgeInsets = UIEdgeInsets.init(top: 0, left: -(imageHeight+spacing/2), bottom: 0, right: imageHeight+spacing/2)
        case .top:
            self.imageEdgeInsets = UIEdgeInsets.init(top: -imageOffsetY, left: imageOffsetX, bottom: imageOffsetY, right: -imageOffsetX)
            self.titleEdgeInsets = UIEdgeInsets.init(top: labelOffsetY, left: -labelOffsetX, bottom: -labelOffsetY, right: labelOffsetX)
        case .bottom:
            self.imageEdgeInsets = UIEdgeInsets.init(top: imageOffsetY, left: imageOffsetX, bottom: -imageOffsetY, right: -imageOffsetX)
            self.titleEdgeInsets = UIEdgeInsets.init(top: -labelOffsetY, left: -labelOffsetX, bottom: labelOffsetY, right: labelOffsetX)
        }
    }
}
