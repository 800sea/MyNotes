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
        let iconView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: 100, height: 20))
        iconView.backgroundColor = UIColor.black
        
        
        let superView = self.view.subviews[0]
        superView.addSubview(iconView)
        ////Tool.log(superView.subviews)
       // iconView.translatesAutoresizingMaskIntoConstraints = false

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
