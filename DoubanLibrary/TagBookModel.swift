//
//  TagBookModel.swift
//  DoubanLibrary
//
//  Created by wangchi on 2018/1/30.
//  Copyright © 2018年 Zhu xiaojin. All rights reserved.
//

import Foundation

import SwiftyJSON

struct TagBookModel {
    
    init(json: JSON) {
        bookArray = json["books"].arrayValue
        title = bookArray.map{$0["title"].stringValue}
        author = bookArray.map{$0["author", 0].stringValue}
        rate = bookArray.map{$0["rating","average"].stringValue}
        numRaters = bookArray.map{$0["rating","numRaters"].intValue}
        summary = bookArray.map{$0["summary"].stringValue}
        price = bookArray.map{$0["ebook_price"].stringValue}
        image = bookArray.map{$0["images","medium"].stringValue}
        count = json["count"].intValue
    }
    var bookArray:[JSON]
    var title: [String?]
    var author: [String?]
    var rate: [String?]
    var numRaters: [Int?]
    var summary: [String?]
    var price: [String?]
    var image: [String?]
    var count: Int?
}











