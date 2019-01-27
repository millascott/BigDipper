//
//  YL001DevicesTVC.swift
//  ProjectDemoSwift
//
//  Created by pingguo on 2019/1/7.
//  Copyright © 2019年 yons. All rights reserved.
//

import UIKit
import CoreBluetooth

class YL001DevicesTVC: UITableViewCell {
    
    var device: CBPeripheral? = nil

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    // MARK: - 开关
    @IBAction func OnOffBtnClick(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        YL001Manager.shared.currentDevice = self.device
        if sender.isSelected {
            YL001Manager.shared.contentData[0] = 0x01
        } else {
            YL001Manager.shared.contentData[0] = 0x00
        }
        YL001Manager.shared.SendData(isGroup: false)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
