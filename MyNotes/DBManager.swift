//
//  DBManager.swift
//  MyNotes
//
//  Created by sea on 16/9/21.
//  Copyright © 2016年 sea. All rights reserved.
//  数据库操作

import Foundation

enum tbales:String {
    case folderTable = "folder"
    case fileList    = "file"
}

class DBManager: NSObject {

    //查询操作
    class func selectTable(_ table:tbales,para:String) -> Array<FolderModel> {
        let sql = "select * from \(table)"
        var dataArr = Array<FolderModel>()
        let quere = DBClient.dbClient.dbQueue
        quere?.inDatabase({ (db) in
            guard (db?.open())! else{
                Tool.log("数据库打开失败")
                return
            }
            if let rs = db?.executeQuery(sql, withArgumentsIn: nil){
                while rs.next(){
                    let data = FolderModel(key: rs.string(forColumn: "id"),
                                           title:  rs.string(forColumn: "title"),
                                           bg:  rs.string(forColumn: "bg"),
                                           childer:  rs.string(forColumn: "childerId"),
                                           time:  rs.date(forColumn: "time")
                    )
                    dataArr.append(data)
                }
            }else{
                Tool.log("查询出错！")
            }
            
        })
        Tool.log(dataArr)
        return dataArr
    }
    
    // 插入数据
    class func insterData(_ data:FolderModel,table:tbales) -> Bool {
        let sql = "insert into \(table) (title,bg,childerId,time) values(?,?,?,?)"
        var flag:Bool = false
        let quere = DBClient.dbClient.dbQueue
        quere?.inDatabase({ (db) in
            guard (db?.open())! else{
                Tool.log("数据库打开失败")
                return
            }
            flag = (db?.executeUpdate(sql, withArgumentsIn: [data.title,data.bg,data.childer,data.time]))!
        })
        guard flag else{
            Tool.log("插入数据失败！")
            return false
        }
        Tool.log("插入数据成功！")
        return flag
    }
    // 删除数据
    class func deleteData(_ key:String,table:tbales) -> Bool {
        let sql = "delete  from \(table) where id = \(key)"   //
        var flag:Bool = false
        let quere = DBClient.dbClient.dbQueue
        quere?.inDatabase({ (db) in
            guard (db?.open())! else{
                Tool.log("数据库打开失败")
                return
            }
            flag = (db?.executeUpdate(sql, withArgumentsIn: nil))!
        })
        guard flag else{
            Tool.log("删除数据失败！")
            return false
        }
        Tool.log("删除数据成功！")
        return flag

        
    }
    
    // 更新数据
    class func updateData(key:String,table:tbales) -> Bool{
        
        return true
    }
    
}



