//
//  AppDelegate+AppLaunch.swift
//  ProjectDemoSwift
//
//  Created by yons on 2018/10/15.
//  Copyright © 2018年 yons. All rights reserved.
//

import Foundation
import SVProgressHUD
import UIKit

extension AppDelegate {
    func ChooseVCToPush() -> Void {
        let nav = RootNavigationController.init(rootViewController: HomeVC())
        AppManager.shared.HomeNavigation = nav
        nav.navigationBar.barTintColor = UIColor.init(hexString: "F8F8F8")
        self.window?.rootViewController = nav
        //AppManager.shared.PresentAdvertisement()
    }
    
    func SVProgressHUDConfig() {
        SVProgressHUD.setDefaultStyle(.dark)
        SVProgressHUD.setMaximumDismissTimeInterval(2)
    }
}
