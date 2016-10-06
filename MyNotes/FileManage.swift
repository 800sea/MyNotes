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
    static let documentPath = NSHomeDirectory() + "/Documents"
    //MARK:文件夹创建
    func creatFolder(path:String) -> Bool {
        
        return true
    }
    
    
    //MARK:文件新建
    func creatHtmlFile(name:String,data:String) -> String? {
        let path = Tool.MD5Str(str: name) + ".html"
        let file = NSURL.fileURL(withPath: (FileManage.documentPath+"/"+path))
        //Tool.log(file)
        do {
            try data.write(to: file, atomically: true, encoding: String.Encoding.utf8)
        } catch {
            Tool.log("写入错误")
            return nil
        }
        
        return path
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
