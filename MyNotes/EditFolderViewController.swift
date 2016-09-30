//
//  AddFolderViewController.swift
//  MyNotes
//
//  Created by sea on 16/9/20.
//  Copyright © 2016年 sea. All rights reserved.
//   AlertContriller 设置添加的文件夹

import UIKit

class EditFolderViewController: UIAlertController {

    override func viewDidLoad() {
        super.viewDidLoad()
       // setContentUi()
        // Do any additional setup after loading the view.
    }
    // 原计划添加一个 选择背景的色块  但自定义alterView 失败  后面再试
    func setContentUi() {
        let a = UIView.init(frame: CGRect.init(x: 0, y: 0, width: 20, height: 20))
        a.backgroundColor = UIColor.black
        
        
        let superView = self.view.subviews[0]
        superView.addSubview(a)
        Tool.log(superView.subviews)
        //为理解autolayout 使用手动代码布局
        let topConstraint = NSLayoutConstraint.init(item: a, attribute: .top, relatedBy: .equal, toItem: superView, attribute: .centerY, multiplier: 1, constant: 0)
        let leftConstrint = NSLayoutConstraint.init(item: a, attribute: .centerX, relatedBy: .equal, toItem: superView, attribute: .centerX, multiplier: 1, constant: 0)
        
        
        topConstraint.isActive = true
        leftConstrint.isActive = true
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
