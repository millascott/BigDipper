//
//  String+Properties.swift
//  ProjectDemoSwift
//
//  Created by yons on 2018/10/17.
//  Copyright © 2018年 yons. All rights reserved.
//

import Foundation

extension String {
    
    var intValue: Int {
        return (self as NSString).integerValue
    }
    var floatValue: Float {
        return (self as NSString).floatValue
    }
    var doubleValue: Double {
        return (self as NSString).doubleValue
    }
    var boolValue: Bool {
        return (self as NSString).boolValue
    }
    
    var iaValidChinaPhoneNum: Bool {
        guard self.count == 11 else {
            return false
        }
        
        // 移动
        let regex1 = "^((13[4-9])|(147)|(15[0-2,7-9])|(178)|(18[2-4,7-8]))\\d{8}|(1705)\\d{7}$"
        // 联通
        let regex2 = "^((13[0-2])|(145)|(15[5-6])|(176)|(18[5,6]))\\d{8}|(1709)\\d{7}$"
        // 电信
        let regex3 = "^((133)|(153)|(17[0-9])|(18[0,1,9]))\\d{8}$"
        
        let predicate1 = NSPredicate(format: "SELF MATCHES %@", regex1)
        let match1 = predicate1.evaluate(with: self)
        
        let predicate2 = NSPredicate(format: "SELF MATCHES %@", regex2)
        let match2 = predicate2.evaluate(with: self)
        
        let predicate3 = NSPredicate(format: "SELF MATCHES %@", regex3)
        let match3 = predicate3.evaluate(with: self)
        
        if (match1 || match2 || match3) {
            return true
        } else {
            return false
        }
    }
    
    var isValidEmail: Bool {
        return range(of: "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}",
                     options: .regularExpression, range: nil, locale: nil) != nil
    }
    
    var isValidUrl: Bool {
        return URL(string: self) != nil
    }
    
    
    
    
    //  十六进制String串转Int
    func hexToInt() -> Int {
        var result: UInt32 = 0
        Scanner.init(string: self).scanHexInt32(&result)
        return Int(result)
    }
    
    //  以下标形式访问String元素
    subscript(r: CountableRange<Int>) -> String {
        get {
            let startIndex = self.index(self.startIndex, offsetBy: r.lowerBound)
            let endIndex = self.index(self.startIndex, offsetBy: r.upperBound)
            return String(self[startIndex..<endIndex])
        }
    }
    subscript(r: CountableClosedRange<Int>) -> String {
        get {
            let startIndex = self.index(self.startIndex, offsetBy: r.lowerBound)
            let endIndex = self.index(self.startIndex, offsetBy: r.upperBound)
            return String(self[startIndex...endIndex])
        }
    }
    
    func sub(from: Int) -> String {
        let startIndex = self.index(self.startIndex, offsetBy: from)
        return String(self[startIndex..<self.endIndex])
    }
    
    func sub(to: Int) -> String {
        let endIndex = self.index(self.startIndex, offsetBy: to)
        return String(self[self.startIndex..<endIndex])
    }
    
    func times(n: Int) -> String {
        var sum = ""
        for _ in 0..<n {
            sum += self
        }
        return sum
    }
    
    
    
    
}
