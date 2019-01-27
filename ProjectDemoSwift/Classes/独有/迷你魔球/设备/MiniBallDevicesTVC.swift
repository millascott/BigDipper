//
//  MiniBallDevicesTVC.swift
//  ProjectDemoSwift
//
//  Created by pingguo on 2019/1/10.
//  Copyright © 2019年 yons. All rights reserved.
//

import UIKit
import CoreBluetooth
import luckysdk

class MiniBallDevicesTVC: UITableViewCell {
    
    var device: Device? = nil

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    @IBAction func SelectBtnClick(_ sender: UIButton) {
        if Manager.inst()?.associatingDevice() == nil {
            Manager.inst()?.associateDevice(self.device!)
        }
        MiniBallManager.shared.currentDevice = device
        sender.isSelected = !sender.isSelected
        let highData = MiniBallManager.shared.contentData1_3[1]/16*16
        let lowData: UInt8 = sender.isSelected ? 1 : 0
        MiniBallManager.shared.contentData1_3[1] = highData + lowData
        MiniBallManager.shared.SendData(isGroup: false)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
