//
//  SortView.swift
//  DoubanLibrary
//
//  Created by wangchi on 2018/2/28.
//  Copyright © 2018年 Zhu xiaojin. All rights reserved.
//

import UIKit
import Foundation

enum Promotion: String {
    case promote = "限时免费"
    case none
}

enum PriceRange: String {
    case free = "免费"
    case secondRange = "0.01 - 1.99"
    case thirdRange = "2 - 4.99"
    case forthRange = "5 - 9.99"
    case fifthRange = "10 - 19.99"
    case sixthRange = "20 及以上"
    case none
}

enum Category: String {
    case ebook = "电子书"
    case column = "专栏连载"
    case shortStory = "短篇"
    case none
}

class SortView: UIView {
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.backgroundColor = .white
    }
    
    var isSelected = true
    
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
    

    @IBAction func choosePromotionButton(_ sender: BorderedButton) {
        if isSelected {
            
        }
    }
    @IBAction func choosePriceButton(_ sender: BorderedButton) {
    }
    
    @IBAction func chooseCategoryButton(_ sender: BorderedButton) {
    }
    @IBAction func resetStatusLabel(_ sender: UIButton) {
    }
    @IBAction func confirmStatusLabel(_ sender: UIButton) {
    }
    
    func showTextOnTheStatusLabel(_ button: BorderedButton) -> NSAttributedString? {
        let text = NSMutableAttributedString()
        
        return text
    }
    
//    func showTextOnStatusLabel(_ buttonFromPromotion: Promotion?, buttonFromPrice: PriceRange?, buttonFromCategory: Category?) -> NSAttributedString {
//        let text = NSMutableAttributedString()
//        let textAttribute = [ NSAttributedStringKey.foregroundColor: UIColor.blue ]
//        let addAttribute = [ NSAttributedStringKey.foregroundColor: UIColor.white ]
//        let promotionText = NSAttributedString(string: (buttonFromPrice?.rawValue)!, attributes: textAttribute)
//        let priceText = NSAttributedString(string: (buttonFromPrice?.rawValue)!, attributes: textAttribute)
//        let categoryText = NSAttributedString(string: (buttonFromPrice?.rawValue)!, attributes: textAttribute)
//        let addText = NSAttributedString(string: " + ", attributes: addAttribute)
//        if !(buttonFromPromotion?.rawValue.isEmpty)! {
//            if !(buttonFromPrice?.rawValue.isEmpty)! {
//                if !(buttonFromCategory?.rawValue.isEmpty)! {
//                    text.append(promotionText)
//                    text.append(addText)
//                    text.append(priceText)
//                    text.append(addText)
//                    text.append(categoryText)
//                } else {
//                    text.append(promotionText)
//                    text.append(addText)
//                    text.append(priceText)
//                }
//            } else {
//                if !(buttonFromCategory?.rawValue.isEmpty)! {
//                    text.append(promotionText)
//                    text.append(addText)
//                    text.append(categoryText)
//                } else {
//                    text.append(promotionText)
//                }
//            }
//        }
//        return text
//    }

  
 
}


















