//
//  CountableButton.swift
//  ProjectDemoSwift
//
//  Created by yons on 2018/10/26.
//  Copyright © 2018年 yons. All rights reserved.
//

/*
 倒计时按钮
 */

import UIKit

class CountableButton: UIButton {
    
    @IBInspectable var totalTime: Int = 60
    @IBInspectable var againTitle: String? = "重新获取验证码"
    
    private var timer: Timer? = nil
    private var countTime:Int = 0
    private var isCounting: Bool = false {
        willSet {
            if newValue {
                countTime = totalTime
                self.setTitle("\(self.countTime)秒后再次获取", for: .normal)
                timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector:#selector(timerUpdate), userInfo: nil, repeats: true)
            } else {
                timer?.invalidate()
                timer = nil
                self.setTitle(againTitle, for: .normal)
            }
            self.isEnabled = !newValue
        }
    }
    
    convenience init(totalTime: Int) {
        self.init()
        self.totalTime = totalTime
    }
    
    @objc func startCountDown() {
        isCounting = true
    }
    
    @objc func timerUpdate() {
        countTime -= 1;
        self.setTitle("\(self.countTime)秒后再次获取", for: .normal)
        if self.countTime == 0 {
            isCounting = false
        }
    }

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
