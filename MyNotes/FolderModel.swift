//
//  FolderModel.swift
//  MyNotes
//
//  Created by sea on 16/9/22.
//  Copyright © 2016年 sea. All rights reserved.
//

import Foundation

// Folder的数据模型
struct FolderModel {
    var key:String?  = ""
    var title:String? = ""
    var bg:String? = ""
    var childer:String? = ""
    var time:Date?
}

// File 的数据模型
struct FileModel {
    var key:String = ""
    var title:String = ""
    var cont:String = ""
    var url:String = ""
    var fileTime:Date? = nil
    var updateTime:Date? = nil
    
}
