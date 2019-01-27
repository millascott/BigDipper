//
//  HomeManager.swift
//  ProjectDemoSwift
//
//  Created by pingguo on 2018/12/28.
//  Copyright © 2018年 yons. All rights reserved.
//

import Foundation

/* 据说是策略模式...模式个屁 */
class HomeManager {
    
    // MARK: - Cell的点击跳转
    public static func CellDidSelect(indexPath: IndexPath) {
        switch indexPath.item {
        case 0:
            AppManager.shared.HomeNavigation?.pushViewController(YL001DevicesVC(), animated: true)
        case 1:
            AppManager.shared.HomeNavigation?.present(GardenLightTBC(), animated: true, completion: nil)
        case 2:
            AppManager.shared.HomeNavigation?.present(MiniBallTBC(), animated: true, completion: nil)
        case 4:
            AppManager.shared.HomeNavigation?.present(YT01TBC(), animated: true, completion: nil)
        default:
            break
        }
    }
    
    // MARK: - 设置Cell的显示
    public static func CellConfig(cell: HomeCVC, indexPath: IndexPath) {
        switch indexPath.item {
        case 0:
            cell.nameLab.text = "音乐魔球灯"
            cell.contentLab.text = "多维度气氛渲染"
            cell.iconView.image = UIImage.init(named: "home_mq_img")
        case 1:
            cell.nameLab.text = "花园灯"
            cell.contentLab.text = "节日装饰户外"
            cell.iconView.image = UIImage.init(named: "home_hyd_img")
        case 2:
            cell.nameLab.text = "迷你魔球灯"
            cell.contentLab.text = "娱乐车载"
            cell.iconView.image = UIImage.init(named: "home_xmq_img")
        case 3:
            cell.nameLab.text = "炫彩一号"
            cell.contentLab.text = "色彩渲染"
            cell.iconView.image = UIImage.init(named: "home_xc_img")
        case 4:
            cell.nameLab.text = "智能射灯"
            cell.contentLab.text = "智能控制"
            cell.iconView.image = UIImage.init(named: "home_znsd_img")
        default:
            break
        }
    }
}
