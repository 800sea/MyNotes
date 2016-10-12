//
//  TextEditorViewController.swift
//  MyNotes
//
//  Created by sea on 16/10/7.
//  Copyright © 2016年 sea. All rights reserved.
//

import UIKit


class TextEditorViewController: UIViewController,UITextViewDelegate{

    //内容
    @IBOutlet weak var contView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = Tool.getBgColor(.A)
        contView.backgroundColor = UIColor.clear
        //继承UIScrollView的控件都会受到UIViewController的这个automaticallyAdjustsScrollViewInsets属性的影响.
        // 默认为YES,
        //当有navigationbar的时候,UITextView的表现就是上面空白.
        // 设为NO,UITextView就正常了.
        self.automaticallyAdjustsScrollViewInsets = false
        contView.delegate = self
    }
    //MARK:保存
    @IBAction func saveFuc(_ sender: UIButton) {
        contView.resignFirstResponder()
        
    }
    //点击空白处键盘消失
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        contView.resignFirstResponder()
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
