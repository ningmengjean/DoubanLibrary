//
//  CategoryView.swift
//  DoubanLibrary
//
//  Created by wangchi on 2018/2/9.
//  Copyright © 2018年 Zhu xiaojin. All rights reserved.
//

import UIKit

class CategoryView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    var categoryTableView = UITableView()
    
    var detailCategoryTableView = UITableView()
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        self.addSubview(categoryTableView)
        self.addSubview(detailCategoryTableView)
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
}

extension CategoryView: UITableViewDelegate,UITableViewDataSource {
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
        }
        return 0
    }
        
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == categoryTableView {
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
            categoryIndex = CategoryView.DetailCategoryIndex(rawValue: Int(indexPath.row))!
        }
    }
}


