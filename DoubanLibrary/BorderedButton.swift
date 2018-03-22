//
//  BorderedButton.swift
//  DoubanLibrary
//
//  Created by wangchi on 2018/3/5.
//  Copyright © 2018年 Zhu xiaojin. All rights reserved.
//

import UIKit
import Foundation

class BorderedButton: UIButton {

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        layer.borderWidth = 0.5
        layer.borderColor = tintColor.cgColor
        layer.cornerRadius = layer.frame.height / 2
        clipsToBounds = true
        contentEdgeInsets = UIEdgeInsets(top: 8, left: 10, bottom: 8, right: 30)
        
        setTitleColor(.darkGray, for: .normal)
        layer.borderWidth = 0.5
    }

    
    var buttonSelected = false {
        didSet {
            if buttonSelected {
                setTitleColor(.blue, for: .normal)
                layer.borderWidth = 1.0
                buttonImageView?.image = #imageLiteral(resourceName: "choose")
            
            } else {
                setTitleColor(.darkGray, for: .normal)
                layer.borderWidth = 0.5
                buttonImageView?.image = nil
                
            }
        }
    }

    var buttonImageView: UIImageView?
    
}
