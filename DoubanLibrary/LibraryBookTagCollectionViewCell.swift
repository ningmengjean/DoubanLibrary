//
//  LibraryBookTagCollectionViewCell.swift
//  DoubanLibrary
//
//  Created by wangchi on 2018/1/29.
//  Copyright © 2018年 Zhu xiaojin. All rights reserved.
//

import UIKit



class LibraryBookTagCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var tagButton: UIButton! {
        didSet {
            tagButton.isUserInteractionEnabled = false
        }
    }
    
}
