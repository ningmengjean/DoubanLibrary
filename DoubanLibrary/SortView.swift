//
//  SortView.swift
//  DoubanLibrary
//
//  Created by wangchi on 2018/2/28.
//  Copyright © 2018年 Zhu xiaojin. All rights reserved.
//

import UIKit
import Foundation

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

enum selectedCategoryButton<BorderedButton,Bool> {
    case ebookButton,columButton,shortStoryButton
}

class SortView: UIView {
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.backgroundColor = .white
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
            if freeButton?.buttonImageView?.image == nil {
                range = .free
                freeButton.buttonImageView?.image = #imageLiteral(resourceName: "choose")
                freeButton.buttonSelected = true
                secondButton.buttonImageView?.image = nil
                secondButton.buttonSelected = false
                thirdButton.buttonImageView?.image = nil
                thirdButton.buttonSelected = false
                forthButton.buttonImageView?.image = nil
                forthButton.buttonSelected = false
                fifthButton.buttonImageView?.image = nil
                fifthButton.buttonSelected = false
                sixthButton.buttonImageView?.image = nil
                sixthButton.buttonSelected = false
            } else {
                range = .none
                freeButton.buttonImageView?.image = nil
                freeButton.buttonSelected = false
            }
         
        } else if sender == secondButton {
            if secondButton?.buttonImageView?.image == nil {
                range = .one
                freeButton.buttonImageView?.image = nil
                freeButton.buttonSelected = false
                secondButton.buttonImageView?.image = #imageLiteral(resourceName: "choose")
                secondButton.buttonSelected = true
                thirdButton.buttonImageView?.image = nil
                thirdButton.buttonSelected = false
                forthButton.buttonImageView?.image = nil
                forthButton.buttonSelected = false
                fifthButton.buttonImageView?.image = nil
                fifthButton.buttonSelected = false
                sixthButton.buttonImageView?.image = nil
                sixthButton.buttonSelected = false
                
            } else {
                range = .none
                secondButton.buttonImageView?.image = nil
                secondButton.buttonSelected = false
            }

        } else if sender == thirdButton {
            
            if thirdButton?.buttonImageView?.image == nil {
                range = .two
                freeButton.buttonImageView?.image = nil
                freeButton.buttonSelected = false
                secondButton.buttonImageView?.image = nil
                secondButton.buttonSelected = false
                thirdButton.buttonImageView?.image = #imageLiteral(resourceName: "choose")
                thirdButton.buttonSelected = true
                forthButton.buttonImageView?.image = nil
                forthButton.buttonSelected = false
                fifthButton.buttonImageView?.image = nil
                fifthButton.buttonSelected = false
                sixthButton.buttonImageView?.image = nil
                sixthButton.buttonSelected = false
            } else {
                range = .none
                thirdButton.buttonImageView?.image = nil
                thirdButton.buttonSelected = false
            }
        } else if sender == forthButton {
            if forthButton?.buttonImageView?.image == nil {
                range = .five
                freeButton.buttonImageView?.image = nil
                freeButton.buttonSelected = false
                secondButton.buttonImageView?.image = nil
                secondButton.buttonSelected = false
                thirdButton.buttonImageView?.image = nil
                thirdButton.buttonSelected = false
                forthButton.buttonImageView?.image = #imageLiteral(resourceName: "choose")
                forthButton.buttonSelected = true
                fifthButton.buttonImageView?.image = nil
                fifthButton.buttonSelected = false
                sixthButton.buttonImageView?.image = nil
                sixthButton.buttonSelected = false
            } else {
                range = .none
                forthButton.buttonImageView?.image = #imageLiteral(resourceName: "choose")
                forthButton.buttonSelected = false
            }
        } else if sender == fifthButton {
            if fifthButton?.buttonImageView?.image == nil {
                range = .ten
                freeButton.buttonImageView?.image = nil
                freeButton.buttonSelected = false
                secondButton.buttonImageView?.image = nil
                secondButton.buttonSelected = false
                thirdButton.buttonImageView?.image = nil
                thirdButton.buttonSelected = false
                forthButton.buttonImageView?.image = nil
                forthButton.buttonSelected = false
                fifthButton.buttonImageView?.image = #imageLiteral(resourceName: "choose")
                fifthButton.buttonSelected = true
                sixthButton.buttonImageView?.image = nil
                sixthButton.buttonSelected = false
            } else {
                range = .none
                fifthButton.buttonImageView?.image = nil
                fifthButton.buttonSelected = false
            }
        } else if sender == sixthButton {
            if sixthButton?.buttonImageView?.image == nil {
                range = .twenty
                freeButton.buttonImageView?.image = nil
                freeButton.buttonSelected = false
                secondButton.buttonImageView?.image = nil
                secondButton.buttonSelected = false
                thirdButton.buttonImageView?.image = nil
                thirdButton.buttonSelected = false
                forthButton.buttonImageView?.image = nil
                forthButton.buttonSelected = false
                fifthButton.buttonImageView?.image = nil
                fifthButton.buttonSelected = false
                sixthButton.buttonImageView?.image = #imageLiteral(resourceName: "choose")
                sixthButton.buttonSelected = true
            } else {
                range = .none
                sixthButton.buttonImageView?.image = nil
                sixthButton.buttonSelected = false
            }
        }
    }
    
    @IBAction func chooseCategoryButton(_ sender: BorderedButton) {
        if sender == ebookButton {
            if ebookButton.buttonImageView?.image == nil {
                category = .dianzi
                ebookButton.buttonSelected = true
                ebookButton.buttonImageView?.image = #imageLiteral(resourceName: "choose")
                shortStoryButton.buttonSelected = false
                shortStoryButton.buttonImageView?.image = nil
                columnButton.buttonSelected = false
                columnButton.buttonImageView?.image = nil
            } else {
                category = .none
                ebookButton.buttonSelected = false
                ebookButton.buttonImageView?.image = nil
            }
            
        } else if sender == shortStoryButton {
            if shortStoryButton.buttonImageView?.image == nil {
                category = .duanpian
                ebookButton.buttonSelected = false
                ebookButton.buttonImageView?.image = nil
                shortStoryButton.buttonSelected = true
                shortStoryButton.buttonImageView?.image = #imageLiteral(resourceName: "choose")
                columnButton.buttonSelected = false
                columnButton.buttonImageView?.image = nil
            } else {
                category = .none
                shortStoryButton.buttonSelected = false
                shortStoryButton.buttonImageView?.image = nil
            }
          
        } else if sender == columnButton {
            if columnButton.buttonImageView?.image == nil {
                category = .zhuanlan
                ebookButton.buttonSelected = false
                ebookButton.buttonImageView?.image = nil
                shortStoryButton.buttonSelected = false
                shortStoryButton.buttonImageView?.image = nil
                columnButton.buttonSelected = true
                columnButton.buttonImageView?.image = #imageLiteral(resourceName: "choose")
            } else {
                category = .none
                columnButton.buttonSelected = false
                columnButton.buttonImageView?.image = nil
            }
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


















