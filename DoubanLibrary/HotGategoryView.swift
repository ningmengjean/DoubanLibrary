//
//  HotView.swift
//  DoubanLibrary
//
//  Created by wangchi on 2018/3/8.
//  Copyright © 2018年 Zhu xiaojin. All rights reserved.
//

import UIKit

class HotGategoryView: UIView {
    
    var isInited = false
    
    var hotCategoryTableView = UITableView()
    
    override func layoutSubviews() {
       
        super.layoutSubviews()
        hotCategoryTableView.register(UITableViewCell.self, forCellReuseIdentifier: "HotCategoryTableViewCell")
        hotCategoryTableView.rowHeight = UITableViewAutomaticDimension
        hotCategoryTableView.estimatedRowHeight = 100.0
        hotCategoryTableView.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 160)
        self.addSubview(hotCategoryTableView)
    }
}

extension HotGategoryView: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "HotCategoryTableView", for: indexPath)
        if indexPath.row == 0 {
            cell.textLabel?.text = "热门"
        } else if indexPath.row == 1 {
            cell.textLabel?.text = "最新"
        } else if indexPath.row == 2 {
            cell.textLabel?.text = "价格低 - 高"
        } else {
            cell.textLabel?.text = "价格高 - 低"
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath)
        cell?.imageView?.frame = CGRect(x: (cell?.frame.maxX)!-25, y: center.y, width: 15, height: 15)
        cell?.imageView?.image = #imageLiteral(resourceName: "choose")
    }
    
    
}
