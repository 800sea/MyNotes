//
//  CatalogCollectionViewCell.swift
//  MyNotes
//
//  Created by sea on 16/9/19.
//  Copyright © 2016年 sea. All rights reserved.
//

import UIKit

private var myContext = ""
class CatalogCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var image: UIImageView!    
    @IBOutlet weak var titleText: UITextField!
    fileprivate var deleteBg:UIImageView?
    open var cellStyle:cellStyles = .cellDefault
    //当前cell是否是可编辑状态
    open var cellIsEdit:Bool = false{
        didSet{
            if cellIsEdit == true {
                titleText.isEnabled = true
                titleText.borderStyle = .roundedRect
            }else{
                titleText.isEnabled = false
                titleText.borderStyle = .none
            }
        }
    }
    //cell的2中类型
    enum cellStyles:String {
        case cellCustom   // 用户添加的
        case cellDefault  // 默认点击添加的cell
    }

    //默认是0
    open var cellIndex = 0
    open var dataModel:FolderModel?{
        didSet{
            if titleText.text != dataModel?.title!{
                titleText.text = dataModel?.title!
            }
        }
    }
    //MARK:添加接受通知
    func addListen(){
         NotificationCenter.default.addObserver(self, selector: #selector(changeCellStyle(not:)), name: NSNotification.Name(rawValue: CatalogViewController.cellStyleNotification.name), object: nil)
    }
    func changeCellStyle(not:NSNotification) {
        let str = not.userInfo?[CatalogViewController.cellStyleNotification.infoKey]
        //接到 编辑的通知  cell进入编辑状态
        if  String(describing: str!) == "edit" {
            cellIsEdit = true
        }else{
            cellIsEdit = false
            
        }
    }
    
    open func setCellStyle(_ value:cellStyles){
        cellStyle = value
    }
    // cell删除时的动画效果
    open func deleteStyle(){
        
        deleteBg = UIImageView.init(image: UIImage(named: "deletePic"))
        // 默认的添加文件夹cell 不能被删除
        if cellIndex != 0 {
            
        }
    }
}
