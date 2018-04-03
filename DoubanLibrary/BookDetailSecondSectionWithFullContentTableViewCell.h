//
//  BookDetailSecondSectionWithFullContentTableViewCell.h
//  DoubanLibrary
//
//  Created by wangchi on 2018/3/31.
//  Copyright © 2018年 Zhu xiaojin. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol backToSimpleCellDelegate <NSObject>

@required
- (void)backToSimpleCell;
- (void)backToSecondSimpleCell;

@end

@interface BookDetailSecondSectionWithFullContentTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *introLabel;
@property (weak, nonatomic) IBOutlet UILabel *detailLabel;
@property (weak, nonatomic) IBOutlet UIButton *pullUpButton;
@property (weak, nonatomic) IBOutlet UIImageView *pullUpImageView;
@property (nonatomic, weak) id <backToSimpleCellDelegate> delegate;

- (IBAction)backToShortIntroCell:(UIButton *)sender;

@end
