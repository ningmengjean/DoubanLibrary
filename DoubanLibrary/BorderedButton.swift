//
//  BorderedButton.swift
//  DoubanLibrary
//
//  Created by wangchi on 2018/3/5.
//  Copyright © 2018年 Zhu xiaojin. All rights reserved.
//

import UIKit

class BorderedButton: UIButton {

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        layer.borderWidth = 1.0
        layer.borderColor = tintColor.cgColor
        layer.cornerRadius = layer.frame.height / 2
        clipsToBounds = true
        contentEdgeInsets = UIEdgeInsets(top: 8, left: 10, bottom: 8, right: 30)
//        setTitleColor(tintColor, for: .normal)
//        setTitleColor(UIColor.darkGray, for: .highlighted)
    }
}
