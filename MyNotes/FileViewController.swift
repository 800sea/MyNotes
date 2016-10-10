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
        let note = NoteView.init(frame: CGRect.init(x:  0, y: 0, width: 60, height: 60))
        self.view.addSubview(note)
        note.translatesAutoresizingMaskIntoConstraints = false

        noteView(view:note)
    }
    //圆形点击区域布局
    func noteView(view:UIView){
        let centerY = view.centerYAnchor.constraint(equalTo: self.view.centerYAnchor, constant: 0)
        let right   = view.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: 0)
        let width   = view.widthAnchor.constraint(equalToConstant: 60)
        let height  = view.heightAnchor.constraint(equalToConstant: 60)
        
        NSLayoutConstraint.activate([centerY,right,width,height])
        view.layoutIfNeeded()
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
