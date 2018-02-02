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


class TagBookViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tagBookTableView.register(UINib(nibName: "TagBookTableViewCell", bundle: nil), forCellReuseIdentifier: "TagBookTableViewCell")
        tagBookTableView.rowHeight = UITableViewAutomaticDimension
        tagBookTableView.estimatedRowHeight = 100.0
    }
    
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    
    @IBOutlet weak var tagBookTableView: UITableView! {
        didSet {
            tagBookTableView.delegate = self
            tagBookTableView.dataSource = self
        }
    }
    
    var tagBookResult: TagBookModel? {
        didSet {
            tagBookTableView.reloadData()
        }
    }
    
    var text: String? {
        didSet {
            guard let text = text else {
                return
            }
            getTagBookLibrary(text)
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
    
    func getTagBookLibrary(_ tag: String) {
        provider.request(.getTagBookLibrary(tag: text!)) { (result) in
            switch result {
            case .failure(_):
                DispatchQueue.main.async {
                    self.showNetworkError()
                }
            case .success(let moyaResponse):
                let json = self.parseJSON(moyaResponse.data)
                self.spinner.stopAnimating()
                DispatchQueue.main.async {
                    self.tagBookResult = TagBookModel(json: json)
                }
            }
        }
    }

}

extension TagBookViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return  20
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TagBookTableViewCell", for: indexPath) as! TagBookTableViewCell
        if let result = tagBookResult {
            cell.configureTagBookTableViewCell(result,indexPath: indexPath)
        }
        return cell
    }
    
    
}
