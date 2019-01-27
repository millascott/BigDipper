//
//  RootNavigationController.swift
//  ProjectDemoSwift
//
//  Created by yons on 2018/10/15.
//  Copyright © 2018年 yons. All rights reserved.
//

import UIKit

class RootNavigationController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        // 背景色
        self.navigationBar.barTintColor = UIColor.init(red: 1, green: 1, blue: 1, alpha: 1)
        //self.navigationBar.backgroundColor = UIColor.init(red: 1, green: 1, blue: 1, alpha: 0.1)
        // 标题 NSAttributedString.Key.foregroundColor
        self.navigationBar.titleTextAttributes = [.foregroundColor:UIColor.black, .font:UIFont.systemFont(ofSize: 18, weight: .medium)]
        // 背景图
        //self.navigationBar.setBackgroundImage(UIImage.GetImageWith(color: UIColor.init(red: 1, green: 1, blue: 1, alpha: 0.8)), for: .default)
        // 边界
        self.navigationBar.shadowImage = UIImage.init()
        // 半透明 默认为true（有一层毛玻璃）设置为false会去掉毛玻璃且将VC限制在导航栏下方
        self.navigationBar.isTranslucent = false
        
        // 渲染颜色
        self.navigationBar.tintColor = UIColor.darkText
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        AppManager.shared.currentNavigation = self
    }
    
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        if self.viewControllers.count == 1 {
            viewController.hidesBottomBarWhenPushed = true
        }
        super.pushViewController(viewController, animated: true)
        viewController.navigationItem.leftBarButtonItem = UIBarButtonItem.init(image: UIImage.init(named: "groud_back_icon"), style: .done, target: self, action: #selector(popViewController(animated:)))
        
    }
    
    /*
     导航栏不隐藏且为默认半透明时，VC加个tableview，tableview一部分被导航栏遮盖，但导航栏会把tableView的内容(header,cell)顶到导航栏下方
     2018.10.16 因为当isTranslucent设置为false的时候，总有一层UIBarBackground阻碍导航栏设置透明度，目前设置导航栏半透明唯一的方法是把isTranslucent设置为true
     当isTranslucent为true时，设置透明度大小的方法为设置barBackgroundImage的透明度
 */
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
