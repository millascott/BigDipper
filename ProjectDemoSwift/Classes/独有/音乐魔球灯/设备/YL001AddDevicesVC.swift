//
//  YL001AddDevicesVC.swift
//  ProjectDemoSwift
//
//  Created by pingguo on 2019/1/7.
//  Copyright © 2019年 yons. All rights reserved.
//

import UIKit
import CoreBluetooth

class YL001AddDevicesVC: RootViewController, UITableViewDelegate, UITableViewDataSource, CBCentralManagerDelegate, CBPeripheralDelegate {

    @IBOutlet weak var tableView: UITableView!
    
    let manager = YL001Manager.shared.centralManager
    
    var deviceArr = [CBPeripheral]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.TableViewConfig()
        self.BluetoothConfig()
    }

    private func UpdateNavState(isOn: Bool) {
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
        self.navigationController?.popViewController(animated: true)
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
            self.UpdateNavState(isOn: true)
            self.manager.scanForPeripherals(withServices: nil, options: nil)
            break
        case .poweredOff:
            self.UpdateNavState(isOn: false)
            break
        case .unauthorized:
            print("设备未授权使用蓝牙")
        default:
            break
        }
    }
    
    // 搜索到蓝牙设备
    func centralManager(_ central: CBCentralManager, didDiscover peripheral: CBPeripheral, advertisementData: [String : Any], rssi RSSI: NSNumber) {
        if peripheral.name == "MQ" {
            if !self.deviceArr.contains(peripheral) {
                self.deviceArr.append(peripheral)
                print("找到了一个MQ设备:\(peripheral)")
                self.tableView.reloadData()
            }
        } else {
            print("找到了一个其他设备:\(peripheral)")
        }
    }
    
    // 连接设备成功
    func centralManager(_ central: CBCentralManager, didConnect peripheral: CBPeripheral) {
        print("连接设备成功")
        peripheral.delegate = self
        // [CBUUID.init(string: "4F45"), CBUUID.init(string: "454F")]
        peripheral.discoverServices(nil)
    }
    
    // 连接设备失败
    func centralManager(_ central: CBCentralManager, didFailToConnect peripheral: CBPeripheral, error: Error?) {
        print("连接设备失败")
    }
    
    // MARK: CBPeripheral的代理
    //  找到服务
    func peripheral(_ peripheral: CBPeripheral, didDiscoverServices error: Error?) {
        if let services = peripheral.services {
            for service in services {
                print("找到一个service: \(service)")
                // [CBUUID.init(string: "8888")]
                peripheral.discoverCharacteristics(nil, for: service)
            }
        } else {
            print("peripheral还未找到服务")
        }
    }
    
    // 找到特征
    func peripheral(_ peripheral: CBPeripheral, didDiscoverCharacteristicsFor service: CBService, error: Error?) {
        if let characteristics = service.characteristics {
            for characteristic in characteristics {
                if characteristic.uuid == CBUUID.init(string: "8888") {
                    YL001Manager.shared.deviceCharMap[service.peripheral] = characteristic
                }
                print("找到一个Service(\(service.uuid))的Characteristic:\(characteristic)")
            }
        } else {
            print("service还未找到特征")
        }
    }
    
    // MARK: - TableView初始化
    override func TableViewConfig() {
        self.tableView.register(UINib.init(nibName: "YL001AddDevicesTVC", bundle: nil), forCellReuseIdentifier: "YL001AddDevicesTVC")
    }
    
    // MARK: - TableView代理
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.deviceArr.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.1
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "YL001AddDevicesTVC") as! YL001AddDevicesTVC
        cell.peripheral = self.deviceArr[indexPath.row]
        cell.AddBtnClickClosure = {
            if let peripheral = cell.peripheral {
                YL001Manager.shared.addedDeviceArr.append(peripheral)
                self.manager.connect(peripheral, options: nil)
            }
        }
        return cell
    }

}
