//
//  BookDetailViewController.m
//  DoubanLibrary
//
//  Created by wangchi on 2018/3/23.
//  Copyright © 2018年 Zhu xiaojin. All rights reserved.
//

#import "BookDetailViewController.h"
#import "BookDetailFirstSectionTableViewCell.h"
#import "BookDetailSecondSectionTableViewCell.h"
#import "DoubanLibrary-Swift.h"

@interface BookDetailViewController () 


@end

@implementation BookDetailViewController

- (void)viewDidLoad {
    
    [self.bookDetailTableView registerNib:[UINib nibWithNibName:@"BookDetailFirstSectionTableViewCell" bundle:nil] forCellReuseIdentifier:@"BookDetailFirstSectionTableViewCell"];
    [self.bookDetailTableView registerNib:[UINib nibWithNibName:@"BookDetailSecondSectionTableViewCell" bundle:nil] forCellReuseIdentifier:@"BookDetailSecondSectionTableViewCell"];
    self.bookDetailTableView.estimatedRowHeight = 150;
    self.bookDetailTableView.rowHeight = UITableViewAutomaticDimension;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
}
- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    switch (section) {
        case 0:
            return 1;
        case 1:
            return 2;
        case 2:
            return 1;
    }
    return 0;
}

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    static  NSString  *FirstCellIdentiferId = @"BookDetailFirstSectionTableViewCell";
    static  NSString  *SecondCellIdentiferId = @"BookDetailSecondSectionTableViewCell";
    switch (indexPath.section) {
        case 0:{
            BookDetailFirstSectionTableViewCell *cell = (BookDetailFirstSectionTableViewCell *)[tableView dequeueReusableCellWithIdentifier:FirstCellIdentiferId];
            cell.titleLabel.text = _bookTitle;
            cell.rateLabel.text = [NSString stringWithFormat:@"%@", _rate];
            cell.authorLabel.text = _author;
            if (_translators.count > 0) {
                cell.translatorLabel.text = _translators[0];
            }
            cell.publisherLabel.text = _publisher;
            cell.priceLabel.text = _price;
            cell.bookImageView.image = _bookImage;
            return cell;
        }
        case 1: {
            BookDetailSecondSectionTableViewCell *cell = (BookDetailSecondSectionTableViewCell *)[tableView dequeueReusableCellWithIdentifier:SecondCellIdentiferId];
            if (indexPath.row == 1) {
                cell.introLabel.text = @"作者简介";
                cell.detailLabel.text = _author_intro;
                return cell;
            } else {
                cell.introLabel.text = @"简介";
                cell.detailLabel.text = _summary;
                return cell;
            }
        }
        case 2: {
            
            return [[UITableViewCell alloc] init];
        }
    }
    return [[UITableViewCell alloc] init];
}

@end
