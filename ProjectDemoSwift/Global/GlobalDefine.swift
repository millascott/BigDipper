//
//  GlobalDefine.swift
//  ProjectDemoSwift
//
//  Created by yons on 2018/10/15.
//  Copyright © 2018年 yons. All rights reserved.
//

import Foundation
import UIKit

//获取系统对象
let G_Application = UIApplication.shared
let G_KeyWindow = UIApplication.shared.keyWindow
let G_AppDelegate = UIApplication.shared.delegate


let G_StatusBarHeight = UIApplication.shared.statusBarFrame.size.height
let G_NavBarHeight = CGFloat(44)
let G_TabBarHeight:CGFloat = G_NavBarHeight > 20 ? 83 : 49
let G_TopHeight = G_StatusBarHeight + G_NavBarHeight

// 获取屏幕宽高
let G_ScreenW = UIScreen.main.bounds.size.width
let G_ScreenH = UIScreen.main.bounds.size.height
let G_ScreenBounds = UIScreen.main.bounds


