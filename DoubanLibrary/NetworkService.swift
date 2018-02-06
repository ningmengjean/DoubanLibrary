//
//  TagBookViewController.swift
//  DoubanLibrary
//
//  Created by wangchi on 2018/1/30.
//  Copyright © 2018年 Zhu xiaojin. All rights reserved.
//


import Foundation
import Moya

enum NetworkService {
    case getTagBookLibrary(tag: String, start: Int)
}

extension NetworkService: TargetType {
    var headers: [String: String]? {
        return nil
    }

    var baseURL: URL { return URL(string:"https://api.douban.com/v2/book")!}
    var path: String {
        switch self {
        case .getTagBookLibrary(tag: _):
            return "/search"
        }
    }
    var method: Moya.Method {
        switch self {
        case .getTagBookLibrary(tag: _):
            return .get
        }
    }
    var task: Task {
        switch self {
        case .getTagBookLibrary(let name, let start):
            return .requestParameters(parameters: ["tag": name, "start": start], encoding: URLEncoding.queryString)
        }
    }

    var sampleData: Data {
        return Data()
    }

    var validate: Bool {
        return false
    }
}



