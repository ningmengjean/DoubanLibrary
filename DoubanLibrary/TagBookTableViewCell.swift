//
//  TagBookTableViewCell.swift
//  DoubanLibrary
//
//  Created by wangchi on 2018/1/31.
//  Copyright © 2018年 Zhu xiaojin. All rights reserved.
//

import UIKit
import Cosmos
import Foundation

class TagBookTableViewCell: UITableViewCell {

    @IBOutlet weak var bookImage: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var autherLabel: UILabel!
    @IBOutlet weak var cosmosView: CosmosView! {
        didSet {
            cosmosView.settings.updateOnTouch = false
            cosmosView.settings.starSize = 15
            cosmosView.settings.starMargin = 5
            cosmosView.settings.fillMode = .precise
            cosmosView.settings.filledColor = UIColor.red
            cosmosView.settings.emptyBorderColor = UIColor.red
            cosmosView.settings.filledBorderColor = UIColor.red
        }
    }
    @IBOutlet weak var rateLabel: UILabel!
    @IBOutlet weak var summaryLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    
    func configureTagBookTableViewCell(_ result: Book) {
            titleLabel.text = result.title
            autherLabel.text = result.author
            rateLabel.text = "\(result.rating.numRaters) 评价"
            cosmosView.rating = result.rating.average/2.0
            cosmosView.text = String(result.rating.average)
            summaryLabel.text = result.summary
            priceLabel.text = result.price
        if let image = result.images.mediumImageURL{
            bookImage.kf.setImage(with: image)
        }
    }
}
