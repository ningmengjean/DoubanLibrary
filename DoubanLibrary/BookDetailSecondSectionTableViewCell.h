//
//  BookDetailSecondTableViewCell.h
//  DoubanLibrary
//
//  Created by wangchi on 2018/3/26.
//  Copyright © 2018年 Zhu xiaojin. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol showDetailDelegate <NSObject>

@required
- (void)showDetailCell;

@end

@interface BookDetailSecondSectionTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel*  introLabel;
@property (weak, nonatomic) IBOutlet UILabel*  detailLabel;
@property (weak, nonatomic) IBOutlet UIButton*  pullDownButton;
@property (weak, nonatomic) IBOutlet UIImageView *pullDownImageView;
@property (nonatomic, weak) id <showDetailDelegate> delegate;
- (IBAction)showFullContentCell:(UIButton*)sender;

@end
