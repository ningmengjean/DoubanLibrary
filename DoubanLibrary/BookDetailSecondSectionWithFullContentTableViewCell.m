//
//  BookDetailSecondSectionWithFullContentTableViewCell.m
//  DoubanLibrary
//
//  Created by wangchi on 2018/3/31.
//  Copyright © 2018年 Zhu xiaojin. All rights reserved.
//

#import "BookDetailSecondSectionWithFullContentTableViewCell.h"

@implementation BookDetailSecondSectionWithFullContentTableViewCell

- (IBAction)backToShortIntroCell:(UIButton *)sender {
    if ([self.delegate respondsToSelector:@selector(backToSimpleCell)]) {
        [self.delegate backToSimpleCell];
    }
}
@end
