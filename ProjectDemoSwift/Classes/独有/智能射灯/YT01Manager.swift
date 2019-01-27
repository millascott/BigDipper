//
//  YT01Manager.swift
//  ProjectDemoSwift
//
//  Created by pingguo on 2018/12/30.
//  Copyright © 2018年 yons. All rights reserved.
//

import Foundation
import CoreBluetooth
import SVProgressHUD

class YT01Manager {
    static let shared = YT01Manager()
    
    // 已添加的设备
    var addedDeviceArr = [CBPeripheral]()
    // 当前所控制的设备
    var currentDevice: CBPeripheral? = nil
    // 匹配设备与特征
    var deviceCharMap = [CBPeripheral: CBCharacteristic]()
    
    let standData: [UInt8] = [0xaa, 0x55, 0x01, 0x01, 0xdd, 0xcc, 0x0a]
    var contentData: [UInt8] = [0x00, 0x13, 0xF1, 0xFF, 0x01, 0x0F, 0x33, 0x30, 0x40, 0x00]
    var completeData: [UInt8] {
        get {
            var finalData = standData
            finalData.append(contentsOf: contentData)
            // 校验和?
            finalData.append(0x25)
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
