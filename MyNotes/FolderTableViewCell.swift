//
//  FolderTableViewCell.swift
//  MyNotes
//
//  Created by sea on 16/9/22.
//  Copyright © 2016年 sea. All rights reserved.
//

import UIKit

class FolderTableViewCell: UITableViewCell {

    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var pic: UIImageView!
    
    
    open var model:FileModel?{
        didSet{
            title.text = model?.title
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        
    }

}
