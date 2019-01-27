//
//  CircleProgressButton.swift
//  ProjectDemoSwift
//
//  Created by yons on 2018/10/29.
//  Copyright © 2018年 yons. All rights reserved.
//

import UIKit

class CircleProgressButton: UIButton, CAAnimationDelegate {
    
    private var duration: Double = 5
    private var finishClosure: () -> Void = {}
    
    private var timer: Timer? = nil
    private var countTime: Double = 0
    
    // MARK:- 贝塞尔曲线
    lazy var bezierPath: UIBezierPath = {
        let centerPoint = CGPoint(x: self.frame.width/2, y: self.frame.height/2)
        let radius = self.frame.width/2
        let bzPath = UIBezierPath.init(arcCenter: centerPoint,
                                       radius: radius,
                                       startAngle: degreeToRadians(-90),
                                       endAngle: degreeToRadians(270),
                                       clockwise: true)
        return bzPath
    }()
    // 角度转弧度
    func degreeToRadians(_ x: Double) -> CGFloat {
        return CGFloat.init((x * .pi) / 180)
    }
    
    // MARK:- 动画
    lazy var pathAnimation: CABasicAnimation = {
        let animation = CABasicAnimation.init(keyPath: "strokeEnd")
        animation.duration = CFTimeInterval.init(self.duration)
        animation.fromValue = 0
        animation.toValue = 1
        animation.delegate = self
        return animation
    }()
    
    // MARK:- layer
    lazy var circleLayer: CAShapeLayer = {
        let cirLayer = CAShapeLayer.init()
        cirLayer.frame = self.bounds
        cirLayer.strokeColor = UIColor.black.cgColor  // 边缘线的颜色
        cirLayer.fillColor = UIColor.white.cgColor  // 闭环内填充的颜色
        cirLayer.lineCap = .square  // 边缘线的类型
        cirLayer.lineWidth = 2  // 线条宽度
//        cirLayer.strokeStart = 0
//        cirLayer.strokeEnd = 1
        cirLayer.path = self.bezierPath.cgPath  // 从贝塞尔曲线获取形状
        cirLayer.add(self.pathAnimation, forKey: nil)  // 加入动画
        return cirLayer
    }()
    
    convenience init(frame: CGRect, duration: Double, finishClosure: @escaping ()->Void) {
        self.init(frame: frame)
        self.duration = duration
        self.layer.addSublayer(self.circleLayer)
        self.finishClosure = finishClosure
        // 倒数
        self.countTime = duration
        self.setTitleColor(UIColor.black, for: .normal)
        self.setTitle("\(Int.init(self.countTime))", for: .normal)
        self.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        self.timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(TimerUpdate), userInfo: nil, repeats: true)
    }
    
    @objc func TimerUpdate() {
        self.countTime -= 1
        self.setTitle("\(Int.init(self.countTime))", for: .normal)
        if (self.countTime <= 0) {
            self.timer?.invalidate()
            self.setTitle("X", for: .normal)
            self.titleLabel?.font = UIFont.systemFont(ofSize: 18)
        }
    }
    
    // MARK:- CAAnimationDelegate
    func animationDidStart(_ anim: CAAnimation) {
        
    }
    
    func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        if (flag) {
            self.finishClosure()
        }
    }

    override func draw(_ rect: CGRect) {
        // Drawing code
    }

}
