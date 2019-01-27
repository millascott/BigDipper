//
//  YL001DevicesControlVC.swift
//  ProjectDemoSwift
//
//  Created by pingguo on 2019/1/7.
//  Copyright © 2019年 yons. All rights reserved.
//

import UIKit
import MediaPlayer
import SVProgressHUD

class YL001DevicesControlVC: RootViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UITableViewDelegate, UITableViewDataSource, MPMediaPickerControllerDelegate {
    
    
    @IBOutlet weak var contentView: UIView!
    @IBOutlet var modeButtons: [UIButton]!
    
    @IBOutlet weak var colorCollectionView: UICollectionView!
    
    // MARK: 音乐模式下变量
    @IBOutlet var musicModeView: UIView!
    @IBOutlet weak var tableView: UITableView!
    var songItems = [MPMediaItem]()
    let musicPlayer = MPMusicPlayerController.systemMusicPlayer
    
    // MARK: 开关模式下变量
    @IBOutlet var switchModeView: UIView!
    // 自走、声控、手控开关
    @IBOutlet var switches: [UIButton]!
    @IBOutlet weak var autoConstraint: NSLayoutConstraint!
    @IBOutlet weak var voiceConstraint: NSLayoutConstraint!
    @IBOutlet weak var manualConstraint: NSLayoutConstraint!
    
    
    // MARK: 设置模式下变量
    @IBOutlet var settingModeView: UIView!
    @IBOutlet var settingSwitches: [UIButton]!
    
    // 颜色图片和数据数组
    let imageArr = ["red", "rg", "green", "bw", "blue", "op", "white", "gw", "orange", "pb", "pink", "bo", "rw", "gb", "rp"]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.Initialize()
        self.CollectionViewConfig()
        self.TableViewConfig()
        // 开关->自走
        self.ModeBtnClick(self.modeButtons[1])
        self.SwitchModeSwitchClick(self.switches[0])
    }

    private func Initialize() {
        for button in self.modeButtons {
            button.layer.borderColor = UIColor.darkText.cgColor
            button.layer.zPosition = .greatestFiniteMagnitude
        }
    }
    
    // MARK: - 音乐模式
    // 播放、暂停
    @IBAction func PlayPauseBtnClick(_ sender: UIButton) {
        if let indexPath = self.tableView.indexPathForSelectedRow {
            sender.isSelected = !sender.isSelected
            self.musicPlayer.nowPlayingItem = self.songItems[indexPath.row]
            sender.isSelected ? self.musicPlayer.play() : self.musicPlayer.stop()
        } else {
            SVProgressHUD.showError(withStatus: "未选中音乐")
        }
    }
    
    // 上一首
    @IBAction func LastSongBtnClick(_ sender: UIButton) {
        if let indexPath = self.tableView.indexPathForSelectedRow {
            if indexPath.row != 0 {
                self.tableView.selectRow(at: indexPath, animated: true, scrollPosition: .none)
                self.musicPlayer.nowPlayingItem = self.songItems[indexPath.row-1]
            } else {
                self.tableView.selectRow(at: IndexPath.init(row: self.songItems.count-1, section: 0), animated: true, scrollPosition: .bottom)
                self.musicPlayer.nowPlayingItem = self.songItems[self.songItems.count-1]
            }
        }
    }
    
    // 下一首
    @IBAction func NextSongBtnClick(_ sender: UIButton) {
        if let indexPath = self.tableView.indexPathForSelectedRow {
            if indexPath.row != self.songItems.count-1 {
                self.tableView.selectRow(at: indexPath, animated: true, scrollPosition: .none)
                self.musicPlayer.nowPlayingItem = self.songItems[indexPath.row+1]
            } else {
                self.tableView.selectRow(at: IndexPath.init(row: 0, section: 0), animated: true, scrollPosition: .top)
                self.musicPlayer.nowPlayingItem = self.songItems[0]
            }
        }
    }
    
    // MARK: - 开关模式
    // MARK: 自走、声控、手控
    @IBAction func SwitchModeSwitchClick(_ sender: UIButton) {
        if !sender.isSelected {
            for button in self.switches {
                button.isSelected = false
            }
            sender.isSelected = true
            self.autoConstraint.constant = 40
            self.voiceConstraint.constant = 40
            self.manualConstraint.constant = 40
            switch sender.tag {
            case 200:
                self.autoConstraint.constant = 80
                YL001Manager.shared.contentData[1] = 0x01
            case 201:
                self.voiceConstraint.constant = 80
                YL001Manager.shared.contentData[1] = 0x02
            case 202:
                self.manualConstraint.constant = 300
                YL001Manager.shared.contentData[1] = 0x03
            default:
                break
            }
            YL001Manager.shared.SendData(isGroup: false)
        }
    }
    
    // MARK: Slider
    @IBAction func SwitchModeSliderValueChanged(_ sender: UISlider) {
        switch sender.tag {
        case 300: // 激活亮度
            YL001Manager.shared.contentData[5] = UInt8.init(sender.value)
        case 301: // 自走
            YL001Manager.shared.contentData[2] = UInt8.init(sender.value)
        case 302: // 声控
            YL001Manager.shared.contentData[3] = UInt8.init(sender.value)
        default:
            break
        }
        YL001Manager.shared.SendData(isGroup: false)
    }
    
    // MARK: - 设置模式
    @IBAction func SettingSwitchClick(_ sender: UIButton) {
        if !sender.isSelected {
            for button in self.settingSwitches {
                button.isSelected = false
                button.backgroundColor = UIColor.clear
            }
            sender.isSelected = true
            sender.backgroundColor = UIColor.darkText
            
            switch sender.tag {
            case 1000:
                self.songItems = MPMediaQuery.init().items!
                self.musicPlayer.nowPlayingItem = self.songItems[0]
                self.musicPlayer.play()
            case 1001:
                YL001Manager.shared.contentData[0] = 0x01
            case 1002:
                YL001Manager.shared.contentData[5] = 0x00
            case 1003:
                YL001Manager.shared.contentData[0] = 0x00
            default:
                break
            }
            YL001Manager.shared.SendData(isGroup: false)
        }
    }
    
    // MARK: - 音乐、开关、设置之间切换
    @IBAction func ModeBtnClick(_ sender: UIButton) {
        for button in self.modeButtons {
            button.backgroundColor = UIColor.clear
            button.isSelected = false
        }
        sender.backgroundColor = UIColor.darkText
        sender.isSelected = true
        for view in self.contentView.subviews {
            view.removeFromSuperview()
        }
        
        switch sender.tag {
        case 100:
            self.contentView.addSubview(self.musicModeView)
            self.songItems = MPMediaQuery.init().items!
            print("音乐熟练:\(songItems.count)")
            self.tableView.reloadData()
            YL001Manager.shared.contentData[1] = 0x02
            YL001Manager.shared.SendData(isGroup: false)
        case 101:
            self.contentView.addSubview(self.switchModeView)
        case 102:
            self.contentView.addSubview(self.settingModeView)
        default:
            break
        }
    }
    
    // MARK: - CollectionView初始化
    override func CollectionViewConfig() {
        self.colorCollectionView.register(UINib.init(nibName: "YL001DevicesControlCVC", bundle: nil), forCellWithReuseIdentifier: "YL001DevicesControlCVC")
    }
    
    // MARK: - CollectionView的代理
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1;
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 15
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize.init(width: 30, height: 30)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets.init(top: 0, left: 25, bottom: 0, right: 25)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 20
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "YL001DevicesControlCVC", for: indexPath) as! YL001DevicesControlCVC
        cell.imageView.image = UIImage.init(named: self.imageArr[indexPath.item])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as! YL001DevicesControlCVC
        cell.selectedView.isHidden = false
        YL001Manager.shared.contentData[4] = UInt8.init(Float.init(indexPath.item+1))
        YL001Manager.shared.SendData(isGroup: false)
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as! YL001DevicesControlCVC
        cell.selectedView.isHidden = true
    }
    
    // MARK: - 音乐TableView初始化
    override func TableViewConfig() {
        self.tableView.register(UINib.init(nibName: "YL001DevicesControlTVC", bundle: nil), forCellReuseIdentifier: "YL001DevicesControlTVC")
    }
    
    // MARK: - 音乐TableView的代理
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.songItems.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 65
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.1
    }

    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "YL001DevicesControlTVC", for: indexPath) as! YL001DevicesControlTVC
        cell.songItem = self.songItems[indexPath.row]
        return cell
    }
}
