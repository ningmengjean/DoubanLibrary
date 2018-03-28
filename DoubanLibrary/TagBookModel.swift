//
//  TagBookModel.swift
//  DoubanLibrary
//
//  Created by wangchi on 2018/1/30.
//  Copyright © 2018年 Zhu xiaojin. All rights reserved.
//

import Foundation

import SwiftyJSON

@objc class BookRating: NSObject {
    @objc let max: Int
    @objc let numRaters: String
    @objc let average: Double
    @objc let min: Int
    
    init(json: JSON) {
        max = json["max"].intValue
        numRaters = json["numRaters"].stringValue
        average = json["average"].doubleValue
        min = json["min"].intValue
    }
}

@objc class BooKTag: NSObject {
    @objc let count:Int
    @objc let name: String
    @objc let title: String
    
    init(json: JSON) {
        count = json["count"].intValue
        name = json["name"].stringValue
        title = json["title"].stringValue
    }
}

@objc class Images: NSObject {
    @objc let small: String
    @objc let large: String
    @objc let medium: String
    init(json: JSON) {
        small = json["small"].stringValue
        large = json["large"].stringValue
        medium = json["medium"].stringValue
    }
    
    @objc var mediumImageURL: URL? {
        return URL(string: medium)
    }
}

@objc class BookSeries: NSObject {
    @objc let id: String
    @objc let title: String
    init(json: JSON) {
        id = json["id"].stringValue
        title = json["title"].stringValue
    }
}

@objc class Book: NSObject {
    @objc let tags: [BooKTag]
    @objc let rating: BookRating
    @objc let subTitle: String
    @objc let author: String
    @objc let pubdate: String
    @objc let originTitle: String
    @objc let image: URL?
    @objc let binding: String
    @objc var translators: [String]
    @objc let catalog: String
    @objc let ebook_url: URL?
    @objc let pages: Int
    @objc let images: Images
    @objc let alt: URL?
    @objc let id: String
    @objc let publisher: String
    @objc let isbn10: String
    @objc let isbn13: String
    @objc let title: String
    @objc let url: URL?
    @objc let alt_title: String
    @objc let author_intro: String
    @objc let summary: String
    @objc let ebook_price: Double
    @objc let series: BookSeries
    @objc let price: String
    
    init(json: JSON) {
        tags = json["tags"].arrayValue.map { BooKTag(json: $0) }
        rating = BookRating(json: json["rating"])
        subTitle = json["subtitle"].stringValue
        author = json["author"].stringValue
        pubdate = json["pubdate"].stringValue
        originTitle = json["origin_title"].stringValue
        image = URL(string:json["image"].stringValue)
        binding = json["binding"].stringValue
        translators = json["translator"].arrayValue.map {$0.stringValue}
        catalog = json["catalog"].stringValue
        ebook_url = URL(string:json["ebook_url"].stringValue)
        pages = json["pages"].intValue
        images = Images(json: json["images"])
        alt = URL(string:json["alt"].stringValue)
        id = json["id"].stringValue
        publisher = json["publisher"].stringValue
        isbn10 = json["isbn10"].stringValue
        isbn13 = json["isbn13"].stringValue
        title = json["title"].stringValue
        url = URL(string: json["url"].stringValue)
        alt_title = json["alt_title"].stringValue
        author_intro = json["author_intro"].stringValue
        summary = json["summary"].stringValue
        ebook_price = json["ebook_price"].doubleValue
        series = BookSeries(json: json["series"])
        price = json["price"].stringValue
    }
}











