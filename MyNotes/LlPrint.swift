//
//  LlPrint.swift
//  MyNotes
//
//  Created by sea on 16/9/20.
//  Copyright © 2016年 sea. All rights reserved.
//

import Foundation
import UIKit
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
}

struct myNotes {
    static let identifier = "myNotes_sea"
}


