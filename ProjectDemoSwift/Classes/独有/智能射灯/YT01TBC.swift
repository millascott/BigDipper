//
//  YT01TBC.swift
//  ProjectDemoSwift
//
//  Created by pingguo on 2018/12/29.
//  Copyright © 2018年 yons. All rights reserved.
//

import UIKit

class YT01TBC: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let devicesVC = YT01DevicesVC(title: "设备", normalImg: UIImage.init(named: "tab_equ_icon"), selectedImg: UIImage.init(named: "tab_equ_icon_sel"))
        let myVC = MyVC(title: "我的", normalImg: UIImage.init(named: "tab_mine_icon"), selectedImg: UIImage.init(named: "tab_mine_icon_sel"))
        
        let nav1 = RootNavigationController.init(rootViewController: devicesVC)
        let nav2 = RootNavigationController.init(rootViewController: myVC)
        
        self.viewControllers = [nav1, nav2]
        
        // 解决tabbar跳动问题
        self.tabBar.isTranslucent = false
        
        self.tabBar.tintColor = UIColor.darkText
        
    }

}
