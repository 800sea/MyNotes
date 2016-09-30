//
//  DBClient.swift
//  MyNotes
//
//  Created by sea on 16/9/23.
//  Copyright © 2016年 sea. All rights reserved.
//

import Foundation

enum tbales:String {
    case folderTable = "folder"
    case fileList    = "file"
}

class DBClient: NSObject {
    
    var dbQueue:FMDatabaseQueue?
    static let dbClient = DBClient()
    
    fileprivate override init(){
        super.init()
        //var path = NSSearchPathForDirectoriesInDomains(.documentationDirectory,.userDomainMask, true).first
        // 问题： 使用path 路径不行  不知道为啥
        let file = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false).appendingPathComponent("\(myNotes.identifier).sqlite")
        
        guard let queue = FMDatabaseQueue(path: file.path)
            else{
                Tool.log("创建FMDatabaseQueue 失败")
                return
        }
        dbQueue = queue
        guard tableDataInit(queue: queue) else{
            return
        }
    
    }
    //数据初始化
    func tableDataInit(queue:FMDatabaseQueue) -> Bool {
        queue.inDatabase({ (db) in
            guard (db?.open())! else{
                Tool.log("数据库打开失败")
                return
            }
            // 数据库操作
           //分类表
            if !db!.tableExists(tbales.folderTable.rawValue){
                // 创建表
                let sql1 = "create table if not exists \(tbales.folderTable)(id integer primary key,title text, bg text, childerId text, time text)"
                let temp = db?.executeUpdate(sql1, withArgumentsIn: nil)
                if temp! {
                    Tool.log("创建\(tbales.folderTable)表成功！")
                }else{
                    Tool.log("创建\(tbales.folderTable)表失败！\(errno)")
                }
            }else{
                Tool.log("数据库已经存在!")
            }
            // 对应文件内容表
            if !db!.tableExists(tbales.fileList.rawValue){
                // 创建表
                let sql2 = "create table if not exists \(tbales.fileList)(id integer primary key,title text, cont text,url text,fileTime text,updateTime text)"
                let temp2 = db?.executeUpdate(sql2, withArgumentsIn: nil)
                if temp2!{
                    Tool.log("创建\(tbales.fileList)表成功！")
                }else{
                    Tool.log("创建\(tbales.fileList)表成功！\(errno)")
                }
            }
        })
        return true
    }
   

}
