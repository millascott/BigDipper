//
//  YT01DevicesControlVC.swift
//  ProjectDemoSwift
//
//  Created by pingguo on 2018/12/29.
//  Copyright © 2018年 yons. All rights reserved.
//

import UIKit

class YT01DevicesControlVC: RootViewController {
    
    
    @IBOutlet weak var contentView: UIView!
    @IBOutlet var modeButtons: [UIButton]!
    @IBOutlet weak var colorfulSwitch: UIButton!
    @IBOutlet weak var colorfulSlider: UISlider!
    @IBOutlet weak var whiteSwitch: UIButton!
    @IBOutlet weak var whiteSlider: UISlider!
    
    // MARK: 自动模式下变量
    @IBOutlet var autoView: UIView!
    @IBOutlet var autoColorButtons: [UIButton]!
      // 最少为1, 不能所有颜色都不选
    var autoColorSelectedCount = 1
      // 各种效果对应的数字加起来
    var autoSelectedData: UInt8 = 0x01
    
    // MARK: 手动模式下变量
    @IBOutlet var manualScrollView: UIScrollView!
    @IBOutlet var manualTypeButtons: [UIButton]!
    @IBOutlet var manualSliders: [UISlider]!
      // 选择颜色后的勾勾
    let tikView = UIImageView.init(image: UIImage.init(named: "equ_mark_png"))
    
    // MARK: 声控模式下变量
    @IBOutlet var voiceView: UIView!
    @IBOutlet weak var sensitiveSlider: UISlider!
    
    
    // MARK: -
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.Initialize()
        self.ModeBtnClick(self.modeButtons[0])
        self.view.addSubview(self.tikView)
        self.tikView.isHidden = true
    }
    
    func Initialize() {
        for button in self.modeButtons {
            button.layer.borderColor = UIColor.darkText.cgColor
        }
        self.autoColorButtons[0].layer.borderColor = UIColor.init(hexString: "#FF601A")?.cgColor
        self.autoColorButtons[1].layer.borderColor = UIColor.init(hexString: "#FFB417")?.cgColor
        self.autoColorButtons[2].layer.borderColor = UIColor.init(hexString: "#83D1FF")?.cgColor
        self.autoColorButtons[3].layer.borderColor = UIColor.init(hexString: "#ACB0FF")?.cgColor
    }
    
    // MARK: - 自动模式
    
    // MARK: 色彩
    @IBAction func AutoColorBtnClick(_ sender: UIButton) {
        // 不能取消最后一个选择
        if sender.isSelected && self.autoColorSelectedCount == 1 {
            return
        }
        
        sender.isSelected = !sender.isSelected
        if sender.isSelected {
            sender.backgroundColor = UIColor.init(cgColor: sender.layer.borderColor!)
            self.autoColorSelectedCount += 1
        } else {
            sender.backgroundColor = UIColor.clear
            self.autoColorSelectedCount -= 1
        }
        // 转Int8可以做减法
        var data = Int8.init(bitPattern: self.autoSelectedData)
        switch sender.tag {
        case 1000:  // 多彩渐变
            data += sender.isSelected ? 0x01 : -0x01
        case 1001:  // 多彩呼吸
            data += sender.isSelected ? 0x02 : -0x02
        case 1002:  // 多彩跳变
            data += sender.isSelected ? 0x04 : -0x04
        case 1003:  // 多彩脉动(突变)
            data += sender.isSelected ? 0x08 : -0x08
        default:
            break
        }
        self.autoSelectedData = UInt8.init(bitPattern: data)
        YT01Manager.shared.contentData[4] = self.autoSelectedData
        YT01Manager.shared.SendData(isGroup: false)
    }
    
    // MARK: - 手动模式
    
    // MARK: 呼吸、频闪、跳变开关
    @IBAction func ManualTypeBtnSwitch(_ sender: UIButton) {
        let highData = YT01Manager.shared.contentData[2]/16*16
        if !sender.isSelected {
            for button in self.manualTypeButtons {
                button.isSelected = false
            }
            sender.isSelected = true
            switch sender.tag {
            case 2000:
                YT01Manager.shared.contentData[2] = highData+0x03
            case 2001:
                YT01Manager.shared.contentData[2] = highData+0x02
            case 2002:
                YT01Manager.shared.contentData[2] = highData+0x04
            default:
                break
            }
        } else {
            sender.isSelected = false
            YT01Manager.shared.contentData[2] = highData+0x01
        }
        self.UpdateManualRateData()
        YT01Manager.shared.SendData(isGroup: false)
    }
    
    // MARK: 呼吸、频闪、跳变的速度调节
    @IBAction func ManualSliderValueChanged(_ sender: UISlider) {
        let lowData3 = YT01Manager.shared.contentData[2]%16
        let lowData4 = YT01Manager.shared.contentData[3]%16
        let highData4 = YT01Manager.shared.contentData[3]/16*16
        switch sender.tag {
        case 3000:  // 呼吸
            YT01Manager.shared.contentData[3] = highData4 + UInt8.init(sender.value)
        case 3001:  // 频闪
            YT01Manager.shared.contentData[2] = lowData3 + UInt8.init(sender.value)*16
        case 3002:  // 跳变
            YT01Manager.shared.contentData[3] = lowData4 + UInt8.init(sender.value)*16
        default:
            break
        }
        if self.manualTypeButtons[sender.tag-3000].isSelected {
            YT01Manager.shared.SendData(isGroup: false)
        }
    }
    
    // MARK: 颜色选择
    @IBAction func ManualColorSelected(_ sender: UIButton) {
        let lowData2 = YT01Manager.shared.contentData[1]%16
        YT01Manager.shared.contentData[1] = lowData2 + UInt8.init(Float.init(sender.tag-4000))*16
        YT01Manager.shared.SendData(isGroup: false)
        self.tikView.isHidden = false
        self.tikView.snp.remakeConstraints { (make) in
            make.center.equalTo(sender)
        }
    }
    
    // 直接更新手动模式下速度的数据(不发送)
    private func UpdateManualRateData() {
        let lowData3 = YT01Manager.shared.contentData[2]%16
        let lowData4 = YT01Manager.shared.contentData[3]%16
        let highData4 = YT01Manager.shared.contentData[3]/16*16
        // 呼吸
        YT01Manager.shared.contentData[3] = highData4 + UInt8.init(self.manualSliders[0].value)
        // 频闪
        YT01Manager.shared.contentData[2] = lowData3 + UInt8.init(self.manualSliders[1].value)*16
        // 跳变
        YT01Manager.shared.contentData[3] = lowData4 + UInt8.init(self.manualSliders[2].value)*16
    }
    
    // MARK: - 声控模式
    @IBAction func SensitiveSliderValueChanged(_ sender: UISlider) {
        YT01Manager.shared.contentData[6] = UInt8.init(sender.value)
        YT01Manager.shared.SendData(isGroup: false)
    }
    
    
    // MARK: - 自动、手动、声控
    @IBAction func ModeBtnClick(_ sender: UIButton) {
        for button in self.modeButtons {
            button.backgroundColor = UIColor.white
            button.setTitleColor(UIColor.darkText, for: .normal)
        }
        sender.backgroundColor = UIColor.darkText
        sender.setTitleColor(UIColor.white, for: .normal)
        
        for view in self.contentView.subviews {
            view.removeFromSuperview()
        }
        
        // 截取高4位数字
        let highData = YT01Manager.shared.contentData[1]/16*16
        switch sender.tag {
        case 100:
            self.contentView.addSubview(self.autoView)
            self.autoView.snp.makeConstraints { (make) in
                make.left.right.top.bottom.equalTo(0)
            }
            YT01Manager.shared.contentData[1] = highData+0x01
            self.tikView.isHidden = true
        case 101:
            self.contentView.addSubview(self.manualScrollView)
            self.manualScrollView.snp.makeConstraints { (make) in
                make.left.right.top.bottom.equalTo(0)
            }
            YT01Manager.shared.contentData[1] = highData+0x03
            self.tikView.isHidden = false
        case 102:
            self.contentView.addSubview(self.voiceView)
            self.voiceView.snp.makeConstraints { (make) in
                make.left.right.top.bottom.equalTo(0)
            }
            YT01Manager.shared.contentData[1] = highData+0x02
            YT01Manager.shared.contentData[6] = UInt8.init(self.sensitiveSlider.value)
            self.tikView.isHidden = true
        default:
            break
        }
        YT01Manager.shared.SendData(isGroup: false)
    }
    
    // MARK: 彩灯、常规灯开关
    @IBAction func ColorfulWhiteSwitchClick(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        let lowData: UInt8 = self.colorfulSwitch.isSelected ? 0x01 : 0x00
        let highData: UInt8 = self.whiteSwitch.isSelected ? 0x10 : 0x00
        YT01Manager.shared.contentData[0] = lowData + highData
        YT01Manager.shared.SendData(isGroup: false)
    }
    
    // MARK: 彩灯、常规灯强度
    @IBAction func ColorfulWhiteSliderValueChanged(_ sender: UISlider) {
        self.UpdateColorfulWhiteData()
        YT01Manager.shared.SendData(isGroup: false)
    }
    
    // 直接更新两者强度
    private func UpdateColorfulWhiteData() {
        YT01Manager.shared.contentData[7] = UInt8.init(self.colorfulSlider.value)
        YT01Manager.shared.contentData[8] = UInt8.init(self.whiteSlider.value)
    }
    
}
