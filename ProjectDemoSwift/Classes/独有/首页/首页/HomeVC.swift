//
//  HomeVC.swift
//  ProjectDemoSwift
//
//  Created by pingguo on 2018/12/28.
//  Copyright © 2018年 yons. All rights reserved.
//

import UIKit

class HomeVC: RootViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    
    @IBOutlet weak var topView: UIView!
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var homeSideView: HomeSideView? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.NavigationBarConfig()
        self.CycleScrollViewConfig()
        self.CollectionViewConfig()
        self.HomeSideViewConfig()
    }
    
    // MARK: - NavigationBar初始化
    func NavigationBarConfig() {
        let label = UILabel.init(title: "首页", font: UIFont.systemFont(ofSize: 22, weight: .bold))
        self.navigationItem.leftBarButtonItem = UIBarButtonItem.init(customView: label)
        self.navigationItem.rightBarButtonItem = UIBarButtonItem.init(image: UIImage.init(named: "home_more_icon"), style: .done, target: self, action: #selector(MoreBtnClick))
    }
    
    // MARK: 导航栏"更多"
    @objc func MoreBtnClick() {
        let popAlert = PopAlert.init()
        popAlert.LoadBackground()
        let button = UIButton.init()
        popAlert.background.addSubview(button)
        button.snp.makeConstraints { (make) in
            make.left.right.top.bottom.equalTo(0)
        }
        
        popAlert.background.addSubview(self.homeSideView!)
        self.homeSideView?.frame = CGRect.init(x: G_ScreenW, y: 0, width: 170, height: G_ScreenH)
        UIView.animate(withDuration: popAlert.animateRate) {
            self.homeSideView?.frame = CGRect.init(x: G_ScreenW-170, y: 0, width: 170, height: G_ScreenH)
        }
        
        button.reactive.controlEvents(.touchUpInside).observeValues { (button) in
            UIView.animate(withDuration: popAlert.animateRate, animations: {
                self.homeSideView?.frame = CGRect.init(x: G_ScreenW, y: 0, width: 170, height: G_ScreenH)
            })
            popAlert.RemoveBackground()
        }
    }
    
    // MARK: - HomeSide初始化
    func HomeSideViewConfig() {
        self.homeSideView = Bundle.main.loadNibNamed("HomeSideView", owner: nil, options: nil)?.last as? HomeSideView
    }

    // MARK: - cycleScrollView初始化
    func CycleScrollViewConfig() {
        let cycleScrollView = SDCycleScrollView.init(frame: CGRect.init(x: 0, y: 0, width: G_ScreenW, height: G_ScreenW/15*8), imageNamesGroup: ["home_banner_a_img", "home_banner_b_img", "home_banner_c_img"])!
        cycleScrollView.autoScroll = false
        cycleScrollView.backgroundColor = UIColor.init(hexString: "F8F8F8")
        self.topView.addSubview(cycleScrollView)
    }

    // MARK: - CollectionView初始化
    override func CollectionViewConfig() {
        self.collectionView.register(UINib.init(nibName: "HomeCVC", bundle: nil), forCellWithReuseIdentifier: "HomeCVC")
    }
    
    // MARK: - CollectionView的代理
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets.init(top: 0, left: 12, bottom: 0, right: 12)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize.init(width: (G_ScreenW-35)/2, height: (G_ScreenW-35)/2/170*100)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HomeCVC", for: indexPath) as! HomeCVC
        HomeManager.CellConfig(cell: cell, indexPath: indexPath)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        HomeManager.CellDidSelect(indexPath: indexPath)
    }
    
}
