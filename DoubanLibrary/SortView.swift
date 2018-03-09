//
//  SortView.swift
//  DoubanLibrary
//
//  Created by wangchi on 2018/2/28.
//  Copyright © 2018年 Zhu xiaojin. All rights reserved.
//

import UIKit
import Foundation

class SortView: UIView {
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.backgroundColor = .white
    }
    enum PromotionType: String {
        case promotion = "限时特价"
        case none
    }
    
    enum PriceRange: String {
        case none
        case free = "免费"
        case one = "0.01 - 1.99"
        case two = "2 - 4.99"
        case five = "5 - 9.99"
        case ten = "10 - 19.99"
        case twenty = "20 及以上"
    }
    
    enum Category: String {
        case none
        case dianzi = "电子书"
        case zhuanlan = "专栏连载"
        case duanpian = "短篇"
    }
    
    var type: PromotionType = .none {
        didSet{
            if oldValue == type {
                type = .none
                promtionImageView.image = nil
                printResultString()
            } else {
                printResultString()
            }
        }
    }
    
    var range: PriceRange = .none {
        didSet{
            if oldValue == range {
                
                range = .none
                printResultString()
            } else {
                printResultString()
            }
        }
    }
    
    var category: Category = .none {
        didSet{
            if oldValue == category {
                category = .none
                printResultString()
            } else {
                printResultString()
            }
        }
    }
    
    func printResultString() {
        var strArr = [String]()
        
        if type != .none {
            strArr.append(type.rawValue)
        }
        
        if range != .none {
            strArr.append(range.rawValue)
        }
        if category != .none {
            strArr.append(category.rawValue)
        }
        statusLable.text = strArr.joined(separator: " + ")
        if statusLable.text == "" {
            statusLable.backgroundColor = .white
        } else {
            statusLable.textColor = .white
            statusLable.backgroundColor = .darkGray
        }
    }
    
    @IBOutlet weak var promotionButton: BorderedButton! {
        didSet {
            promotionButton.isUserInteractionEnabled = true
        }
    }
    @IBOutlet weak var promtionImageView: UIImageView!
    @IBOutlet weak var freeButton: BorderedButton!
    @IBOutlet weak var freeImageView: UIImageView!
    @IBOutlet weak var secondButton: BorderedButton!
    @IBOutlet weak var secondImageView: UIImageView!
    @IBOutlet weak var thirdButton: BorderedButton!
    @IBOutlet weak var thirdImageView: UIImageView!
    @IBOutlet weak var forthButton: BorderedButton!
    @IBOutlet weak var forthImageView: UIImageView!
    @IBOutlet weak var fifthButton: BorderedButton!
    @IBOutlet weak var fifthImageView: UIImageView!
    @IBOutlet weak var sixthButton: BorderedButton!
    @IBOutlet weak var sixthImageView: UIImageView!
    @IBOutlet weak var ebookButton: BorderedButton!
    @IBOutlet weak var ebookImageView: UIImageView!
    @IBOutlet weak var columnButton: BorderedButton!
    @IBOutlet weak var columnImageView: UIImageView!
    @IBOutlet weak var shortStoryButton: BorderedButton!
    @IBOutlet weak var shortStoryImage: UIImageView!
    @IBOutlet weak var statusLable: UILabel!
    @IBOutlet weak var resetButton: UIButton!
    @IBOutlet weak var confirmButton: UIButton!
    

    @IBAction func choosePromotionButton(_ sender: BorderedButton) {
        type = .promotion
        promtionImageView?.image = #imageLiteral(resourceName: "choose")
        
    }
    @IBAction func choosePriceButton(_ sender: BorderedButton) {
        if sender == freeButton {
            range = .free
            freeImageView?.image = #imageLiteral(resourceName: "choose")
        } else if sender == secondButton {
            range = .one
            secondImageView?.image = #imageLiteral(resourceName: "choose")
        } else if sender == thirdButton {
            range = .two
            thirdImageView?.image = #imageLiteral(resourceName: "choose")
        } else if sender == forthButton {
            range = .five
            forthImageView?.image = #imageLiteral(resourceName: "choose")
        } else if sender == fifthButton {
            range = .ten
            fifthImageView?.image = #imageLiteral(resourceName: "choose")
        } else if sender == sixthButton {
            range = .twenty
            sixthImageView?.image = #imageLiteral(resourceName: "choose")
        }
    }
    
    @IBAction func chooseCategoryButton(_ sender: BorderedButton) {
        if sender == ebookButton {
            category = .dianzi
        } else if sender == shortStoryButton {
            category = .duanpian
        } else if sender == columnButton {
            category = .zhuanlan
        }
    }
    @IBAction func resetStatusLabel(_ sender: UIButton) {
    }
    @IBAction func confirmStatusLabel(_ sender: UIButton) {
    }
    
    
  
 
}


















