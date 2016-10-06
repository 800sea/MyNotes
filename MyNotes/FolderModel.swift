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
// key 关键字
// cont 网页的本地路径
// url 网络路径
// fileTime 内容创建时间
// updateTime 最新的内容更新时间
// parentId 父级folder目录的id
// remark 用户编辑的内容

struct FileModel {
    var key:String! = ""
    var title:String = ""
    var cont:String = ""
    var url:String = ""
    var fileTime:Date? = nil
    var updateTime:Date? = nil
    var parentId:String = ""
    var remark:String = ""
}
