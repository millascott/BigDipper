//
//  MiniBallManager.swift
//  ProjectDemoSwift
//
//  Created by pingguo on 2019/1/10.
//  Copyright © 2019年 yons. All rights reserved.
//

import Foundation
import CoreBluetooth
import SVProgressHUD
import luckysdk

class MiniBallManager {
    static let shared = MiniBallManager()
    
    var centralManager = CBCentralManager.init()
    
    // 已添加的设备
    var addedDeviceArr = [Device]()
    // 当前所控制的设备
    var currentDevice: Device? = nil
    // 匹配设备与特征
    var deviceCharMap = [CBPeripheral: CBCharacteristic]()
    
    // 第一位为数据长度
    var contentData1_3: [UInt8] = [0x03, 0x13, 0xF1, 0xFF]
    var contentData4_8: [UInt8] = [0x05, 0xFF, 0x01, 0x0F, 0x33, 0x30]
    
    func SendData(isGroup: Bool) {
        if let entity = Manager.inst()?.getTarget(currentDevice!.id()) {
            Manager.inst()?.sendTransData(entity, first: false, data: Data.init(contentData4_8))
            Manager.inst()?.sendTransData(entity, first: true, data: Data.init(contentData1_3))
        } else {
            print("未连接设备")
            Manager.inst()?.sendTransData(currentDevice, first: false, data: Data.init(contentData4_8))
            Manager.inst()?.sendTransData(currentDevice, first: true, data: Data.init(contentData1_3))
        }
    }
}
