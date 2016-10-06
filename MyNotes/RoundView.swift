//
//  RoundView.swift
//  MyNotes
//
//  Created by sea on 16/10/2.
//  Copyright © 2016年 sea. All rights reserved.
//

import UIKit

protocol RoundDeletage:NSObjectProtocol {
    func roundClick()
}

class RoundView: UIView {
    //代理
    weak var delete:RoundDeletage?

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.isUserInteractionEnabled = true
        self.setNeedsDisplay(frame)
        
        let str = UILabel.init(frame: CGRect.init(x: 5, y: 15, width: 40, height: 20))
        str.text = "备注"
        self.addSubview(str)
        //隐藏黑色的背景
        self.backgroundColor = UIColor.clear
        addClick()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        let path = UIBezierPath()
        path.addArc(withCenter: self.center, radius: rect.size.width*0.5, startAngle: 0, endAngle: 180, clockwise: true)
        UIColor.red.setFill()
        path.fill()
        //path.stroke()
    }
    
    //添加点击
    func addClick(){
        let gesture = UITapGestureRecognizer.init(target: self, action: #selector(clickThis(gest:)))
        self.addGestureRecognizer(gesture)
    }
    
    func clickThis(gest:UITapGestureRecognizer) {
        
        delete?.roundClick()
    }
}
