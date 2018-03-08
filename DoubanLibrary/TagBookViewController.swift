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
    
    lazy var sortView: UIView = {
        let sortView : SortView = (Bundle.main.loadNibNamed("SortView", owner: nil, options: nil)!.first as? SortView)!
        return sortView
    }()
    
    var categoryToBottomConstraint = NSLayoutConstraint()
    var categoryToTopConstraint = NSLayoutConstraint()
    
    var sortToBottomConstraint = NSLayoutConstraint()
    var sortToTopConstraint = NSLayoutConstraint()
    
    var hotToBottomConstraint = NSLayoutConstraint()
    var hotToTopConstraint = NSLayoutConstraint()
    
    var hotCategoryView = HotGategoryView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        buttonView.frame = CGRect(x: 0, y: 64, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        self.view.addSubview(buttonView)
        buttonView.isUserInteractionEnabled = true
        tagBookTableView.register(UINib(nibName: "TagBookTableViewCell", bundle: nil), forCellReuseIdentifier: "TagBookTableViewCell")
        tagBookTableView.rowHeight = UITableViewAutomaticDimension
        tagBookTableView.estimatedRowHeight = 100.0
        tagBookTableView.tableFooterView = UIView()
        let loadMoreView = KRPullLoadView()
        loadMoreView.delegate = self
        tagBookTableView.addPullLoadableView(loadMoreView, type: .loadMore)
        self.tagBookTableView.addSubview(self.refreshControl)
        categoryText.text! = text!
        categoryText.textColor = UIColor.blue
        self.view.insertSubview(categoryView, aboveSubview: tagBookTableView)
        self.view.insertSubview(sortView, aboveSubview: tagBookTableView)
        self.view.insertSubview(hotCategoryView, aboveSubview: tagBookTableView)
        sortView.backgroundColor = .white
        //add constraint for Category view
        
        categoryView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint(item: categoryView, attribute: .leading, relatedBy: .equal, toItem: view, attribute: .leading, multiplier: 1, constant: 0).isActive = true
        NSLayoutConstraint(item: categoryView, attribute: .trailing, relatedBy: .equal, toItem: view, attribute: .trailing, multiplier: 1, constant: 0).isActive = true
        NSLayoutConstraint(item: categoryView, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: UIScreen.main.bounds.height - 64 - 40).isActive = true
        
        categoryToBottomConstraint = NSLayoutConstraint(item: categoryView, attribute: .bottom, relatedBy: .equal, toItem: categoryButton, attribute: .top, multiplier: 1, constant: 0)
        categoryToBottomConstraint.priority = UILayoutPriority.defaultHigh
        categoryToBottomConstraint.isActive = true
        
        categoryToTopConstraint = NSLayoutConstraint(item: categoryView, attribute: .top, relatedBy: .equal, toItem: categoryButton, attribute: .bottom, multiplier: 1, constant: 0)
        categoryToTopConstraint.priority = UILayoutPriority.defaultLow
        categoryToTopConstraint.isActive = true
        
        //add constraint for Sort view
        
        sortView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint(item: sortView, attribute: .leading, relatedBy: .equal, toItem: view, attribute: .leading, multiplier: 1, constant: 0).isActive = true
        NSLayoutConstraint(item: sortView, attribute: .trailing, relatedBy: .equal, toItem: view, attribute: .trailing, multiplier: 1, constant: 0).isActive = true
        NSLayoutConstraint(item: sortView, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: UIScreen.main.bounds.height - 64 - 40).isActive = true

        sortToBottomConstraint = NSLayoutConstraint(item: sortView, attribute: .bottom, relatedBy: .equal, toItem: categoryButton, attribute: .top, multiplier: 1, constant: 0)
        sortToBottomConstraint.priority = UILayoutPriority.defaultHigh
        sortToBottomConstraint.isActive = true

        sortToTopConstraint = NSLayoutConstraint(item: sortView, attribute: .top, relatedBy: .equal, toItem: categoryButton, attribute: .bottom, multiplier: 1, constant: 0)
        sortToTopConstraint.priority = UILayoutPriority.defaultLow
        sortToTopConstraint.isActive = true
        
        //add constraint for HotGategory view
        
        hotCategoryView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint(item: hotCategoryView, attribute: .leading, relatedBy: .equal, toItem: view, attribute: .leading, multiplier: 1, constant: 0).isActive = true
        NSLayoutConstraint(item: hotCategoryView, attribute: .trailing, relatedBy: .equal, toItem: view, attribute: .trailing, multiplier: 1, constant: 0).isActive = true
        NSLayoutConstraint(item: hotCategoryView, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: UIScreen.main.bounds.height - 64 - 40).isActive = true
        
        hotToBottomConstraint = NSLayoutConstraint(item: hotCategoryView, attribute: .bottom, relatedBy: .equal, toItem: categoryButton, attribute: .top, multiplier: 1, constant: 0)
        hotToBottomConstraint.priority = UILayoutPriority.defaultHigh
        hotToBottomConstraint.isActive = true
        
        hotToTopConstraint = NSLayoutConstraint(item: hotCategoryView, attribute: .top, relatedBy: .equal, toItem: categoryButton, attribute: .bottom, multiplier: 1, constant: 0)
        hotToTopConstraint.priority = UILayoutPriority.defaultLow
        hotToTopConstraint.isActive = true
        
        categoryView.delegate = self
 
        
    }
    
    lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.tintColor = UIColor.blue
        refreshControl.addTarget(self, action: #selector(self.refresh), for: .valueChanged)
        return refreshControl
    }()

    @IBOutlet weak var buttonView: UIView!
    
    @IBOutlet weak var categoryButton: UIButton! {
        didSet {
            categoryButton.layer.borderWidth = 0.5
            categoryButton.layer.borderColor = UIColor.lightGray.cgColor
        }
        
    }
    @IBOutlet weak var sortButton: UIButton! {
        didSet {
            sortButton.layer.borderWidth = 0.5
            sortButton.layer.borderColor = UIColor.lightGray.cgColor
        }
    }
    
    @IBOutlet weak var hotButton: UIButton! {
        didSet {
            hotButton.layer.borderWidth = 0.5
            hotButton.layer.borderColor = UIColor.lightGray.cgColor
        }
    }
    
    @IBOutlet weak var categoryText: UILabel!
    
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    
    @IBOutlet weak var categoryArrowImageView: UIImageView! {
        didSet {
            categoryArrowImageView.image = #imageLiteral(resourceName: "arrow")
        }
    }
    
    @IBOutlet weak var sortArrowImageView: UIImageView! {
        didSet {
            sortArrowImageView.image = #imageLiteral(resourceName: "arrow")
        }
    }
    
    @IBOutlet weak var hotArrowImageView: UIImageView! {
        didSet {
            hotArrowImageView.image = #imageLiteral(resourceName: "arrow")
        }
    }
    
    @IBOutlet weak var tagBookTableView: UITableView! {
        didSet {
            tagBookTableView.delegate = self
            tagBookTableView.dataSource = self
        }
    }
    @IBAction func showCategoryView(_ sender: UIButton) {
        if categoryViewIsOnTheTop {
            view.layoutIfNeeded()
            categoryToTopConstraint.priority = UILayoutPriority.defaultHigh
            categoryToBottomConstraint.priority = UILayoutPriority.defaultLow
            UIView.animate(withDuration: 0.3,
                           delay: 0,
                           options: UIViewAnimationOptions.transitionCurlDown,
                           animations: {
                           self.view.layoutIfNeeded()
                           self.categoryArrowImageView.transform = CGAffineTransform(rotationAngle: CGFloat(Double.pi))
                           self.categoryViewIsOnTheTop = false
            })
        } else {
            view.layoutIfNeeded()
            categoryToTopConstraint.priority = UILayoutPriority.defaultLow
            categoryToBottomConstraint.priority = UILayoutPriority.defaultHigh
            UIView.animate(withDuration: 0.3,
                           delay: 0,
                           options: UIViewAnimationOptions.transitionCurlUp,
                           animations: {
                            self.view.layoutIfNeeded()
                            self.categoryArrowImageView.transform = CGAffineTransform(rotationAngle: CGFloat(Double.pi*2.0))
                            self.categoryViewIsOnTheTop = true
            })
        }
    }
    
    @IBAction func showSortView(_ sender: UIButton) {
        if sortViewIsOnTheTop {
            view.layoutIfNeeded()
            sortToTopConstraint.priority = UILayoutPriority.defaultHigh
            sortToBottomConstraint.priority = UILayoutPriority.defaultLow
            sortView.backgroundColor = .white
            UIView.animate(withDuration: 0.3,
                           delay: 0,
                           options: UIViewAnimationOptions.transitionCurlDown,
                           animations: {
                            self.view.layoutIfNeeded()
                            self.sortArrowImageView.transform = CGAffineTransform(rotationAngle: CGFloat(Double.pi))
                            self.sortViewIsOnTheTop = false
            })
        } else {
            view.layoutIfNeeded()
            sortToTopConstraint.priority = UILayoutPriority.defaultLow
            sortToBottomConstraint.priority = UILayoutPriority.defaultHigh
            UIView.animate(withDuration: 0.3,
                           delay: 0,
                           options: UIViewAnimationOptions.transitionCurlUp,
                           animations: {
                            self.view.layoutIfNeeded()
                            self.sortArrowImageView.transform = CGAffineTransform(rotationAngle: CGFloat(Double.pi*2.0))
                            self.sortViewIsOnTheTop = true
            })
        }
    }
    
    @IBAction func showHotGategoryView(_ sender: UIButton) {
        if hotGategoryViewIsOnTheTop {
            view.layoutIfNeeded()
            hotToTopConstraint.priority = UILayoutPriority.defaultHigh
            hotToBottomConstraint.priority = UILayoutPriority.defaultLow
            UIView.animate(withDuration: 0.3,
                           delay: 0,
                           options: UIViewAnimationOptions.transitionCurlDown,
                           animations: {
                            self.view.layoutIfNeeded()
                            self.hotArrowImageView.transform = CGAffineTransform(rotationAngle: CGFloat(Double.pi))
                            self.hotGategoryViewIsOnTheTop = false
            })
        } else {
            view.layoutIfNeeded()
            hotToTopConstraint.priority = UILayoutPriority.defaultLow
            hotToBottomConstraint.priority = UILayoutPriority.defaultHigh
            UIView.animate(withDuration: 0.3,
                           delay: 0,
                           options: UIViewAnimationOptions.transitionCurlUp,
                           animations: {
                            self.view.layoutIfNeeded()
                            self.hotArrowImageView.transform = CGAffineTransform(rotationAngle: CGFloat(Double.pi*2.0))
                            self.hotGategoryViewIsOnTheTop = true
            })
        }
    }
    
    
    var categoryViewIsOnTheTop = true
    
    var sortViewIsOnTheTop = true

    var hotGategoryViewIsOnTheTop = true
    
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
        categoryToTopConstraint.priority = UILayoutPriority.defaultLow
        categoryToBottomConstraint.priority = UILayoutPriority.defaultHigh
        UIView.animate(withDuration: 0.3,
                       delay: 0,
                       options: UIViewAnimationOptions.transitionCurlUp,
                       animations: {
                        self.view.layoutIfNeeded()
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
