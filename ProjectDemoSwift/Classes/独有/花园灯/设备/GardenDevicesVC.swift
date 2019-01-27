//
//  GardenDevicesVC.swift
//  ProjectDemoSwift
//
//  Created by pingguo on 2018/12/28.
//  Copyright © 2018年 yons. All rights reserved.
//

import UIKit
import CoreBluetooth

class GardenDevicesVC: RootViewController, UITableViewDelegate, UITableViewDataSource, CBCentralManagerDelegate {
    
    var emptyView = UIView.init(color: .clear)

    @IBOutlet weak var tableView: UITableView!
    
    var manager = CBCentralManager.init()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.TableViewConfig()
        self.EmptyViewConfig()
        self.BluetoothConfig()
        self.navigationItem.rightBarButtonItem = UIBarButtonItem.init(image: UIImage.init(named: "groud_add_icon"), style: .done, target: nil, action: #selector(RightBarBtnClick))
    }
    
    @objc func RightBarBtnClick() {
        
    }
    
    private func UpdateNavBluetoothState(isOn: Bool) {
        let backButtonItem = UIBarButtonItem.init(image: UIImage.init(named: "groud_back_icon"), style: .done, target: self, action: #selector(BackBtnClick))
        var bluetoothButton: UIButton
        if isOn {
            bluetoothButton = UIButton.init(title: "(已连接)", font: UIFont.systemFont(ofSize: 12), image: UIImage.init(named: "groud_bt_icon_sel")!)
        } else {
            bluetoothButton = UIButton.init(title: "(未连接)", titleColor: UIColor.gray, font: UIFont.systemFont(ofSize: 12), image: UIImage.init(named: "groud_bt_icon_nor")!)
        }
        let bluetoothButtonItem = UIBarButtonItem.init(customView: bluetoothButton)
        self.navigationItem.leftBarButtonItems = [backButtonItem, bluetoothButtonItem]
    }
    
    @objc func BackBtnClick() {
        self.tabBarController?.dismiss(animated: true, completion: nil)
    }
    
    // MARK: - 蓝牙初始化
    func BluetoothConfig() {
        self.manager = CBCentralManager.init(delegate: self, queue: nil)
    }
    
    // MARK: - 蓝牙代理 设置代理之后会自动调用一次
    func centralManagerDidUpdateState(_ central: CBCentralManager) {
        switch central.state {
        case .poweredOn:
            self.UpdateNavBluetoothState(isOn: true)
        case .poweredOff:
            self.UpdateNavBluetoothState(isOn: false)
        case .unauthorized:
            print("设备未授权使用蓝牙")
        default:
            break
        }
    }
    
    // MARK: - EmptyView缺省页
    func EmptyViewConfig() {
        let imageView = UIImageView.init(image: UIImage.init(named: "equ_blank_img"))
        self.emptyView.addSubview(imageView)
        imageView.snp.makeConstraints { (make) in
            make.centerX.equalTo(self.emptyView)
            make.centerY.equalTo(self.emptyView).offset(-50)
        }
        let label = UILabel.init(title: "请点击右上角“+”添加设备", titleColor: UIColor.init(hexString: "#A1A1A1")!, font: UIFont.systemFont(ofSize: 15))
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
        self.tableView.register(UINib.init(nibName: "GardenDevicesTVC", bundle: nil), forCellReuseIdentifier: "GardenDevicesTVC")
    }
    
    // MARK: - TableView的代理
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.1
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "GardenDevicesTVC", for: indexPath) as! GardenDevicesTVC
        return cell
    }
}
