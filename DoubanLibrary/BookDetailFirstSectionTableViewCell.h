//
//  BookDetailFirstSectionTableViewCell.h
//  DoubanLibrary
//
//  Created by wangchi on 2018/3/25.
//  Copyright © 2018年 Zhu xiaojin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DoubanLibrary-Swift.h"

@interface BookDetailFirstSectionTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *starLabel;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *rateLabel;
@property (weak, nonatomic) IBOutlet UIImageView *bookImageView;
@property (weak, nonatomic) IBOutlet UILabel *authorLabel;
@property (weak, nonatomic) IBOutlet UILabel *translatorLabel;
@property (weak, nonatomic) IBOutlet UILabel *publisherLabel;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;

@end



