//
//  MiniBallDevicesVC.swift
//  ProjectDemoSwift
//
//  Created by pingguo on 2019/1/10.
//  Copyright © 2019年 yons. All rights reserved.
//

import UIKit
import CoreBluetooth
import luckysdk

class MiniBallDevicesVC: RootViewController, CBCentralManagerDelegate {
    
    var emptyView = UIView.init(color: .clear)
    
    @IBOutlet weak var tableView: UITableView!
    
    let manager = MiniBallManager.shared.centralManager
    
    let lygdManager = Manager.inst()!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.TableViewConfig()
        self.EmptyViewConfig()
        self.navigationItem.rightBarButtonItem = UIBarButtonItem.init(image: UIImage.init(named: "groud_add_icon"), style: .done, target: self, action: #selector(RightBarBtnClick))
        lygdManager.add(self)
        lygdManager.scanNewDevice(3*1000)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.BluetoothConfig()
        self.tableView.reloadData()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        lygdManager.remLsnr(self)
    }
    
    @objc func RightBarBtnClick() {
        self.navigationController?.pushViewController(MiniBallAddDevicesVC(), animated: true)
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
        self.manager.stopScan()
        self.tabBarController?.dismiss(animated: true, completion: nil)
    }
    
    // MARK: - TableView初始化
    override func TableViewConfig() {
        self.tableView.register(UINib.init(nibName: "MiniBallDevicesTVC", bundle: nil), forCellReuseIdentifier: "MiniBallDevicesTVC")
    }
    
    // MARK: - 蓝牙初始化
    func BluetoothConfig() {
        self.manager.delegate = self
        self.centralManagerDidUpdateState(self.manager)
    }
    
    // MARK: - 蓝牙代理
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

}

// MARK: - TableView的代理
extension MiniBallDevicesVC: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return MiniBallManager.shared.addedDeviceArr.count
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
        let cell = tableView.dequeueReusableCell(withIdentifier: "MiniBallDevicesTVC", for: indexPath) as! MiniBallDevicesTVC
        cell.device = MiniBallManager.shared.addedDeviceArr[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        MiniBallManager.shared.currentDevice = MiniBallManager.shared.addedDeviceArr[indexPath.row]
        self.navigationController?.pushViewController(YL001DevicesControlVC(), animated: true)
    }

}

// MARK: - lygdManager代理
extension MiniBallDevicesVC: ManagerLsnr {
    func onConnect(_ isBleConn: Bool, _ isWiFiConn: Bool) {
        print("connecting")
    }
    
    func onDevFound(_ dev: Device!, _ rssi: Double) {
        if dev.type() == 0x7805 {
            for device in MiniBallManager.shared.addedDeviceArr {
                if device.id()?.description() == dev.id()?.description() {
                    return
                }
            }
            print("找到新的迷你魔球")
            MiniBallManager.shared.addedDeviceArr.append(dev)
            // 回到主线程更新UI
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    func onDevAdd(_ n: Device!) {
        print("+")
    }
    
    func onDevAddFailed(_ dev: Device!) {
        print("-")
        if lygdManager.associatingDevice() == nil {
            lygdManager.associateDevice(dev)
        }
    }
}
