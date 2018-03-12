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
    
    var borderButton: BorderedButton?
    
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
    
    @IBOutlet weak var promotionButton: BorderedButton!
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
    
    var isInited = false
    
    override func layoutSubviews() {
        super.layoutSubviews()
        if !isInited {
            promotionButton.buttonImageView = promtionImageView
            freeButton.buttonImageView = freeImageView
            secondButton.buttonImageView = secondImageView
            thirdButton.buttonImageView = thirdImageView
            forthButton.buttonImageView = forthImageView
            fifthButton.buttonImageView = fifthImageView
            sixthButton.buttonImageView = sixthImageView
            ebookButton.buttonImageView = ebookImageView
            columnButton.buttonImageView = columnImageView
            shortStoryButton.buttonImageView = shortStoryImage
        }
    }

    @IBAction func choosePromotionButton(_ sender: BorderedButton) {
        type = .promotion
        if sender.buttonImageView?.image == nil {
            sender.buttonSelected = true
        } else {
            sender.buttonSelected = false
        }
    }
    @IBAction func choosePriceButton(_ sender: BorderedButton) {
        if sender == freeButton {
            range = .free
            freeButton.buttonSelected = true
            secondButton.buttonSelected = false
            thirdButton.buttonSelected = false
            forthButton.buttonSelected = false
            fifthButton.buttonSelected = false
            sixthButton.buttonSelected = false
        } else if sender == secondButton {
            range = .one
            freeButton.buttonSelected = false
            secondButton.buttonSelected = true
            thirdButton.buttonSelected = false
            forthButton.buttonSelected = false
            fifthButton.buttonSelected = false
            sixthButton.buttonSelected = false

        } else if sender == thirdButton {
            range = .two
            freeButton.buttonSelected = false
            secondButton.buttonSelected = false
            thirdButton.buttonSelected = true
            forthButton.buttonSelected = false
            fifthButton.buttonSelected = false
            sixthButton.buttonSelected = false
           
        } else if sender == forthButton {
            range = .five
            freeButton.buttonSelected = false
            secondButton.buttonSelected = false
            thirdButton.buttonSelected = false
            forthButton.buttonSelected = true
            fifthButton.buttonSelected = false
            sixthButton.buttonSelected = false
        } else if sender == fifthButton {
            range = .ten
            freeButton.buttonSelected = false
            secondButton.buttonSelected = false
            thirdButton.buttonSelected = false
            forthButton.buttonSelected = false
            fifthButton.buttonSelected = true
            sixthButton.buttonSelected = false
        } else if sender == sixthButton {
            range = .twenty
            freeButton.buttonSelected = false
            secondButton.buttonSelected = false
            thirdButton.buttonSelected = false
            forthButton.buttonSelected = false
            fifthButton.buttonSelected = false
            sixthButton.buttonSelected = true
        }
    }
    
    @IBAction func chooseCategoryButton(_ sender: BorderedButton) {

        if sender == ebookButton {
            category = .dianzi
            ebookButton.buttonSelected = true
            shortStoryButton.buttonSelected = false
            columnButton.buttonSelected = false

        } else if sender == shortStoryButton {
            category = .duanpian
            shortStoryButton.buttonSelected = true
            ebookButton.buttonSelected = false
            columnButton.buttonSelected = false
        } else if sender == columnButton {
            category = .zhuanlan
            columnButton.buttonSelected = true
            ebookButton.buttonSelected = false
            shortStoryButton.buttonSelected = false
        }
    }
    @IBAction func resetStatusLabel(_ sender: UIButton) {
        statusLable.text = ""
        statusLable.backgroundColor = .white
        promotionButton.buttonSelected = false
        freeButton.buttonSelected = false
        secondButton.buttonSelected = false
        thirdButton.buttonSelected = false
        forthButton.buttonSelected = false
        fifthButton.buttonSelected = false
        sixthButton.buttonSelected = false
        columnButton.buttonSelected = false
        ebookButton.buttonSelected = false
        shortStoryButton.buttonSelected = false
        type = .none
        range = .none
        category = .none
    }
    
    var searchSortHandler: ((String,Int) -> Void)?
    var start = 0
    var hideSortView:(()-> Void)?
    var sortCount: Any {
        let text = statusLable.text
        if text == "" {
          return  hideSortView!()
        } else {
            return (text?.split(separator: "+").count)!
        }
    }
    
    @IBAction func confirmStatusLabel(_ sender: UIButton) {
        guard let text = statusLable.text, let searchSortHandler = searchSortHandler, let hideSortView = hideSortView  else { return }
        searchSortHandler(text, start)
        hideSortView()
    }
}


















