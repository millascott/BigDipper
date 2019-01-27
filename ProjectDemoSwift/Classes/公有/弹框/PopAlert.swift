//
//  PopAlert.swift
//  ProjectDemoSwift
//
//  Created by pingguo on 2018/12/14.
//  Copyright © 2018年 yons. All rights reserved.
//

import Foundation

class PopAlert {
    
    static let shared = PopAlert()
    
    var animateRate: TimeInterval = 0.4
    
    // 如果不加在keyWindow上的话就用这个
    var contentView: UIView? = nil
    // 是否可以点击背景弹框消失 默认为false
    //var backgroundInteraction = false
    
    lazy var background: UIView = {
        let back = UIView.init(frame: CGRect.init(x: 0, y: 0, width: G_ScreenW, height: G_ScreenH))
        back.backgroundColor = UIColor.init(white: 0, alpha: 0)
        return back
    }()
    
    func LoadBackground() {
        if let contentView = self.contentView {
            contentView.addSubview(self.background)
        } else {
            G_KeyWindow?.addSubview(self.background)
        }
        UIView.animate(withDuration: self.animateRate) {
            self.background.backgroundColor = UIColor.init(white: 0, alpha: 0.5)
        }
    }
    
    func RemoveBackground() {
        UIView.animate(withDuration: self.animateRate, animations: {
            self.background.backgroundColor = UIColor.init(white: 0, alpha: 0)
        }) { (bool) in
            self.background.removeFromSuperview()
            self.contentView = nil
        }
    }
}
