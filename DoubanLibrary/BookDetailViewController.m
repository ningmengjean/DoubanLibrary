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

@property(nonatomic,strong) UILabel *titleLabel;

@end

@implementation BookDetailViewController

- (void)viewDidLoad {
    
    [self.bookDetailTableView registerNib:[UINib nibWithNibName:@"BookDetailFirstSectionTableViewCell" bundle:nil] forCellReuseIdentifier:@"BookDetailFirstSectionTableViewCell"];
    [self.bookDetailTableView registerNib:[UINib nibWithNibName:@"BookDetailSecondSectionTableViewCell" bundle:nil] forCellReuseIdentifier:@"BookDetailSecondSectionTableViewCell"];
    [self.bookDetailTableView registerClass:[BookTagTableViewCell class] forCellReuseIdentifier:@"BookTagTableViewCell"];
    self.bookDetailTableView.estimatedRowHeight = 150;
    self.bookDetailTableView.rowHeight = UITableViewAutomaticDimension;
    
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 4;
}
- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    switch (section) {
        case 0:
            return 1;
        case 1:
            return 2;
        case 2:
            return 1;
        case 3:
            return 1;
    }
    return 0;
}

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    static NSString  *FirstCellIdentiferId = @"BookDetailFirstSectionTableViewCell";
    static NSString  *SecondCellIdentiferId = @"BookDetailSecondSectionTableViewCell";
    static NSString *ThirdCellIdentiferId = @"BookTagTableViewCell";
    switch (indexPath.section) {
        case 0:{
            BookDetailFirstSectionTableViewCell *cell = (BookDetailFirstSectionTableViewCell *)[tableView dequeueReusableCellWithIdentifier:FirstCellIdentiferId];
            cell.titleLabel.text = _bookTitle;
//            cell.titleLabel.textColor = [UIColor blueColor];
            cell.rateLabel.text = [NSString stringWithFormat:@"%@", _rate];
            cell.rateLabel.textColor = [UIColor blueColor];
            cell.authorLabel.text = _author;
            cell.authorLabel.textColor = [UIColor blueColor];
            if (_translators.count > 0) {
                cell.translatorLabel.text = _translators[0];
                cell.translatorLabel.textColor = [UIColor blueColor];
            }
            cell.publisherLabel.text = _publisher;
            cell.publisherLabel.textColor = [UIColor blueColor];
            cell.priceLabel.text = _price;
            cell.priceLabel.textColor = [UIColor blueColor];
            cell.bookImageView.image = _bookImage;
            cell.starImageView.image = _starImage;
            return cell;
        }
        case 1: {
            BookDetailSecondSectionTableViewCell *cell = (BookDetailSecondSectionTableViewCell *)[tableView dequeueReusableCellWithIdentifier:SecondCellIdentiferId];
            if (indexPath.row == 1) {
                cell.introLabel.text = @"作者简介";
                cell.detailLabel.text = _author_intro;
                cell.detailLabel.textColor = [UIColor blueColor];
                return cell;
            } else {
                cell.introLabel.text = @"简介";
                cell.detailLabel.text = _summary;
                cell.detailLabel.textColor = [UIColor blueColor];
                return cell;
            }
        }
        case 2: {
            BookTagTableViewCell *cell = (BookTagTableViewCell*)[tableView dequeueReusableCellWithIdentifier:ThirdCellIdentiferId];
            cell.dataSource = _tags;
            cell.sendTagLabelTextHandler = ^(NSString *text) { 
                self.collecionTagHandler(text, 0);
                [self.navigationController popViewControllerAnimated:YES];
            };
            UILabel *_titleLabel = [[ UILabel alloc] init];
            _titleLabel.text = @"标签";
            _titleLabel.font = [UIFont systemFontOfSize:20];
            _titleLabel.frame = CGRectMake(20,5,50,30) ;
            _titleLabel.backgroundColor = [UIColor clearColor];
            _titleLabel.textColor = [UIColor blackColor];
            [cell addSubview:_titleLabel];
            return cell;
        }
        case 3: {
            UITableViewCell *cell = [[UITableViewCell alloc]init];
            return cell;
        }
    }
    return [[UITableViewCell alloc] init];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
   
}


@end
