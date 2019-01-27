//
//  RootViewController.swift
//  ProjectDemoSwift
//
//  Created by yons on 2018/10/15.
//  Copyright © 2018年 yons. All rights reserved.
//

import UIKit
import SnapKit
import Reachability

class RootViewController: UIViewController {
    
    convenience init(title: String?, normalImg:UIImage?, selectedImg:UIImage?) {
        self.init()
        self.title = title
        self.tabBarItem.image = normalImg
        self.tabBarItem.selectedImage = selectedImg
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        AppManager.shared.currentViewController = self
        // 注册网络状态改变的通知
        NotificationCenter.default.addObserver(self, selector: #selector(ReachabilityChanged(note:)), name: .reachabilityChanged, object: AppManager.shared.reachability)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        // 移除网络状态改变的通知
        NotificationCenter.default.removeObserver(self, name: .reachabilityChanged, object: AppManager.shared.reachability)
    }
    
    // MARK: - 网络状态改变的回调
    @objc func ReachabilityChanged(note: Notification) {
        
    }
    
    func TableViewConfig() {
        
    }
    
    func CollectionViewConfig() {
        
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
