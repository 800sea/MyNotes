//
//  FolderTable.swift
//  MyNotes
//
//  Created by sea on 16/9/25.
//  Copyright © 2016年 sea. All rights reserved.
//

import Foundation

class FolderTable: NSObject {
    
    //读取本地化的文件夹列表
    func getFolderData() -> Array<FileModel> {
       // let data = DBManager.selectTable(.fileList, para: "")
        let table:tbales = .fileList
        let sql = "select * from \(table)"
        var dataArr = Array<FileModel>()
        let quere = DBClient.dbClient.dbQueue
        quere?.inDatabase({ (db) in
            guard (db?.open())! else{
                Tool.log("数据库打开失败")
                return
            }
            if let rs = db?.executeQuery(sql, withArgumentsIn: nil){
                while rs.next(){
                     let data = FileModel(key: rs.string(forColumn: "id"), title: rs.string(forColumn: "title"), cont: "", url: "", fileTime: nil, updateTime: nil)
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
    func addFolderData(_ cont:FileModel) -> Bool {
        let table:tbales = .fileList
        let sql = "insert into \(table) (title,cont,url,fileTime,updateTime) values(?,?,?,?,?)"
        var flag:Bool = false
        let quere = DBClient.dbClient.dbQueue
        quere?.inDatabase({ (db) in
            guard (db?.open())! else{
                Tool.log("数据库打开失败")
                return
            }
            flag = (db?.executeUpdate(sql, withArgumentsIn: [cont.title,cont.cont,cont.url,cont.fileTime,cont.updateTime]))!
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
       // let temp = DBManager.deleteData(id, table: .fileList)
        return true
    }
    // 更新文件夹
    func updateFolderData(_ cont:FileModel) -> Bool {
        return true
    }

}
