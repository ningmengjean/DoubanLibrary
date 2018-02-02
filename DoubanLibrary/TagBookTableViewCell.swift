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
            cosmosView.settings.starSize = 15
            cosmosView.settings.starMargin = 2
            cosmosView.settings.fillMode = .precise
            cosmosView.settings.filledColor = UIColor.red
            cosmosView.settings.emptyBorderColor = UIColor.red
            cosmosView.settings.filledBorderColor = UIColor.red
        }
    }
    @IBOutlet weak var rateLabel: UILabel!
    @IBOutlet weak var summaryLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    
    func configureTagBookTableViewCell(_ result: TagBookModel,indexPath: IndexPath) {
        if let title = result.title[indexPath.row] {
            titleLabel.text = title
        }
        if let auther = result.author[indexPath.row] {
            autherLabel.text = auther
        }
        if let rate = result.rate[indexPath.row] {
            rateLabel.text = rate
            cosmosView.rating = Double(rate)!/2.0
           
        }
        if let summary = result.summary[indexPath.row] {
            summaryLabel.text = summary
        }
        if let price = result.price[indexPath.row] {
            priceLabel.text = price
        }
        if let image = result.image[indexPath.row], let url = URL(string: image ){
            bookImage.kf.setImage(with: url)
        }
    }
}
