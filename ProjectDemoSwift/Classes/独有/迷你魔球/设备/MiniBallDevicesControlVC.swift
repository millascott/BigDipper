//
//  MiniBallDevicesControlVC.swift
//  ProjectDemoSwift
//
//  Created by pingguo on 2019/1/12.
//  Copyright © 2019年 yons. All rights reserved.
//

import UIKit

class MiniBallDevicesControlVC: RootViewController {
    
    @IBOutlet weak var contentView: UIView!
    @IBOutlet var modeButtons: [UIButton]!
    @IBOutlet weak var brightSlider: UISlider!
    @IBOutlet weak var brightSwitch: UIButton!
    
    // MARK: 自动模式下变量
    @IBOutlet var autoButtons: [UIButton]!
    // MARK: 手动模式下变量
    @IBOutlet var manualSwitches: [UIButton]!
    @IBOutlet var manualSliders: [UISlider]!
    // MARK: 声控模式下变量
    @IBOutlet weak var voiceSlider: UISlider!
    @IBOutlet var voiceEffectButtons: [UIButton]!
    
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.Initialize()
    }
    
    private func Initialize() {
        self.autoButtons[0].layer.borderColor = UIColor.init(hexString: "#FF601A")?.cgColor
        self.autoButtons[1].layer.borderColor = UIColor.init(hexString: "#FFB417")?.cgColor
        self.autoButtons[2].layer.borderColor = UIColor.init(hexString: "#96E21B")?.cgColor
        self.autoButtons[3].layer.borderColor = UIColor.init(hexString: "#83D1FF")?.cgColor
        self.autoButtons[4].layer.borderColor = UIColor.init(hexString: "#ACB0FF")?.cgColor
        self.autoButtons[5].layer.borderColor = UIColor.init(hexString: "#FEA4FF")?.cgColor
    }
    
    // MARK: - 亮度开关
    @IBAction func BrightSwitchBtnClick(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        let highData = MiniBallManager.shared.contentData1_3[1]/16*16
        let lowData: UInt8 = sender.isSelected ? 1 : 0
        MiniBallManager.shared.contentData1_3[1] = highData + lowData
    }
    
}
