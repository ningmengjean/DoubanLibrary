//
//  BookTagTableViewCell.swift
//  
//
//  Created by wangchi on 2016/12/1.
//  Copyright © 2016年 EventBank. All rights reserved.
//

import UIKit

@objc class BookTagTableViewCell: UITableViewCell, UICollectionViewDataSource, UICollectionViewDelegate {
    
    @objc public var dataSource = [String]() {
        didSet {
            collectionView.reloadData()
            layoutIfNeeded()
        }
    }

    private var textLabelColor: UIColor = UIColor.blue

    private var collectionCellBackgroundColor: UIColor = UIColor.black.withAlphaComponent(0.1)
    
// configure label with different colors
//    func configure(with dataSource: [String],
//                   textColor: UIColor = UIColor.blue,
//                   backgroundColor: UIColor = UIColor.white,
//                   collectionCellBackgroundColor: UIColor = UIColor.black.withAlphaComponent(0.1))
//    {
//        self.dataSource = dataSource
//        self.textLabelColor = textColor
//        self.backgroundColor = backgroundColor
//        self.collectionCellBackgroundColor = collectionCellBackgroundColor
//
//        collectionView.reloadData()
//        layoutIfNeeded()
//    }

    lazy var collectionView: BookTagCollectionView = {
        let flowlayout = BookTagFlowLayout()
        let collectionView = BookTagCollectionView(frame: CGRect.zero, collectionViewLayout: flowlayout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = UIColor.clear
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.isScrollEnabled = false
        if #available(iOS 10.0, *) {
            collectionView.isPrefetchingEnabled = false
        }
        collectionView.register(BookTagCollectionViewCell.self, forCellWithReuseIdentifier: "BookTagCollectionViewCell")
        return collectionView
    }()
    
    var isInited = false

    override func layoutSubviews() {
        collectionView.invalidateIntrinsicContentSize()
        super.layoutSubviews()
        if !isInited {
            isInited = true
      
            contentView.addSubview(collectionView)
            NSLayoutConstraint(item: collectionView, attribute: .leading, relatedBy: .equal, toItem: contentView, attribute: .leading, multiplier: 1, constant: 10).isActive = true
            NSLayoutConstraint(item: collectionView, attribute: .trailing, relatedBy: .equal, toItem: contentView, attribute: .trailing, multiplier: 1, constant: -10).isActive = true
            NSLayoutConstraint(item: collectionView, attribute: .top, relatedBy: .equal, toItem: contentView, attribute: .top, multiplier: 1, constant: 40).isActive = true
            NSLayoutConstraint(item: collectionView, attribute: .bottom, relatedBy: .equal, toItem: contentView, attribute: .bottom, multiplier: 1, constant: -20).isActive = true

            selectionStyle = .none
        }
        
    }
    
    @objc var sendTagLabelTextHandler: ((String) -> Void)?
    
    @objc func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "BookTagCollectionViewCell", for: indexPath) as! BookTagCollectionViewCell
        cell.textLabel.text = dataSource[indexPath.item]
        cell.textLabel.textColor = textLabelColor
        cell.sendTagLabelTextHandler = { [weak self] text in
            self?.sendTagLabelTextHandler?(text)
        }
        cell.backgroundColor = collectionCellBackgroundColor
        cell.layer.cornerRadius = 8
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataSource.count
    }
}


@objc class BookTagCollectionView: UICollectionView {
    override var intrinsicContentSize: CGSize {
        layoutIfNeeded()
        return CGSize(width: UIViewNoIntrinsicMetric, height: collectionViewLayout.collectionViewContentSize.height)
    }
    
}

@objc class BookTagCollectionViewCell: UICollectionViewCell {
    
    lazy var textLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = UIColor.clear
        label.textColor = UIColor.white
        label.font = UIFont.systemFont(ofSize: 15)
        label.textAlignment = .center
        label.isUserInteractionEnabled = true
        let tap = UITapGestureRecognizer(target: self, action: #selector(BookTagCollectionViewCell.tapFunction))
        label.addGestureRecognizer(tap)
        return label
    }()
    
    @objc var sendTagLabelTextHandler: ((String) -> Void)?
    
    @objc func tapFunction(sender:UITapGestureRecognizer) {
        sendTagLabelTextHandler!(textLabel.text!)
    }
    
    var isInited = false
    
    override func layoutSubviews() {
        super.layoutSubviews()
        if !isInited {
            isInited = true
            
            contentView.addSubview(textLabel)
            NSLayoutConstraint(item: textLabel, attribute: .centerX, relatedBy: .equal, toItem: contentView, attribute: .centerX, multiplier: 1, constant: 0).isActive = true
            NSLayoutConstraint(item: textLabel, attribute: .centerY, relatedBy: .equal, toItem: contentView, attribute: .centerY , multiplier: 1, constant: 0).isActive = true
            NSLayoutConstraint(item: textLabel, attribute: .leading, relatedBy: .equal, toItem: contentView, attribute: .leading, multiplier: 1, constant: 4).isActive = true
            NSLayoutConstraint(item: textLabel, attribute: .trailing, relatedBy: .equal, toItem: contentView, attribute: .trailing, multiplier: 1, constant: -4).isActive = true
        }
    }
    
    override func preferredLayoutAttributesFitting(_ layoutAttributes: UICollectionViewLayoutAttributes) -> UICollectionViewLayoutAttributes {
        let attributes = super.preferredLayoutAttributesFitting(layoutAttributes)
        var frame = NSString(string: textLabel.text!).boundingRect(with: CGSize(width: Int(intmax_t()), height: Int(textLabel.frame.size.height)), options: NSStringDrawingOptions.usesLineFragmentOrigin, attributes: [NSAttributedStringKey.font:textLabel.font], context: nil)
        //make sure the cell not wider than collectionView if text is too long
        if frame.width > 260 {
            frame.size.width = 260
        }
        attributes.frame = frame.insetBy(dx: -9, dy: -2)
        return attributes
    }
    
}

@objc class BookTagFlowLayout: UICollectionViewFlowLayout {
    
    override init() {
        super.init()
        estimatedItemSize = CGSize(width: 20, height: 20)
        sectionInset = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let maxSpacing: CGFloat = 5
    
    override func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
        return true
    }
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        guard let attrs = super.layoutAttributesForElements(in: rect) else { return super.layoutAttributesForElements(in: rect) }
        attrs.forEach { $0.frame = layoutAttributesForItem(at: $0.indexPath)?.frame ?? CGRect.zero }
        return attrs
    }
    
    override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        guard let attrs = super.layoutAttributesForItem(at: indexPath) else { return super.layoutAttributesForItem(at: indexPath) }
        let sectionInset = (collectionView!.collectionViewLayout as! UICollectionViewFlowLayout).sectionInset
        if indexPath.item == 0 {
            var frame = attrs.frame
            frame.origin.x = sectionInset.left
            attrs.frame = frame
            return attrs
        }
        
        let previousIndexPath = IndexPath(item: indexPath.item - 1, section: indexPath.section)
        let previousFrame = layoutAttributesForItem(at: previousIndexPath)!.frame
        let previousFrameRightPoint = previousFrame.origin.x + previousFrame.width + maxSpacing
        let currentFrame = attrs.frame
        let strecthedCurrentFrame = CGRect(x: 0, y: currentFrame.origin.y, width: collectionView!.frame.width, height: currentFrame.height)
        if !previousFrame.intersects(strecthedCurrentFrame) {
            var frame = attrs.frame
            frame.origin.x = sectionInset.left
            attrs.frame = frame
            return attrs
        }
        
        var frame = attrs.frame
        frame.origin.x = previousFrameRightPoint
        attrs.frame = frame
        return attrs
    }
}


