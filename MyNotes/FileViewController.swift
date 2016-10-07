//
//  FileViewController.swift
//  MyNotes
//
//  Created by sea on 16/9/27.
//  Copyright © 2016年 sea. All rights reserved.
//

import UIKit

class FileViewController: UIViewController,UITextViewDelegate {

    @IBOutlet weak var loadingView: UIActivityIndicatorView!
    
    var webView = UIWebView()
    var fileData = FileModel()
    let folder = FolderTable()
    
    var selectNum = 0;//查询测次数
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = fileData.title
        // 判断当前view的html 是否已经生成
        selectData(mode: fileData)
        loadingView.hidesWhenStopped = true
        let note = NoteView.init(frame: CGRect.init(x:  self.view.bounds.width-30, y: self.view.bounds.width, width: 60, height: 60))
        
//        let  a = NSLayoutConstraint.constraints(withVisualFormat: <#T##String#>, options: <#T##NSLayoutFormatOptions#>, metrics: <#T##[String : Any]?#>, views: <#T##[String : Any]#>)
        
        self.view.addSubview(note)
        
    }
    
    func selectData(mode:FileModel){
        selectNum += 1
        if mode.cont != "" {
            creatWebView()
        }else{
            fileData = folder.getTagetFolderData(mode: fileData)[0]
            self.selectData(mode: fileData)
        }
        //如果请求3次还是空 就不查找了
        guard selectNum > 3 else{return}
    }
    
    //MARK: webView
    func creatWebView(){
        webView.frame = self.view.frame
        webView.loadRequest(URLRequest(url: URL(string:FileManage.documentPath+"/d41d8cd98f00b204e9800998ecf8427e.html")!))
        self.view.addSubview(webView)
    
        self.view.bringSubview(toFront: loadingView)
        //加载状态
        if webView.isLoading{
            loadingView.startAnimating()
        }else{
            loadingView.stopAnimating()
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    //更新约束
//    override func updateViewConstraints() {
//        
//    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
