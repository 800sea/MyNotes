//
//  NoteView.swift
//  MyNotes
//
//  Created by sea on 16/9/30.
//  Copyright © 2016年 sea. All rights reserved.
//  页面的备注view

import UIKit

class NoteView: UIView,RoundDeletage {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    
    var roundView:RoundView?//圆形点击区域
    var textView = UITextView()//view的内容区域
    let bgView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: 200, height: 100))
    var textViewStyle:Bool = false //textView的展开状态 默认没有出现
    override init(frame:CGRect){
        super.init(frame:frame)
        creatRound()
        roundView?.delete = self
        self.layer.anchorPoint = CGPoint.init(x: 1, y: 0)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    //设置圆形与圆形点击区域
    func creatRound() {
        roundView = RoundView(frame: CGRect.init(x: 0, y: 0, width: 60, height: 60))
        self.addSubview(roundView!)
        
//        roundView?.mas_makeConstraints({ (make) in
//            make?.right.equalTo()(self.mas_right)?.setOffset(-30)
//            make?.top.equalTo()(self.mas_top)?.setOffset(0)
//            
//            
//        })
        addTextView()
    }
    func addTextView(){
        textView.frame = CGRect.init(x: 0, y: 0, width: 200, height: 100)
        textView.center = (roundView?.center)!
        textView.font = UIFont.boldSystemFont(ofSize: 16)
        textView.backgroundColor = Tool.getBgColor(.A)

        //text 自适应高度
        textView.autoresizingMask = .flexibleHeight
        textView.text = "24234234"
        textView.layer.anchorPoint = CGPoint.init(x: 1, y: 0)
       // textView.textContainerInset = UIEdgeInsetsMake(10, 5, 5, 20)
        //显示内容
        //self.setNeedsDisplay()
//        textView.isEditable = true
       //
        //textView.isFirstResponder = true
    }
    //MARK:圆形的点击代理事件
    func roundClick() {
        //self.addSubview(textView)
        textViewStyle = !textViewStyle
        //确定 textView已经被add
        if textViewStyle && (textView.superview == nil) {
            self.addSubview(textView)
            self.insertSubview(textView, at: 0)
            //self.bounds = CGRect.init(x: 0, y: 0, width: 300, height: 500)
            UIView.animate(withDuration: 0.5) {
                self.textView.bounds = CGRect.init(x: 0, y: 0, width: 200, height: 100)
            }
        }else{
            //self.bounds = CGRect.init(x: 0, y: 0, width: 60, height: 60)
            UIView.animate(withDuration: 0.5, animations: {
                self.textView.bounds = CGRect.init(x: 0, y: 0, width: 1, height: 1)
                }, completion: { (temp) in
                    self.textView.removeFromSuperview()
            })
        }
    }
    
}
