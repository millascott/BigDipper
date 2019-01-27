//
//  UIImageView+URL.swift
//  ProjectDemoSwift
//
//  Created by yons on 2018/10/29.
//  Copyright © 2018年 yons. All rights reserved.
//

import Foundation
import Alamofire


extension UIImageView {
    func SetImageWith(url: URLConvertible, placeHolder: UIImage?) -> Void {
        self.image = placeHolder
        Alamofire.request(url).responseData { (response) in
            if let data = response.result.value {
                if let image = UIImage.init(data: data) {
                    self.image = image
                } else {
                    self.image = placeHolder
                }
            } else {
                self.image = placeHolder
            }
        }
    }
}
