//
//  Catalog.swift
//  MyNotes
//
//  Created by sea on 16/9/19.
//  Copyright © 2016年 sea. All rights reserved.
//  目录 model功能
//  功能：用户自定义文件夹
//

import Foundation

class Catalog:NSObject{
    
    fileprivate var fileData = ["默认"]
    fileprivate var db:FMDatabase? = nil

    //读取本地化的文件夹列表
    func getFolderData() -> Array<FolderModel> {
        let table:tbales = .folderTable
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
    //添加文件夹
    func addFolderData(_ cont:FolderModel) -> Bool {
        let table:tbales = .folderTable
        let sql = "insert into \(table) (title,bg,childerId,time) values(?,?,?,?)"
        var flag:Bool = false
        let quere = DBClient.dbClient.dbQueue
        quere?.inDatabase({ (db) in
            guard (db?.open())! else{
                Tool.log("数据库打开失败")
                return
            }
            flag = (db?.executeUpdate(sql, withArgumentsIn: [cont.title!,cont.bg,cont.childer,cont.time]))!
        })
        guard flag else{
            Tool.log("插入数据失败！")
            return false
        }
        Tool.log("插入数据成功！")
        return flag
    }
    //删除文件夹
    func deleteFolderData(_ id:String) -> Bool {
        let table:tbales = .folderTable
        let sql = "delete  from \(table) where id = \(id)"   //
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
    // 更新文件夹
    func updateFolderData(_ cont:FolderModel) -> Bool {
        let table:tbales = .folderTable
        let sql = "update  \(table) set title = ?,bg = ?,childerId = ?,time = ?  where id = \(cont.key)"
        var flag:Bool = false
        let quere = DBClient.dbClient.dbQueue
        quere?.inDatabase({ (db) in
            guard (db?.open())! else{
                Tool.log("数据库打开失败")
                return
            }
            flag = (db?.executeUpdate(sql, withArgumentsIn: [cont.title!,cont.bg!,cont.childer!,cont.time!]))!
        })
        guard flag else{
            Tool.log("更新数据失败！")
            return false
        }
        Tool.log("更新数据成功！")
        return flag
    }
   
}
