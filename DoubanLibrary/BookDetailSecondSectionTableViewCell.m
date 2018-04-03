//
//  BookDetailSecondTableViewCell.m
//  DoubanLibrary
//
//  Created by wangchi on 2018/3/26.
//  Copyright © 2018年 Zhu xiaojin. All rights reserved.
//

#import "BookDetailSecondSectionTableViewCell.h"
#import "DoubanLibrary-Swift.h"

@implementation BookDetailSecondSectionTableViewCell


- (IBAction)showFullContentCell:(UIButton *)sender {
    if ([_introLabel.text isEqualToString:@"作者简介"]) {
        [self.delegate showDetailCell];
    } else {
        [self.delegate showSecondDetailCell];
    }
}
@end
