//
//  BookDetailViewController.h
//  DoubanLibrary
//
//  Created by wangchi on 2018/3/23.
//  Copyright © 2018年 Zhu xiaojin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BookDetailSecondSectionTableViewCell.h"
#import "BookDetailSecondSectionWithFullContentTableViewCell.h"

@interface BookDetailViewController : UIViewController<UITableViewDelegate, UITableViewDataSource, showDetailDelegate,backToSimpleCellDelegate>

@property (weak, nonatomic) IBOutlet UITableView * _Nullable bookDetailTableView;
@property (nonatomic,strong) NSString * _Nullable bookTitle;
@property (nonatomic,strong) NSString * _Nullable rate;
@property (nonatomic,strong) NSString * _Nullable author;
@property (nonatomic,strong) NSArray * _Nullable translators;
@property (nonatomic,strong) NSString * _Nullable publisher;
@property (nonatomic,strong) NSString * _Nullable price;
@property (nonatomic,strong) NSString * _Nullable author_intro;
@property (nonatomic,strong) NSString * _Nullable summary;
@property (nonatomic,strong) UIImage * _Nullable bookImage;
@property (nonatomic,strong) NSString * _Nullable bookId;
@property (nonatomic,strong) NSArray * _Nullable tags;
@property (nonatomic,strong) UIImage * _Nullable starImage;
@property (nonatomic,assign) BOOL showDetail;
@property (nonatomic,assign) BOOL showSecondDetail;

typedef void(^collecionTagHandler)(NSString* _Nonnull tag,NSInteger start);
@property (nonatomic, copy) collecionTagHandler _Nonnull collecionTagHandler;

@end
