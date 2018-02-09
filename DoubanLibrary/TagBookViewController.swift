//
//  TagBookViewController.swift
//  DoubanLibrary
//
//  Created by wangchi on 2018/1/30.
//  Copyright © 2018年 Zhu xiaojin. All rights reserved.
//

import UIKit
import Foundation
import SwiftyJSON
import Moya
import Cosmos
import KRPullLoader

class TagBookViewController: UIViewController {

    var start = 0
    
    var categoryView = UIView()
    
    var categoryTableView = UITableView()
    
    var detailCategoryTableView = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tagBookTableView.register(UINib(nibName: "TagBookTableViewCell", bundle: nil), forCellReuseIdentifier: "TagBookTableViewCell")
        tagBookTableView.rowHeight = UITableViewAutomaticDimension
        tagBookTableView.estimatedRowHeight = 100.0
        let loadMoreView = KRPullLoadView()
        loadMoreView.delegate = self
        tagBookTableView.addPullLoadableView(loadMoreView, type: .loadMore)
        self.tagBookTableView.addSubview(self.refreshControl)
        categoryButton.setTitle(text!, for: .normal)
        categoryButton.setTitleColor(UIColor.blue, for: .normal)
        self.view.insertSubview(categoryView, aboveSubview: tagBookTableView)
        categoryView.frame = CGRect(x: 0, y: 104, width: 375, height: 583)
        categoryView.addSubview(categoryTableView)
        categoryView.addSubview(detailCategoryTableView)
        categoryTableView.frame = CGRect(x: 0, y: 0, width: 125, height: 583)
        detailCategoryTableView.frame = CGRect(x: 125, y: 0, width: 275, height: 583)
        categoryTableView.delegate = self
        categoryTableView.dataSource = self
        detailCategoryTableView.delegate = self
        detailCategoryTableView.dataSource = self
        categoryTableView.register(UITableViewCell.self, forCellReuseIdentifier: "CategoryTableViewCell")
        detailCategoryTableView.register(UITableViewCell.self, forCellReuseIdentifier: "DetailCategoryTableViewCell")
        detailCategoryTableView.rowHeight = UITableViewAutomaticDimension
        detailCategoryTableView.estimatedRowHeight = 100.0
    }
    
    lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.tintColor = UIColor.blue
        refreshControl.addTarget(self, action: #selector(self.refresh), for: .valueChanged)
        return refreshControl
    }()
    
    @IBOutlet weak var categoryButton: UIButton!
    
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    
    @IBOutlet weak var tagBookTableView: UITableView! {
        didSet {
            tagBookTableView.delegate = self
            tagBookTableView.dataSource = self
        }
    }
    @IBAction func showCategoryView(_ sender: UIButton) {
    }
    @IBAction func showSortView(_ sender: UIButton) {
    }
    @IBAction func showHotView(_ sender: UIButton) {
    }
    
    var books = [Book]()
    
    var book: Book?
    
    var text: String? {
        didSet {
            guard let text = text else {
                return
            }
            getTagBookLibrary(text, start: start)
        }
    }
    
    var categoryArray = ["原创写作","中文电子书","英文电子书"]
    
    var detailCategoryArray1 = ["小说","非小说"]
    
    var detailCategoryArray2 = ["小说","文学","人文社科","经济管理","科技科普","计算机与互联网","成功励志","生活","少儿","艺术设计","漫画绘本","教育考试","杂志"]
    
    var detailCategoryArray3 = ["Literature & Fiction\n文学与小说","Biographies\n传记","History,Philosophy & Social Sciences\n人文社科","Business & Economics\n商业管理与经济学","Self-help & Motivation\n自助励志","Computer & Internet\n计算机与互联网","Science & Technology\n科学与技术","Children,Teen & Young Adult's eBooks\n儿童与青少年读物","Health,Family & Lifestyle\n健康，家庭与生活方式","Art\n艺术","Travel\n旅行"]
    
    enum DetailCategoryIndex: Int {
        case 原创写作,中文电子书,英文电子书
    }
    
    var categoryIndex: DetailCategoryIndex = .中文电子书 {
        didSet{
            detailCategoryTableView.reloadData()
        }
    }
    
    func parseJSON(_ data: Data) -> JSON {
        return try! JSON(data: data)
    }
    
    func showNetworkError() {
        let alert = UIAlertController(
            title: "Whoops...",
            message:
            "There was an error with your networking. Please try again.",
            preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    
    let provider = MoyaProvider<NetworkService>(plugins: [NetworkLoggerPlugin()])
    
    func getTagBookLibrary(_ tag: String, start: Int) {
        provider.request(.getTagBookLibrary(tag: tag, start: start)) { (result) in
            switch result {
            case .failure(_):
                DispatchQueue.main.async {
                    self.showNetworkError()
                }
            case .success(let moyaResponse):
                let json = self.parseJSON(moyaResponse.data)
                self.spinner.stopAnimating()
                DispatchQueue.main.async {
                    self.book = Book(json: json)
                    self.books += json["books"].arrayValue.map { Book(json: $0) }
                    self.tagBookTableView.reloadData()
                }
            }
        }
    }
    
    func getMore() {
        start += 20
        getTagBookLibrary(text!, start: start)
    }

    @objc
    func refresh() {
        start = 0
        books = [Book]()
        getTagBookLibrary(text!, start: start)
        tagBookTableView.reloadData()
        refreshControl.endRefreshing()
    }

}

extension TagBookViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == categoryTableView {
            return categoryArray.count
        } else if tableView == detailCategoryTableView {
            switch categoryIndex {
            case .原创写作:
                return detailCategoryArray1.count
            case .中文电子书:
                return detailCategoryArray2.count
            case .英文电子书:
                return detailCategoryArray3.count
            }
        } else if tableView == tagBookTableView {
            return books.count
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == tagBookTableView {
            let cell = tableView.dequeueReusableCell(withIdentifier: "TagBookTableViewCell", for: indexPath) as! TagBookTableViewCell
            cell.configureTagBookTableViewCell(books[indexPath.row])
            return cell
        } else if tableView == categoryTableView {
            let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryTableViewCell", for: indexPath)
            cell.textLabel?.text = categoryArray[indexPath.row]
            return cell
        } else if tableView == detailCategoryTableView {
            let cell = tableView.dequeueReusableCell(withIdentifier: "DetailCategoryTableViewCell", for: indexPath)
            switch categoryIndex {
            case .原创写作:
                 cell.textLabel?.text = detailCategoryArray1[indexPath.row]
                return cell
            case .中文电子书:
                cell.textLabel?.text = detailCategoryArray2[indexPath.row]
                return cell
            case .英文电子书:
                cell.textLabel?.text = detailCategoryArray3[indexPath.row]
                cell.textLabel?.numberOfLines = 0
                cell.textLabel?.lineBreakMode = .byWordWrapping
                return cell
            }
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if tableView == categoryTableView {
            categoryIndex = TagBookViewController.DetailCategoryIndex(rawValue: Int(indexPath.row))!
        }
    }
}

extension TagBookViewController: KRPullLoadViewDelegate {
    func pullLoadView(_ pullLoadView: KRPullLoadView, didChangeState state: KRPullLoaderState, viewType type: KRPullLoaderType) {
        if type == .loadMore {
            switch state {
            case let .loading(completionHandler):
                DispatchQueue.main.asyncAfter(deadline: DispatchTime.now()+1) {
                    self.getMore()
                    completionHandler()
                    self.tagBookTableView.reloadData()
                }
            default: break
            }
            return
        }
        
        switch state {
        case .none:
            pullLoadView.messageLabel.text = ""
            
        case let .pulling(offset, threshould):
            if offset.y > threshould {
                pullLoadView.messageLabel.text = "Pull more. offset: \(Int(offset.y)), threshould: \(Int(threshould)))"
            } else {
                pullLoadView.messageLabel.text = "Release to refresh. offset: \(Int(offset.y)), threshould: \(Int(threshould)))"
            }
            
        case let .loading(completionHandler):
            pullLoadView.messageLabel.text = "Updating..."
            //            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now()+1) {
            completionHandler()
            self.tagBookTableView.reloadData()
            //            }
        }
    }
}
