//
//  NetVC.swift
//  ProjectDemoSwift
//
//  Created by pingguo on 2018/12/30.
//  Copyright © 2018年 yons. All rights reserved.
//

import UIKit

class NetVC: RootViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }


    @IBAction func NetBtnClick(_ sender: UIButton) {
        PopAlert.shared.PopDescriptionAlertView(title: "什么事网络?如何创建网络", content: "这里的网络是一个虚拟网络，用来存储智能设备如何您在不同地方都有设备，希望您的家人和朋友也可以同时使用，您可以创建多网络来管理这些设备，点击又上角的“+”就可以创造一个了。", sureClosure: nil)
    }
    

}
