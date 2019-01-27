//
//  YT01DevicesTVC.swift
//  ProjectDemoSwift
//
//  Created by pingguo on 2018/12/29.
//  Copyright © 2018年 yons. All rights reserved.
//

import UIKit
import CoreBluetooth

class YT01DevicesTVC: UITableViewCell {
    
    var device: CBPeripheral? = nil

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    @IBAction func SelectBtnClick(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        YT01Manager.shared.currentDevice = device
        if sender.isSelected {
            YT01Manager.shared.contentData[0] = 0x01
        } else {
            YT01Manager.shared.contentData[0] = 0x00
        }
        YT01Manager.shared.SendData(isGroup: false)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
