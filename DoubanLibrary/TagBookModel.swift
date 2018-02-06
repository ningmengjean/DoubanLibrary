//
//  TagBookModel.swift
//  DoubanLibrary
//
//  Created by wangchi on 2018/1/30.
//  Copyright © 2018年 Zhu xiaojin. All rights reserved.
//

import Foundation

import SwiftyJSON

struct BookRating {
    let max: Int
    let numRaters: Int
    let average: Double
    let min: Int
    
    init(json: JSON) {
        max = json["max"].intValue
        numRaters = json["numRaters"].intValue
        average = json["average"].doubleValue
        min = json["min"].intValue
    }
}

struct BooKTag {
    let count:Int
    let name: String
    let title: String
    
    init(json: JSON) {
        count = json["count"].intValue
        name = json["name"].stringValue
        title = json["title"].stringValue
    }
}

struct Images {
    let small: String
    let large: String
    let medium: String
    init(json: JSON) {
        small = json["small"].stringValue
        large = json["large"].stringValue
        medium = json["medium"].stringValue
    }
    
    var mediumImageURL: URL? {
        return URL(string: medium)
    }
}

struct BookSeries {
    let id: String
    let title: String
    init(json: JSON) {
        id = json["id"].stringValue
        title = json["title"].stringValue
    }
}

struct Book {
    let tags: [BooKTag]
    let rating: BookRating
    let subTitle: String
    let author: String
    let pubdate: String
    let originTitle: String
    let image: URL?
    let binding: String
    var translators: [String]
    let catalog: String
    let ebook_url: URL?
    let pages: Int
    let images: Images
    let alt: String
    let id: String
    let publisher: String
    let isbn10: String
    let isbn13: String
    let title: String
    let url: URL?
    let alt_title: String
    let author_intro: String
    let summary: String
    let ebook_price: Double
    let series: BookSeries
    let price: String
    
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
        alt = json["alt"].stringValue
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











