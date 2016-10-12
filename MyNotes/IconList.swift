//
//  IconList.swift
//  MyNotes
//
//  Created by sea on 16/10/10.
//  Copyright © 2016年 sea. All rights reserved.
//

import UIKit

class IconList: UIScrollView {

    let btnWidth: CGFloat = 60
    let padding:CGFloat = 15
    var selectItem: ((_ index: Int)->())?

    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    convenience init(inView: UIView) {
        let rect = CGRect(x: inView.bounds.width, y: 0.0, width: inView.frame.width, height: 80.0)
        self.init(frame: rect)
        
        self.alpha = 0.0
        
        for i in 1 ..< 15 {
            //UIImage.init(named: <#T##String#>)
            let image = UIImage.init(named: "icon_\(i).png")
            let imageView  = UIImageView(image: image)
            imageView.bounds = CGRect.init(x: 0, y: 0, width: btnWidth, height: btnWidth)
            imageView.contentMode = .scaleAspectFit
            imageView.center = CGPoint(x: CGFloat(i) * btnWidth, y: btnWidth/2+10)
            imageView.tag = i
            imageView.isUserInteractionEnabled = true
            addSubview(imageView)
            
            let tap = UITapGestureRecognizer(target: self, action: #selector(IconList.didTapImage(_:)))
            imageView.addGestureRecognizer(tap)
        }
        
        contentSize = CGSize(width: padding * btnWidth, height:  btnWidth)
    }
    
    func didTapImage(_ tap: UITapGestureRecognizer) {
        selectItem?(tap.view!.tag)
    }
    //展示动画
    func showIconAnimate(){
        UIView.animate(withDuration: 1.0, delay: 0.01, usingSpringWithDamping: 0.5, initialSpringVelocity: 10.0, options: .curveEaseIn, animations: {
            self.alpha = 1.0
            self.center.x -= 0//self.frame.size.width
            }, completion: nil)
    }
    
    override func didMoveToSuperview() {
        super.didMoveToSuperview()
        
        if superview == nil {
            return
        }
        
        UIView.animate(withDuration: 1.0, delay: 0.01, usingSpringWithDamping: 0.5, initialSpringVelocity: 10.0, options: .curveEaseIn, animations: {
            self.alpha = 1.0
            self.center.x -= self.frame.size.width
            }, completion: nil)
    }
    
    

}
