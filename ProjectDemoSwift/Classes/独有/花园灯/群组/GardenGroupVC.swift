//
//  GardenGroupVC.swift
//  ProjectDemoSwift
//
//  Created by pingguo on 2018/12/28.
//  Copyright © 2018年 yons. All rights reserved.
//

import UIKit

class GardenGroupVC: RootViewController, UITableViewDelegate, UITableViewDataSource {
    
    var emptyView = UIView.init(color: .clear)

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.TableViewConfig()
        self.navigationItem.rightBarButtonItem = UIBarButtonItem.init(image: UIImage.init(named: "groud_add_icon"), style: .done, target: nil, action: #selector(RightBarBtnClick))
    }
    
    @objc func RightBarBtnClick() {
        
    }
    
    // MARK: - EmptyView缺省页
    func EmptyViewConfig() {
        let imageView = UIImageView.init(image: UIImage.init(named: "equ_blank_img"))
        self.emptyView.addSubview(imageView)
        imageView.snp.makeConstraints { (make) in
            make.centerX.equalTo(self.emptyView)
            make.centerY.equalTo(self.emptyView).offset(-50)
        }
        let label = UILabel.init(title: "请点击右上角“+”添加群组", titleColor: UIColor.init(hexString: "#A1A1A1")!, font: UIFont.systemFont(ofSize: 15))
        self.emptyView.addSubview(label)
        label.snp.makeConstraints { (make) in
            make.centerX.equalTo(self.emptyView)
            make.top.equalTo(imageView.snp_bottomMargin).offset(15)
        }
        self.view.addSubview(self.emptyView)
        self.emptyView.snp.makeConstraints { (make) in
            make.left.right.top.bottom.equalTo(0)
        }
        self.emptyView.isHidden = true
    }
    
    // MARK: - TableView初始化
    override func TableViewConfig() {
        self.tableView.register(UINib.init(nibName: "GardenGroupTVC", bundle: nil), forCellReuseIdentifier: "GardenGroupTVC")
    }
    
    // MARK: - TableView的代理
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "GardenGroupTVC", for: indexPath) as! GardenGroupTVC
        return cell
    }

}
