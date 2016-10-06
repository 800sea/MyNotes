//
//  CatalogCollectionViewCell.swift
//  MyNotes
//
//  Created by sea on 16/9/19.
//  Copyright © 2016年 sea. All rights reserved.
//

import UIKit

class CatalogCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var title: UILabel!
    
    fileprivate var deleteBg:UIImageView?
   // private var cellState:
    open var cellStyle:cellStyles = .cellDefault
    
    
    enum cellStyles:String {
        case cellCustom
        case cellDefault
    }
    //默认是0
    open var cellIndex = 0
    open var dataModel:FolderModel?{
        didSet{
            title.text = dataModel?.title!
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
            //执行删除动画
           // let btn = UIButton.init(frame: CGRect.init(x: 0, y: 0, width: 50, height: 50))
            
            //self.addSubview(btn)
            //btn.addTarget(self, action: #selector(delete(_:)), for: .touchUpInside)
           // deleteBg?.contentMode = .scaleAspectFit
            //deleteBg?.backgroundColor = UIColor.black
           // deleteBg.sizeThatFits(CGSize.init(width: 50, height: 50))
            //deleteBg?.bounds = CGRect.init(x: 0, y: 0, width: 500, height: 500)
//            deleteBg.mas_makeConstraints({ (mark) in
//                mark?.center.equalTo(deleteBg);
//                mark.sizeThatFits(self.bounds.size)
//                
//            })
            
//            let top  = NSLayoutConstraint.init(item: deleteBg, attribute: .top, relatedBy: .equal, toItem: self, attribute: .top, multiplier: 1, constant: 0)
//            let left = NSLayoutConstraint.init(item: deleteBg, attribute: .left, relatedBy: .equal, toItem: self, attribute: .leading, multiplier: 1, constant: 0)
//            let bottom = NSLayoutConstraint.init(item: deleteBg, attribute: .bottom, relatedBy: .greaterThanOrEqual, toItem: self, attribute: .bottom, multiplier: 1, constant: 0)
//            let right = NSLayoutConstraint.init(item: deleteBg, attribute: .right, relatedBy: .greaterThanOrEqual, toItem: self, attribute: .right, multiplier: 1, constant: 0)
//            
//            top.isActive = true
//            left.isActive = true
//            bottom.isActive = true
//            right.isActive = true
            
        }
    }
    
    func delete() {
        
    }
    
}