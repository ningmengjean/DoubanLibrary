//
//  BookDetailViewController.h
//  DoubanLibrary
//
//  Created by wangchi on 2018/3/23.
//  Copyright © 2018年 Zhu xiaojin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BookDetailViewController : UIViewController<UITableViewDelegate, UITableViewDataSource> 

@property (weak, nonatomic) IBOutlet UITableView *bookDetailTableView;
@property (nonatomic, strong) NSString *bookTitle;
@property (nonatomic, strong) NSString *rate;
@property (nonatomic, strong) NSString *author;
@property (nonatomic, strong) NSArray *translators;
@property (nonatomic, strong) NSString *publisher;
@property (nonatomic, strong) NSString *price;
@property (nonatomic, strong) NSString *author_intro;
@property (nonatomic, strong) NSString *summary;
@property (nonatomic, strong) UIImage *bookImage;
@property (nonatomic, strong) NSString *bookId;


@end
