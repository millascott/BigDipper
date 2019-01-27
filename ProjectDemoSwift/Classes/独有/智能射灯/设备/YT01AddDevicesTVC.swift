//
//  YT01AddDevicesTVC.swift
//  ProjectDemoSwift
//
//  Created by pingguo on 2018/12/29.
//  Copyright © 2018年 yons. All rights reserved.
//

import UIKit
import CoreBluetooth

class YT01AddDevicesTVC: UITableViewCell {
    
    var peripheral: CBPeripheral? = nil
    
    var AddBtnClickClosure: ()->Void = {}
    
    @IBOutlet weak var addButton: UIButton! {
        didSet {
            addButton.layer.borderColor = UIColor.black.cgColor
        }
    }
    
    private func ChangeUIForState(isSelected: Bool) {
        if isSelected {
            self.addButton.backgroundColor = UIColor.init(hexString: "#FF2825")
            self.addButton.layer.borderWidth = 0
            self.addButton.setTitleColor(.white, for: .normal)
            self.addButton.isUserInteractionEnabled = false
        } else {
            self.addButton.backgroundColor = UIColor.white
            self.addButton.layer.borderWidth = 1
            self.addButton.setTitleColor(.darkText, for: .normal)
        }
    }
    
    @IBAction func AddBtnClick(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        ChangeUIForState(isSelected: sender.isSelected)
        self.AddBtnClickClosure()
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
