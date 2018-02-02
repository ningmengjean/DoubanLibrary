//
//  LibraryBookTagViewController.swift
//  DoubanLibrary
//
//  Created by wangchi on 2018/1/29.
//  Copyright © 2018年 Zhu xiaojin. All rights reserved.
//

import UIKit
import Foundation
import Moya
import SwiftyJSON
import Kingfisher

class LibraryBookTagViewController: UIViewController {
    
    var fullScreenSize :CGSize!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fullScreenSize = UIScreen.main.bounds.size
        self.view.backgroundColor = UIColor.white
    }
    
    @IBOutlet weak var collectionView: UICollectionView! {
        didSet {
            collectionView.delegate = self
            collectionView.dataSource = self
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let cell = sender as? LibraryBookTagCollectionViewCell,segue.identifier == "ShowTagLibrary" {
            let nvc = segue.destination as! UINavigationController
            let controller = nvc.visibleViewController as! TagBookViewController
            if let title = cell.tagButton.currentTitle {
                controller.text = title
            }
        }
    }
    
    var bookTags = ["小说","文学","人文社科","经济管理","科技科普","计算机与互联网","成功励志","生活","少儿"]
}

extension LibraryBookTagViewController: UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return bookTags.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "BookTagCell", for: indexPath) as! LibraryBookTagCollectionViewCell
        cell.tagButton.setTitle(bookTags[indexPath.row], for: .normal)
        cell.tagButton.setTitleColor(UIColor.blue, for: .normal)
        cell.layer.borderWidth = 0.5
        cell.layer.borderColor = UIColor.lightGray.cgColor
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: fullScreenSize.width/3, height: 60)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as! LibraryBookTagCollectionViewCell
        performSegue(withIdentifier:"ShowTagLibrary" , sender: cell)
    }
}









