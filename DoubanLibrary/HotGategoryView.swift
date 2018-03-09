//
//  HotView.swift
//  DoubanLibrary
//
//  Created by wangchi on 2018/3/8.
//  Copyright © 2018年 Zhu xiaojin. All rights reserved.
//

import UIKit

class HotGategoryView: UIView {
    
    var hotCategoryTableView = UITableView()
    
    var isInited = false
    override func layoutSubviews() {
        super.layoutSubviews()
        if !isInited {
        hotCategoryTableView.register(UINib(nibName: "HotCategoryTableViewCell", bundle: nil), forCellReuseIdentifier: "HotCategoryTableViewCell")
        hotCategoryTableView.rowHeight = UITableViewAutomaticDimension
        hotCategoryTableView.estimatedRowHeight = 44.0
        hotCategoryTableView.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 176)
        hotCategoryTableView.backgroundColor = .black
        self.addSubview(hotCategoryTableView)
        hotCategoryTableView.delegate = self
        hotCategoryTableView.dataSource = self
        }
        
    }
    
    var hotCategoryArray = ["热门","最新","价格低 - 高","价格高 - 低"]
    
    var searchHotCategoryHandler: ((String,Int) -> ())?
    var start = 0
    var hideHotCategoryView: (() -> Void)?
}

extension HotGategoryView: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "HotCategoryTableViewCell", for: indexPath) as! HotCategoryTableViewCell
        cell.hotCategoryName.text = hotCategoryArray[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as! HotCategoryTableViewCell
        cell.chooseImageView.image = #imageLiteral(resourceName: "choose")
        cell.selectionStyle = .none
        guard let tag = cell.hotCategoryName.text, let searchHandler = searchHotCategoryHandler, let hideHotCategoryView = hideHotCategoryView  else { return }
        searchHandler(tag, start)
        hideHotCategoryView()
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as! HotCategoryTableViewCell
        cell.chooseImageView.image = nil
    }
    
}













