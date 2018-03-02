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

class TagBookViewController: UIViewController, CategoryViewDelegate {

    var start = 0
    
    var categoryView = CategoryView()
    
    var sortView = SortView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tagBookTableView.register(UINib(nibName: "TagBookTableViewCell", bundle: nil), forCellReuseIdentifier: "TagBookTableViewCell")
        tagBookTableView.rowHeight = UITableViewAutomaticDimension
        tagBookTableView.estimatedRowHeight = 100.0
        let loadMoreView = KRPullLoadView()
        loadMoreView.delegate = self
        tagBookTableView.addPullLoadableView(loadMoreView, type: .loadMore)
        self.tagBookTableView.addSubview(self.refreshControl)
        categoryText.text! = text!
        categoryText.textColor = UIColor.blue
        categoryView = CategoryView(frame: CGRect(x: 0, y: -583, width: 375, height: 583))
        sortView = SortView(frame: CGRect(x: 0, y: -583, width: 375, height: 583))
        self.view.insertSubview(categoryView, aboveSubview: tagBookTableView)
        self.view.addSubview(sortView)
        categoryView.delegate = self
        
    }
    
    lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.tintColor = UIColor.blue
        refreshControl.addTarget(self, action: #selector(self.refresh), for: .valueChanged)
        return refreshControl
    }()
    
    @IBOutlet weak var categoryButton: UIButton!
    
    @IBOutlet weak var categoryText: UILabel!
    
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    
    @IBOutlet weak var categoryArrowImageView: UIImageView! {
        didSet {
            categoryArrowImageView.image = #imageLiteral(resourceName: "arrow")
        }
    }
    
    @IBOutlet weak var sortArrowImageView: UIImageView!
    
    @IBOutlet weak var hotArrowImageView: UIImageView!
    
    @IBOutlet weak var tagBookTableView: UITableView! {
        didSet {
            tagBookTableView.delegate = self
            tagBookTableView.dataSource = self
        }
    }
    @IBAction func showCategoryView(_ sender: UIButton) {
        if categoryViewIsOnTheTop {
            UIView.animate(withDuration: 0.3,
                           delay: 0,
                           options: UIViewAnimationOptions.transitionCurlDown,
                           animations: { self.categoryView.frame = CGRect(x: 0, y: 104, width: 375, height: 583)
                           self.categoryArrowImageView.transform = CGAffineTransform(rotationAngle: CGFloat(Double.pi))
                           self.categoryViewIsOnTheTop = false
            })
        } else {
            UIView.animate(withDuration: 0.3,
                           delay: 0,
                           options: UIViewAnimationOptions.transitionCurlUp,
                           animations: { self.categoryView.frame = CGRect(x: 0, y: -583, width: 375, height: 583)
                            self.categoryArrowImageView.transform = CGAffineTransform(rotationAngle: CGFloat(Double.pi*2.0))
                            self.categoryViewIsOnTheTop = true
            })
        }
    }
    
    @IBAction func showSortView(_ sender: UIButton) {
    }
    
    @IBAction func showHotView(_ sender: UIButton) {
    }
    
    var categoryViewIsOnTheTop = true 
    
    var books = [Book]()
    
    var book: Book?
    
    var text: String? {
        didSet {
            getTagBookLibrary(text!, start: start)
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
    
    func getTagBookLibraryFromDetailList(_ tag: String, start: Int) {
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
                    self.books = json["books"].arrayValue.map { Book(json: $0) }
                    self.categoryText.text! = tag 
                    self.categoryText.textColor = UIColor.blue
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
    
    func hideCategoryView() {
        UIView.animate(withDuration: 0.3,
                       delay: 0,
                       options: UIViewAnimationOptions.transitionCurlUp,
                       animations: { self.categoryView.frame = CGRect(x: 0, y: -583, width: 375, height: 583)
                        self.categoryArrowImageView.transform = CGAffineTransform(rotationAngle: CGFloat(Double.pi*2.0))
                        self.categoryViewIsOnTheTop = true
                        self.spinner.startAnimating()
        })
    }
}

extension TagBookViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return books.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TagBookTableViewCell", for: indexPath) as! TagBookTableViewCell
        cell.configureTagBookTableViewCell(books[indexPath.row])
        return cell
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

fileprivate extension String {
    fileprivate func urlEncode() -> String {
        guard let encode = self.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) else { return "" }
        return encode
    }
}
