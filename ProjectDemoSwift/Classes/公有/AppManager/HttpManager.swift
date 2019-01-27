//
//  HttpManager.swift
//  ProjectDemoSwift
//
//  Created by yons on 2018/10/25.
//  Copyright © 2018年 yons. All rights reserved.
//

import Foundation
import UIKit
import Alamofire
import SwiftyJSON

// 上传图片使用
struct Picture {
    var name: String
    var image: UIImage
}

class HttpManager {
    static func Get(url: URLConvertible, parameters: Parameters?, successClosure: @escaping (JSON) throws ->(), failureClosure:@escaping (Error)->()) -> Void {
        Alamofire.request(url, method: .get, parameters: parameters).responseJSON { (response) in
            switch response.result
            {
            case .success(let value):
                let json = JSON.init(value)
                print(json)
                do {
                    try successClosure(json)
                } catch let error {
                    print(error)
                }
            case .failure(let error):
                print("请求失败:\(error)")
                failureClosure(error)
            }
        }
    }
    
    static func Post(url: URLConvertible, parameters: [String: String]?, pictureArr: [Picture], successClosure: @escaping (JSON) throws ->(), failureClosure:@escaping (Error)->()) -> Void {
        Alamofire.upload(multipartFormData: { (formData) in
            for i in 0..<pictureArr.count {
                let picture = pictureArr[i]
                let data = picture.image.pngData()!
                formData.append(data, withName: picture.name, fileName: "\(i).png", mimeType: "image/png")
            }
            if let params = parameters {
                for (key, value) in params {
                    formData.append(value.data(using: .utf8)!, withName: key)
                }
            }
        }, to: url) { (encodingResult) in
            switch encodingResult {
            case .success(request: let request, streamingFromDisk: _, streamFileURL: _):
                request.responseJSON(completionHandler: { (response) in
                    switch response.result {
                    case .success(let value):
                        let json = JSON.init(value)
                        print(json)
                        do {
                            try successClosure(json)
                        } catch let error {
                            print(error)
                        }
                    case .failure(let error):
                        print("请求失败：\(error)")
                        failureClosure(error)
                    }
                })
                break;
            case .failure(let error):
                print(error)
                break;
            }
        }
    }
}
