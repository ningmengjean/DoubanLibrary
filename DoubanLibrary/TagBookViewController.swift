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
    
    lazy var sortView: SortView = {
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
    
    var collecionTagHandler: ((_ text:String, _ start:Int) -> Void)?
    
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
        
        hotCategoryView.searchHotCategoryHandler = { [weak self] (tag, start) in
            self?.provider.request(.searchHotCategoryHandler(tag: tag, start: start)) { [weak self] (result) in
                switch result {
                case .failure(_):
                    DispatchQueue.main.async {
                        self?.showNetworkError()
                    }
                case .success(let moyaResponse):
                    guard let json = self?.parseJSON(moyaResponse.data) else { return }
                    self?.spinner.stopAnimating()
                    DispatchQueue.main.async {
                        self?.book = Book(json: json)
                        self?.books = json["books"].arrayValue.map { Book(json: $0) }
                        self?.hotButton.setTitle(tag, for: .normal)
                        self?.hotButton.setTitleColor(.blue, for: .normal)
                        self?.tagBookTableView.reloadData()
                    }
                }
            }
        }
        
        hotCategoryView.hideHotCategoryView = {
            self.hotToTopConstraint.priority = UILayoutPriority.defaultLow
            self.hotToBottomConstraint.priority = UILayoutPriority.defaultHigh
            UIView.animate(withDuration: 0.3,
                           delay: 0,
                           options: UIViewAnimationOptions.transitionCurlUp,
                           animations: {
                            self.view.layoutIfNeeded()
                            self.hotArrowImageView.transform = CGAffineTransform(rotationAngle: CGFloat(Double.pi*2.0))
                            self.hotCategoryViewIsOnTheTop = true
                            self.spinner.startAnimating()
            })
        }
        
        sortView.searchSortHandler = { [weak self] (tag, start) in
            self?.provider.request(.searchSortHandler(tag: tag, start: start)) { [weak self] (result) in
                switch result {
                case .failure(_):
                    DispatchQueue.main.async {
                        self?.showNetworkError()
                    }
                case .success(let moyaResponse):
                    guard let json = self?.parseJSON(moyaResponse.data) else { return }
                    self?.spinner.stopAnimating()
                    DispatchQueue.main.async {
                        self?.book = Book(json: json)
                        self?.books = json["books"].arrayValue.map { Book(json: $0) }
                        let count = self?.sortView.sortCount
                        if count == 0 {
                           self?.sortButton.setTitle("筛选", for: .normal)
                        } else if count != nil {
                            self?.sortButton.setTitle("筛选(\(count!))", for: .normal)
                        }
                        self?.sortButton.setTitleColor(.blue, for: .normal)
                        self?.tagBookTableView.reloadData()
                    }
                }
            }
        }
        
        sortView.hideSortView = {
            self.sortToTopConstraint.priority = UILayoutPriority.defaultLow
            self.sortToBottomConstraint.priority = UILayoutPriority.defaultHigh
            UIView.animate(withDuration: 0.3,
                           delay: 0,
                           options: UIViewAnimationOptions.transitionCurlUp,
                           animations: {
                            self.view.layoutIfNeeded()
                            self.sortArrowImageView.transform = CGAffineTransform(rotationAngle: CGFloat(Double.pi*2.0))
                            self.sortViewIsOnTheTop = true
                            self.spinner.startAnimating()
            })
        }
        
        self.collecionTagHandler = { (tag, start) in
            self.provider.request(.collecionTagHandler(tag: tag, start: start)) { [weak self] (result) in
                switch result {
                case .failure(_):
                    DispatchQueue.main.async {
                        self?.showNetworkError()
                    }
                case .success(let moyaResponse):
                    guard let json = self?.parseJSON(moyaResponse.data) else { return }
                    self?.spinner.stopAnimating()
                    DispatchQueue.main.async {
                        self?.book = Book(json: json)
                        self?.books = json["books"].arrayValue.map { Book(json: $0) }
                        self?.categoryText.text! = tag
                        self?.categoryText.textColor = UIColor.blue
                        self?.tagBookTableView.reloadData()
                    }
                }
            }
            self.spinner.startAnimating()
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let cell = sender as? TagBookTableViewCell,segue.identifier == "ToBookDetail" {
            let controller = segue.destination as! BookDetailViewController
            controller.bookImage = cell.bookImage.image
            controller.bookId = cell.bookId
            controller.bookTitle = cell.titleLabel.text
            controller.rate = cell.rateLabel.text
            controller.author = cell.authorLabel.text
            controller.translators = cell.translators
            controller.publisher = cell.publisher
            controller.price = cell.priceLabel.text
            controller.author_intro = cell.author_intro
            controller.summary = cell.summaryLabel.text
            controller.tags = cell.tags
            controller.starImage = shotScreenImage
            controller.collecionTagHandler = collecionTagHandler!
        }
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
            sortButton.contentEdgeInsets = UIEdgeInsets(top: 5, left: 10, bottom: 5, right: -30)
        }
    }
    
    @IBOutlet weak var hotButton: UIButton! {
        didSet {
            hotButton.layer.borderWidth = 0.5
            hotButton.layer.borderColor = UIColor.lightGray.cgColor
            hotButton.contentEdgeInsets = UIEdgeInsets(top: 5, left: 10, bottom: 5, right: -30)
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
            if self.sortViewIsOnTheTop == false {
                self.showSortView(sortButton)
            }
            if self.hotCategoryViewIsOnTheTop == false {
                self.showHotGategoryView(hotButton)
            }
          
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
            if self.categoryViewIsOnTheTop == false {
                self.showCategoryView(categoryButton)
            }
            if self.hotCategoryViewIsOnTheTop == false {
                self.showHotGategoryView(hotButton)
            }
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
        if hotCategoryViewIsOnTheTop {
            view.layoutIfNeeded()
            hotToTopConstraint.priority = UILayoutPriority.defaultHigh
            hotToBottomConstraint.priority = UILayoutPriority.defaultLow
            if self.categoryViewIsOnTheTop == false {
                self.showCategoryView(categoryButton)
            }
            if self.sortViewIsOnTheTop == false {
                self.showSortView(sortButton)
            }
            UIView.animate(withDuration: 0.3,
                           delay: 0,
                           options: UIViewAnimationOptions.transitionCurlDown,
                           animations: {
                            self.view.layoutIfNeeded()
                            self.hotArrowImageView.transform = CGAffineTransform(rotationAngle: CGFloat(Double.pi))
                            self.hotCategoryViewIsOnTheTop = false
                            self.categoryViewIsOnTheTop = true
                            self.sortViewIsOnTheTop = true
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
                            self.hotCategoryViewIsOnTheTop = true
            })
        }
    }
    
    
    var categoryViewIsOnTheTop = true
    
    var sortViewIsOnTheTop = true

    var hotCategoryViewIsOnTheTop = true
    
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
        provider.request(.getTagBookLibrary(tag: tag, start: start)) { [weak self] (result) in
            switch result {
            case .failure(_):
                DispatchQueue.main.async {
                    self?.showNetworkError()
                }
            case .success(let moyaResponse):
                guard let json = self?.parseJSON(moyaResponse.data) else { return }
                self?.spinner.stopAnimating()
                DispatchQueue.main.async {
                    self?.book = Book(json: json)
                    self?.books += json["books"].arrayValue.map { Book(json: $0) }
                    self?.categoryText.text! = tag
                    self?.tagBookTableView.reloadData()
                }
            }
        }
    }
    
    func getTagBookLibraryFromDetailList(_ tag: String, start: Int) {
        provider.request(.getTagBookLibrary(tag: tag, start: start)) { [weak self] (result) in
            switch result {
            case .failure(_):
                DispatchQueue.main.async {
                    self?.showNetworkError()
                }
            case .success(let moyaResponse):
                guard let json = self?.parseJSON(moyaResponse.data) else { return }
                self?.spinner.stopAnimating()
                DispatchQueue.main.async {
                    self?.book = Book(json: json)
                    self?.books = json["books"].arrayValue.map { Book(json: $0) }
                    self?.categoryText.text! = tag
                    self?.categoryText.textColor = UIColor.blue
                    self?.tagBookTableView.reloadData()
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
    var shotScreenImage = UIImage()
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as! TagBookTableViewCell
        shotScreenImage = cell.cosmosView.screenshot()
        performSegue(withIdentifier: "ToBookDetail", sender: cell)
        dismiss(animated: true, completion: nil)
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
    }
    
    
}

extension UIView {
    
    func screenshot() -> UIImage {
        return UIGraphicsImageRenderer(size: bounds.size).image { _ in
            drawHierarchy(in: CGRect(origin: .zero, size: bounds.size), afterScreenUpdates: true)
        }
    }
    
}

fileprivate extension String {
    fileprivate func urlEncode() -> String {
        guard let encode = self.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) else { return "" }
        return encode
    }
}
