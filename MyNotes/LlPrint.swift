//
//  LlPrint.swift
//  MyNotes
//
//  Created by sea on 16/9/20.
//  Copyright © 2016年 sea. All rights reserved.
//

import Foundation
import UIKit

extension String{
    var md5:String{
        
        let str = self.cString(using: String.Encoding.utf8)
        let strLen = CC_LONG(self.lengthOfBytes(using: String.Encoding.utf8))
        let digestLen = Int(CC_MD5_DIGEST_LENGTH)
        let result = UnsafeMutablePointer<CUnsignedChar>.allocate(capacity: digestLen);
        
        CC_MD5(str!, strLen, result);
        
        let hash = NSMutableString();
        for i in 0 ..< digestLen {
            hash.appendFormat("%02x", result[i]);
        }
        result.deinitialize();
        
        return String(format: hash as String)
    }
    
}

class Tool: NSObject {
    class func log<T>(_ message:T){
        print(message)
    }
    
    //多种背景的图片地址
    enum bgColor:String {
        case A = "bg"// UIColor.init(patternImage: UIImage.init(named: "bg")!)
        case B = "bg1"
    }
    

    class func getBgColor(_ color:bgColor) -> UIColor{
       return UIColor.init(patternImage: UIImage.init(named: color.rawValue)!)
    }
    //获取当前系统的版本
    class func getVersionIos() -> String{
        let a = UIDevice.current.systemVersion
        return a
    }
    //生成加密后的文件名  因为文件名中带有/等
    class func MD5Str(str:String) -> String {
        return str.md5
    }
}

struct myNotes {
    static let identifier = "myNotes_sea"
}


