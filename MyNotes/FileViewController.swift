//
//  FileViewController.swift
//  MyNotes
//
//  Created by sea on 16/9/27.
//  Copyright © 2016年 sea. All rights reserved.
//

import UIKit

class FileViewController: UIViewController,UITextViewDelegate {

    var webView = UIWebView()
    var fileData = FileModel()
    //var text = UITextView()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = fileData.title
        Tool.log(self.title)
        creatWebView()
        
        let note = NoteView.init(frame: CGRect.init(x: 200, y: 300, width: 200, height: 60))
        self.view.addSubview(note)
        //设置备注文本的代理
//        note.textView.delegate = self
    }
    
//    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
//        return true
//    }
    
    //MARK: webView
    func creatWebView(){
        //https://my.oschina.net/u/2340880/blog/469916
        webView.frame = self.view.frame
        webView.loadRequest(URLRequest(url: URL(string:FileManage.documentPath+"/d41d8cd98f00b204e9800998ecf8427e.html")!))
        Tool.log("----------\(fileData.cont)")
    //    webView.loadHTMLString(String, baseURL: <#T##URL?#>)
        self.view.addSubview(webView)
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
