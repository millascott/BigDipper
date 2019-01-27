//
//  RootTabBarController.swift
//  ProjectDemoSwift
//
//  Created by yons on 2018/10/15.
//  Copyright © 2018年 yons. All rights reserved.
//

import UIKit

class RootTabBarController: UITabBarController {
    
    var vcArray: [[String]] = [["首页", "", ""], ["我的", "", ""]]

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        let homeVC = HomeVC(title: vcArray[0][0], normalImg: UIImage.init(named: vcArray[0][1]), selectedImg: UIImage.init(named: vcArray[0][2]))
//        let userCenterVC = UserCenterViewController(title: vcArray[1][0], normalImage: UIImage(named: vcArray[1][1]), selectedImage: UIImage(named: vcArray[1][2]))
        
        let nav1 = RootNavigationController.init(rootViewController: homeVC)
//        let nav2 = RootNavigationController.init(rootViewController: userCenterVC)
        
        self.viewControllers = [nav1]
        
        // 解决tabbar跳动问题
        self.tabBar.isTranslucent = false
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
