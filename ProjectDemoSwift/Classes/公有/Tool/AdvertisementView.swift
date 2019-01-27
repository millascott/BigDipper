//
//  AdvertisementView.swift
//  ProjectDemoSwift
//
//  Created by yons on 2018/10/29.
//  Copyright © 2018年 yons. All rights reserved.
//

/*
 广告页
 */

import UIKit
import ReactiveCocoa

class AdvertisementView: UIView {
    
    // 当倒计时结束时是否消失
    var dismissWhenCounted: Bool = true
    
    var tapClosure: ()->Void = {}
    
    lazy var documentsURL: URL = {
        let url = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask)[0]
        return url
    }()
    
    convenience init(frame: CGRect, tapClosure: @escaping ()->Void) {
        self.init(frame: frame)
        self.backgroundColor = UIColor.white
        self.tapClosure = tapClosure
        let circleButton = CircleProgressButton.init(frame: CGRect.init(x: G_ScreenW-70, y: 50, width: 30, height: 30), duration: 5) {}
        self.addSubview(circleButton)
        
        // 判断沙盒中是否存在广告图片
        //let isExist = FileManager.default.fileExists(atPath: documentsURL.absoluteString)
    }
    
//    func show() -> Void {
//        let circleButton = CircleProgressButton.init(duration: 5) {
//            print("haha")
//        }
//        self.addSubview(circleButton)
//        G_AppWindow?.addSubview(self)
//    }
    
    override func draw(_ rect: CGRect) {
        // Drawing code
    }

}
