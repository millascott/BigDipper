//
//  YL001DevicesControlTVC.swift
//  ProjectDemoSwift
//
//  Created by pingguo on 2019/1/9.
//  Copyright © 2019年 yons. All rights reserved.
//

import UIKit
import MediaPlayer

class YL001DevicesControlTVC: UITableViewCell {
    
    var songItem: MPMediaItem? = nil {
        didSet {
            guard songItem != nil else {
                return
            }
            self.titleLab.text = songItem!.title
            self.nameLab.text = songItem!.artist
        }
    }

    @IBOutlet weak var blackView: UIView!
    @IBOutlet weak var titleLab: UILabel!
    @IBOutlet weak var nameLab: UILabel!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
        if selected {
            self.contentView.backgroundColor = UIColor.init(hexString: "#F2F2F2")
            self.blackView.isHidden = false
            self.titleLab.textColor = UIColor.init(hexString: "#FF2825")
            
        } else {
            self.contentView.backgroundColor = UIColor.clear
            self.blackView.isHidden = true
            self.titleLab.textColor = UIColor.init(hexString: "#444444")
        }
    }
    
}
