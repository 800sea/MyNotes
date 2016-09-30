//
//  FileManage.swift
//  MyNotes
//
//  Created by sea on 16/9/29.
//  Copyright © 2016年 sea. All rights reserved.
//  文件操作 文件的读写更新等操作

import Foundation

class FileManage: NSObject {
    
    //library文档目录
    let documentPath = NSHomeDirectory() + "/Documents"
    //MARK:文件夹创建
    func creatFolder(path:String) -> Bool {
        
        return true
    }
    
    //MARK:文件新建
    func creatFile(path:String) -> Bool {
        
        return true
    }
    
    //MARK:文件删除
    func deleteFile(path:String) -> Bool {
        
        return true
    }
    
    //MARK:文件更新
    func updateFile(path:String) -> Bool {
        
        return true
    }
}
