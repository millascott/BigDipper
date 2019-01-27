//
//  YL001Manager.swift
//  ProjectDemoSwift
//
//  Created by pingguo on 2019/1/7.
//  Copyright © 2019年 yons. All rights reserved.
//

import Foundation
import CoreBluetooth
import SVProgressHUD

class YL001Manager {
    static let shared = YL001Manager()
    
    var centralManager = CBCentralManager.init()
    
    // 已添加的设备
    var addedDeviceArr = [CBPeripheral]()
    // 当前所控制的设备
    var currentDevice: CBPeripheral? = nil
    // 匹配设备与特征
    var deviceCharMap = [CBPeripheral: CBCharacteristic]()
    
    let standData: [UInt8] = [0x00, 0x00, 0x00, 0x06, 0x08, 0x80]
    var contentData: [UInt8] = [0x00, 0x03, 0x64, 0x64, 0x01, 0x00]
    var completeData: [UInt8] {
        get {
            var finalData = standData
            finalData.append(contentsOf: contentData)
            // 校验和?
            finalData.append(0xFF)
            return finalData
        }
    }
    
    func SendData(isGroup: Bool) {
        if let device = currentDevice {
            device.writeValue(Data.init(self.completeData), for: self.deviceCharMap[device]!, type: .withoutResponse)
            print(self.contentData.map({ (data) -> String in
                return String.init(format: "%x", data)
            }))
        } else {
            SVProgressHUD.showError(withStatus: "未找到发送的设备")
        }
    }
}
