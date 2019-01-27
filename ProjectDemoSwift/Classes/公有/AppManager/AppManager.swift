//
//  AppManager.swift
//  ProjectDemoSwift
//
//  Created by yons on 2018/10/17.
//  Copyright © 2018年 yons. All rights reserved.
//

import Foundation
import UIKit
import Reachability

class AppManager {
    static let shared = AppManager()
    
    let reachability = Reachability.init()!
    
    var HomeNavigation: RootNavigationController? = nil
    var currentNavigation: RootNavigationController? = nil
    var currentViewController: RootViewController? = nil

    init() {
        let _ = self.GetPhotoAlbumIPC()
        let _ = self.GetCameraIPC(type: 2)
    }
    
    // MARK:- 在window上弹出广告页
    func PresentAdvertisement() -> Void {
        let adverView = AdvertisementView.init(frame: G_ScreenBounds) {}
        G_KeyWindow?.addSubview(adverView)
        G_KeyWindow?.bringSubviewToFront(adverView)
    }
    
    // MARK:- 相册或相机
    // 相册
    func GetPhotoAlbumIPC() -> UIImagePickerController {
        return self.photoAlbumIPC
    }
    
    //  相机 type 0照片 1视频 2照片和视频
    func GetCameraIPC(type: Int) -> UIImagePickerController {
        let ipc = self.cameraIPC
        
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            if (type != 2) {
                var mediaTypes = UIImagePickerController.availableMediaTypes(for: .camera)!
                ipc.mediaTypes = [mediaTypes[type]]
            } else {
                ipc.mediaTypes = UIImagePickerController.availableMediaTypes(for: .camera)!
            }
        }
        return ipc
    }
    
    
    private lazy var photoAlbumIPC: UIImagePickerController = {
        let ipc = UIImagePickerController.init()
        
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
            ipc.sourceType = .photoLibrary
            // 如果设置为ipc.sourceType的话会影响弹出速度
            ipc.mediaTypes = UIImagePickerController.availableMediaTypes(for: .photoLibrary)!
        }
        ipc.allowsEditing = true
        return ipc
    }()
    
    private lazy var cameraIPC: UIImagePickerController = {
        let ipc = UIImagePickerController.init()
        
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            ipc.sourceType = .camera
        }
        ipc.allowsEditing = true
        
        if UIDevice.current.systemVersion.floatValue >= 8.0 {
            ipc.modalPresentationStyle = .overCurrentContext
        }
        
        return ipc
    }()

}
