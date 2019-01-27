//
//  HomeSideView.swift
//  ProjectDemoSwift
//
//  Created by pingguo on 2018/12/28.
//  Copyright © 2018年 yons. All rights reserved.
//

import UIKit
import SnapKit

class HomeSideView: UIView, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    
    override func awakeFromNib() {
        self.TableViewConfig()
    }

    // MARK: - TableView初始化
    func TableViewConfig() {
        self.tableView.register(UINib.init(nibName: "HomeSideTVC", bundle: nil), forCellReuseIdentifier: "HomeSideTVC")
        self.tableView.delegate = self
        self.tableView.dataSource = self
    }
    
    // MARK: - TableView的代理
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 6
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 67
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 57
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView.init(color: .clear)
        let label = UILabel.init(title: "更多", font: UIFont.systemFont(ofSize: 17, weight: .bold))
        headerView.addSubview(label)
        label.snp.makeConstraints { (make) in
            make.left.equalTo(25)
            make.bottom.equalTo(-12)
        }
        return headerView
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "HomeSideTVC", for: indexPath) as! HomeSideTVC
        switch indexPath.row {
        case 0:
            cell.iconView.image = UIImage.init(named: "home_side_pro_icon")
            cell.titleLab.text = "常见问题"
        case 1:
            cell.iconView.image = UIImage.init(named: "home_side_opr_icon")
            cell.titleLab.text = "操作说明"
        case 2:
            cell.iconView.image = UIImage.init(named: "home_side_feed_icon")
            cell.titleLab.text = "意见反馈"
        case 3:
            cell.iconView.image = UIImage.init(named: "home_side_about_icon")
            cell.titleLab.text = "关于"
        case 4:
            cell.iconView.image = UIImage.init(named: "home_side_light_icon")
            cell.titleLab.text = "灯光"
        case 5:
            cell.iconView.image = UIImage.init(named: "home_side_music_icon")
            cell.titleLab.text = "音乐"
        default:
            break
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}
