//
//  Filelist.swift
//  MyNotes
//
//  Created by sea on 16/9/29.
//  Copyright © 2016年 sea. All rights reserved.
//

import Foundation
import Alamofire

class FileList: NSObject {
    let http = HttpTool()
    //该请求在后台进行下载网页操作 
    func loadHtml(url:String) -> Bool {
        
        http.requestWithUrl(type: .get, url: url, parameters: nil, success: {(data) in
            
            }) { (e) in
                Tool.log(e)
                
        }
        return true
    }
}
