//
//  RegisterVC.swift
//  ProjectDemoSwift
//
//  Created by pingguo on 2018/12/30.
//  Copyright © 2018年 yons. All rights reserved.
//

import UIKit

class RegisterVC: RootViewController {

    @IBOutlet weak var modeMobileButton: UIButton!
    @IBOutlet weak var modeEmailButton: UIButton!
    
    
    @IBOutlet weak var redLine: UIView!
    
    @IBOutlet weak var firstTF: UITextField!
    @IBOutlet weak var passwordTF: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        self.title = "注册"
    }
    
    // MARK: 手机号码
    @IBAction func ModeMobileBtnClick(_ sender: UIButton) {
        self.modeEmailButton.isSelected = false
        sender.isSelected = true
        UIView.animate(withDuration: 0.5) {
            self.redLine.center.x = sender.center.x
        }
        self.firstTF.text = ""
        self.firstTF.placeholder = "        请输入手机号码"
        self.passwordTF.text = ""
    }
    
    // MAKRK: 电子邮箱
    @IBAction func ModeEmailBtnClick(_ sender: UIButton) {
        self.modeMobileButton.isSelected = false
        sender.isSelected = true
        UIView.animate(withDuration: 0.5) {
            self.redLine.center.x = sender.center.x
        }
        self.firstTF.text = ""
        self.firstTF.placeholder = "        请输入点击邮箱"
        self.passwordTF.text = ""
    }
    
    // MARK: 注册
    @IBAction func RegisterBtnClick(_ sender: UIButton) {
        sender.isSelected = false
    }
    
    @IBAction func RegisterBtnTouchDown(_ sender: UIButton) {
        sender.isSelected = true
    }

}
