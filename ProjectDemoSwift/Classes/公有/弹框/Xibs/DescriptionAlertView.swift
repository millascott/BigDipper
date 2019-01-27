//
//  DescriptionAlertView.swift
//  ProjectDemoSwift
//
//  Created by pingguo on 2018/12/30.
//  Copyright © 2018年 yons. All rights reserved.
//

import UIKit

class DescriptionAlertView: UIView {
    
    @IBOutlet weak var sureButton: UIButton! {
        didSet {
            sureButton.layer.borderColor = UIColor.black.cgColor
        }
    }
    
    
    @IBOutlet weak var titleLab: UILabel!
    @IBOutlet weak var contentLab: UILabel!
    
    var sureClosure: ()->Void = {}
    var removeClosure: ()->Void = {}
    
    
    // MARK: - 关闭
    @IBAction func CloseBtnClick(_ sender: UIButton) {
        removeClosure()
    }
    
    @IBAction func SureBtnClick(_ sender: UIButton) {
        sureClosure()
        removeClosure()
    }

}

extension PopAlert {
    func PopDescriptionAlertView(title: String, content: String, sureClosure: (()->Void)?) {
        PopAlert.shared.LoadBackground()
        let view = Bundle.main.loadNibNamed("DescriptionAlertView", owner: nil, options: nil)?.last as! DescriptionAlertView
        PopAlert.shared.background.addSubview(view)
        view.snp.makeConstraints { (make) in
            make.center.equalTo(PopAlert.shared.background)
            make.left.equalTo(35)
            make.right.equalTo(-35)
        }
        
        view.transform = CGAffineTransform.init(scaleX: 0.1, y: 0.1)
        view.alpha = 0.1
        UIView.animate(withDuration: self.animateRate) {
            view.transform = CGAffineTransform.init(scaleX: 1, y: 1)
            view.alpha = 1
        }
        
        view.removeClosure = {
            PopAlert.shared.RemoveBackground()
            UIView.animate(withDuration: self.animateRate, animations: {
                view.transform = CGAffineTransform.init(scaleX: 0.1, y: 0.1)
                view.alpha = 0.01
            })
        }
        if let closure = sureClosure {
            view.sureClosure = closure
        }
        
    }
}
