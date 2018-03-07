//
//  SortView.swift
//  DoubanLibrary
//
//  Created by wangchi on 2018/2/28.
//  Copyright © 2018年 Zhu xiaojin. All rights reserved.
//

import UIKit

class SortView: UIView {
    
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
    
    var priceArray = ["免费","0.01 - 1.99","2 - 4.99","5 - 9.99","10 - 19.99","20 及以上"]
 
    var bookCategoryArray = ["电子书","专栏连载","短篇"]
    
    @IBAction func choosePromotionButton(_ sender: BorderedButton) {
        if isSelected {
            promtionImageView.image = #imageLiteral(resourceName: "choose")
            statusLable.text = promotionButton.titleLabel?.text
            statusLable.textColor = .blue
            statusLable.backgroundColor = .darkGray
            isSelected = false
        } else {
            promtionImageView.image = nil
            isSelected = true
        }
        
    }
    @IBAction func chooseFreeButton(_ sender: BorderedButton) {
        print("lalala")
    }
    @IBAction func chooseSecondButton(_ sender: BorderedButton) {
        
    }
    @IBAction func chooseThirdButton(_ sender: BorderedButton) {
        
    }
    @IBAction func chooseForthButton(_ sender: BorderedButton) {
    
    }
    @IBAction func chooseFifthButton(_ sender: BorderedButton) {
        
    }
    @IBAction func chooseSixthButton(_ sender: BorderedButton) {
        
    }
    @IBAction func chooseEbookButton(_ sender: BorderedButton) {
        
    }
    @IBAction func chooseColumnButton(_ sender: BorderedButton) {
        
    }
    @IBAction func chooseShortStoryButton(_ sender: BorderedButton) {
    }
    
    @IBAction func chooseResetButton(_ sender: UIButton) {
        statusLable.text = nil
        statusLable.backgroundColor = .white
        
    }
    @IBAction func chooseConfirmButton(_ sender: UIButton) {
        
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        self.backgroundColor = .white
    }
 
}


















