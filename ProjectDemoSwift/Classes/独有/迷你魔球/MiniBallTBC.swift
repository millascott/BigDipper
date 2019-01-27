//
//  MiniBallTBC.swift
//  ProjectDemoSwift
//
//  Created by pingguo on 2019/1/10.
//  Copyright © 2019年 yons. All rights reserved.
//

import UIKit

class MiniBallTBC: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let devicesVC = MiniBallDevicesVC(title: "设备", normalImg: UIImage.init(named: "tab_equ_icon"), selectedImg: UIImage.init(named: "tab_equ_icon_sel"))
        let myVC = MyVC(title: "我的", normalImg: UIImage.init(named: "tab_mine_icon"), selectedImg: UIImage.init(named: "tab_mine_icon_sel"))
        
        let nav1 = RootNavigationController.init(rootViewController: devicesVC)
        let nav2 = RootNavigationController.init(rootViewController: myVC)
        
        self.viewControllers = [nav1, nav2]
        
        // 解决tabbar跳动问题
        self.tabBar.isTranslucent = false
        
        self.tabBar.tintColor = UIColor.darkText
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
