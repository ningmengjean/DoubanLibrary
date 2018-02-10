//
//  CategoryView.swift
//  DoubanLibrary
//
//  Created by wangchi on 2018/2/9.
//  Copyright © 2018年 Zhu xiaojin. All rights reserved.
//

import UIKit

protocol CategoryViewDelegate: class {
    func getTagBookLibraryFromDetailList(_ tag: String, start: Int)
}

class CategoryView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    weak var delegate: CategoryViewDelegate?
    
    var categoryTableView = UITableView()
    
    var detailCategoryTableView = UITableView()
    
    var translucentView = UIView()
    
    var detailListTableView = UITableView()
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        self.addSubview(categoryTableView)
        self.addSubview(detailCategoryTableView)
        categoryTableView.frame = CGRect(x: 0, y: 0, width: 125, height: 600)
        detailCategoryTableView.frame = CGRect(x: 125, y: 0, width: 275, height: 600)
        categoryTableView.delegate = self
        categoryTableView.dataSource = self
        detailCategoryTableView.delegate = self
        detailCategoryTableView.dataSource = self
        categoryTableView.register(UITableViewCell.self, forCellReuseIdentifier: "CategoryTableViewCell")
        detailCategoryTableView.register(UITableViewCell.self, forCellReuseIdentifier: "DetailCategoryTableViewCell")
        detailCategoryTableView.rowHeight = UITableViewAutomaticDimension
        detailCategoryTableView.estimatedRowHeight = 100.0
        self.insertSubview(translucentView, aboveSubview: categoryTableView)
        translucentView.frame = CGRect(x: 0, y: 0, width: 375, height: 600)
        translucentView.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        self.insertSubview(detailListTableView, aboveSubview: detailCategoryTableView)
        detailListTableView.frame = CGRect(x: 140, y: 0, width: 235, height: 600)
        detailListTableView.delegate = self
        detailListTableView.dataSource = self
        detailListTableView.register(UITableViewCell.self, forCellReuseIdentifier: "DetailListTableViewCell")
        detailListTableView.rowHeight = UITableViewAutomaticDimension
        detailListTableView.estimatedRowHeight = 100.0
        translucentView.isHidden = true
        detailListTableView.isHidden = true
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
    
    var detailListArrays = CategoryArrays()
    
    enum OriginListIndex: Int {
        case 小说,非小说
    }
    
    var originListIndex: OriginListIndex = .小说 {
        didSet {
            detailListTableView.reloadData()
        }
    }
    
    enum ChineseEbookIndex: Int {
        case 小说,文学,人文社科,经济管理,科技科普,计算机与互联网,成功励志,生活,少儿,艺术设计,漫画绘本,教育考试,杂志
    }
    
    var chineseEbookIndex: ChineseEbookIndex = .小说 {
        didSet {
            detailListTableView.reloadData()
        }
    }
    
    enum EnglishEbookIndex: Int {
        case 文学与小说,传记,人文社科,商业管理与经济学,自助励志,计算机与互联网,科学与技术,儿童与青少年读物,健康,艺术,旅行,运动与户外
    }
    
    var englishEbookIndex: EnglishEbookIndex = .文学与小说 {
        didSet {
            detailListTableView.reloadData()
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
        } else if tableView == detailListTableView {
            switch categoryIndex {
            case .原创写作:
                switch originListIndex {
                case .小说:
                    return detailListArrays.originalNovelist.count
                case .非小说:
                    return detailListArrays.originalNonNovelist.count
                }
            case .中文电子书:
                switch chineseEbookIndex {
                case .小说:
                    return detailListArrays.chineseEbookNovelist.count
                case .文学:
                    return detailListArrays.chineseEbookLiterary.count
                case .人文社科:
                    return detailListArrays.chineseEbookHumanitiesSocialSciences.count
                case .经济管理:
                    return detailListArrays.chineseEbookEcomonicManagement.count
                case .科技科普:
                    return detailListArrays.chineseEbookScience.count
                case .计算机与互联网:
                    return detailListArrays.chineseEbookComputerAndInternet.count
                case .成功励志:
                    return detailListArrays.chineseEbookSuccess.count
                case .生活:
                    return detailListArrays.chineseEbookLife.count
                case .少儿:
                    return detailListArrays.chineseEbookChild.count
                case .艺术设计:
                    return detailListArrays.chineseEbookArtAndDesign.count
                case .漫画绘本:
                    return detailListArrays.chineseEbookComicbook.count
                case .教育考试:
                    return detailListArrays.chineseEbookEducation.count
                case .杂志:
                    return detailListArrays.chineseEbookMagzine.count
                }
            case .英文电子书:
                switch englishEbookIndex {
                case .文学与小说:
                    return detailListArrays.ebookLiterature.count
                case .传记:
                    return detailListArrays.ebookBiographies.count
                case .人文社科:
                    return detailListArrays.ebookHistory.count
                case .商业管理与经济学:
                    return detailListArrays.ebookBusiness.count
                case .自助励志:
                    return detailListArrays.ebookSelfhelp.count
                case .计算机与互联网:
                    return detailListArrays.ebookComputer.count
                case .科学与技术:
                    return detailListArrays.ebookScience.count
                case .儿童与青少年读物:
                    return detailListArrays.ebookChildren.count
                case .健康:
                    return detailListArrays.ebookHealth.count
                case .艺术:
                    return detailListArrays.ebookArt.count
                case .旅行:
                    return detailListArrays.ebookTravel.count
                case .运动与户外:
                    return detailListArrays.ebookSports.count
                }
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
        } else if tableView == detailListTableView {
            let cell = tableView.dequeueReusableCell(withIdentifier: "DetailListTableViewCell", for: indexPath)
            switch categoryIndex {
            case .原创写作:
                switch originListIndex {
                case .小说:
                    cell.textLabel?.text = detailListArrays.originalNovelist[indexPath.row]
                    return cell
                case .非小说:
                    cell.textLabel?.text = detailListArrays.originalNonNovelist[indexPath.row]
                    return cell
                }
            case .中文电子书:
                switch chineseEbookIndex {
                case .小说:
                    cell.textLabel?.text = detailListArrays.chineseEbookNovelist[indexPath.row]
                    return cell
                case .文学:
                    cell.textLabel?.text = detailListArrays.chineseEbookLiterary[indexPath.row]
                    return cell
                case .人文社科:
                    cell.textLabel?.text = detailListArrays.chineseEbookHumanitiesSocialSciences[indexPath.row]
                    return cell
                case .经济管理:
                    cell.textLabel?.text = detailListArrays.chineseEbookEcomonicManagement[indexPath.row]
                    return cell
                case .科技科普:
                    cell.textLabel?.text = detailListArrays.chineseEbookScience[indexPath.row]
                    return cell
                case .计算机与互联网:
                    cell.textLabel?.text = detailListArrays.chineseEbookComputerAndInternet[indexPath.row]
                    return cell
                case .成功励志:
                    cell.textLabel?.text = detailListArrays.chineseEbookSuccess[indexPath.row]
                    return cell
                case .生活:
                    cell.textLabel?.text = detailListArrays.chineseEbookLife[indexPath.row]
                    return cell
                case .少儿:
                    cell.textLabel?.text = detailListArrays.chineseEbookChild[indexPath.row]
                    return cell
                case .艺术设计:
                    cell.textLabel?.text = detailListArrays.chineseEbookArtAndDesign[indexPath.row]
                    return cell
                case .漫画绘本:
                    cell.textLabel?.text = detailListArrays.chineseEbookComicbook[indexPath.row]
                    return cell
                case .教育考试:
                    cell.textLabel?.text = detailListArrays.chineseEbookEducation[indexPath.row]
                    return cell
                case .杂志:
                    cell.textLabel?.text = detailListArrays.chineseEbookMagzine[indexPath.row]
                    return cell
                }
            case .英文电子书:
                switch englishEbookIndex {
                case .文学与小说:
                    cell.textLabel?.text = detailListArrays.ebookLiterature[indexPath.row]
                    cell.textLabel?.numberOfLines = 0
                    cell.textLabel?.lineBreakMode = .byWordWrapping
                    return cell
                case .传记:
                    cell.textLabel?.text = detailListArrays.ebookBiographies[indexPath.row]
                    cell.textLabel?.numberOfLines = 0
                    cell.textLabel?.lineBreakMode = .byWordWrapping
                    return cell
                case .人文社科:
                    cell.textLabel?.text = detailListArrays.ebookHistory[indexPath.row]
                    cell.textLabel?.numberOfLines = 0
                    cell.textLabel?.lineBreakMode = .byWordWrapping
                    return cell
                case .商业管理与经济学:
                    cell.textLabel?.text = detailListArrays.ebookBusiness[indexPath.row]
                    cell.textLabel?.numberOfLines = 0
                    cell.textLabel?.lineBreakMode = .byWordWrapping
                    return cell
                case .自助励志:
                    cell.textLabel?.text = detailListArrays.ebookSelfhelp[indexPath.row]
                    cell.textLabel?.numberOfLines = 0
                    cell.textLabel?.lineBreakMode = .byWordWrapping
                    return cell
                case .计算机与互联网:
                    cell.textLabel?.text = detailListArrays.ebookComputer[indexPath.row]
                    cell.textLabel?.numberOfLines = 0
                    cell.textLabel?.lineBreakMode = .byWordWrapping
                    return cell
                case .科学与技术:
                    cell.textLabel?.text = detailListArrays.ebookScience[indexPath.row]
                    cell.textLabel?.numberOfLines = 0
                    cell.textLabel?.lineBreakMode = .byWordWrapping
                    return cell
                case .儿童与青少年读物:
                    cell.textLabel?.text = detailListArrays.ebookChildren[indexPath.row]
                    cell.textLabel?.numberOfLines = 0
                    cell.textLabel?.lineBreakMode = .byWordWrapping
                    return cell
                case .健康:
                    cell.textLabel?.text = detailListArrays.ebookHealth[indexPath.row]
                    cell.textLabel?.numberOfLines = 0
                    cell.textLabel?.lineBreakMode = .byWordWrapping
                    return cell
                case .艺术:
                    cell.textLabel?.text = detailListArrays.ebookArt[indexPath.row]
                    cell.textLabel?.numberOfLines = 0
                    cell.textLabel?.lineBreakMode = .byWordWrapping
                    return cell
                case .旅行:
                    cell.textLabel?.text = detailListArrays.ebookTravel[indexPath.row]
                    cell.textLabel?.numberOfLines = 0
                    cell.textLabel?.lineBreakMode = .byWordWrapping
                    return cell
                case .运动与户外:
                    cell.textLabel?.text = detailListArrays.ebookSports[indexPath.row]
                    cell.textLabel?.numberOfLines = 0
                    cell.textLabel?.lineBreakMode = .byWordWrapping
                    return cell
                }
            }
        }
        return UITableViewCell()
    }
        
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if tableView == categoryTableView {
            categoryIndex = CategoryView.DetailCategoryIndex(rawValue: Int(indexPath.row))!
            
        } else if tableView == detailCategoryTableView {
            categoryIndex = CategoryView.DetailCategoryIndex(rawValue: Int(indexPath.row)) ?? .中文电子书
            originListIndex = CategoryView.OriginListIndex(rawValue:Int(indexPath.row)) ?? .小说
            chineseEbookIndex = CategoryView.ChineseEbookIndex(rawValue:Int(indexPath.row)) ?? .人文社科
            englishEbookIndex = CategoryView.EnglishEbookIndex(rawValue: Int(indexPath.row)) ?? .传记
            translucentView.isHidden = false
            detailListTableView.isHidden = false
        } else if tableView == detailListTableView {
            let cell = tableView.cellForRow(at: indexPath)
            guard let text = cell?.textLabel?.text else {return}
            delegate?.getTagBookLibraryFromDetailList(text, start: 0)
            CategoryView.animate(withDuration: 0.1, delay: 0, animations: {
                self.isHidden = true 
            })
        }
    }
}


