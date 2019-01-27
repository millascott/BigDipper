//
//  MyVC.swift
//  ProjectDemoSwift
//
//  Created by pingguo on 2018/12/30.
//  Copyright © 2018年 yons. All rights reserved.
//

import UIKit

class MyVC: RootViewController {
    
    
    @IBOutlet weak var nameLab: UILabel!
    @IBOutlet weak var desLab: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.navigationItem.leftBarButtonItem = UIBarButtonItem.init(image: UIImage.init(named: "groud_back_icon"), style: .done, target: self, action: #selector(BackBtnClick))
    }
    
    @objc func BackBtnClick() {
        self.tabBarController?.dismiss(animated: true, completion: nil)
    }
    
    // MARK: -  点击头像
    @IBAction func PortraitBtnClick(_ sender: UIButton) {
        self.navigationController?.pushViewController(LoginVC(), animated: true)
    }
    
    // MARK: - 网络
    @IBAction func NetBtnClick(_ sender: UIButton) {
        self.navigationController?.pushViewController(NetVC(), animated: true)
    }
    
    // MARK: - 关于
    @IBAction func AboutBtnClick(_ sender: UIButton) {
        self.navigationController?.pushViewController(AboutVC(), animated: true)
    }
    
    
}
