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
#import "BookDetailSecondSectionWithFullContentTableViewCell.h"
#import "DoubanLibrary-Swift.h"

@interface BookDetailViewController () 

@property(nonatomic,strong) UILabel *titleLabel;

@end

@implementation BookDetailViewController

- (void)viewDidLoad {
    
    [self.bookDetailTableView registerNib:[UINib nibWithNibName:@"BookDetailFirstSectionTableViewCell" bundle:nil] forCellReuseIdentifier:@"BookDetailFirstSectionTableViewCell"];
    [self.bookDetailTableView registerNib:[UINib nibWithNibName:@"BookDetailSecondSectionTableViewCell" bundle:nil] forCellReuseIdentifier:@"BookDetailSecondSectionTableViewCell"];
    [self.bookDetailTableView registerClass:[BookTagTableViewCell class] forCellReuseIdentifier:@"BookTagTableViewCell"];
    [self.bookDetailTableView registerNib:[UINib nibWithNibName:@"BookDetailSecondSectionWithFullContentTableViewCell" bundle:nil] forCellReuseIdentifier:@"BookDetailSecondSectionWithFullContentTableViewCell"];
    self.bookDetailTableView.estimatedRowHeight = 150;
    self.bookDetailTableView.rowHeight = UITableViewAutomaticDimension;
    self.showDetail = YES;
    self.showSecondDetail = YES;
}

-(void)showDetailCell {
    _showDetail = NO;
    [_bookDetailTableView reloadData];
}
-(void)backToSimpleCell {
    _showDetail = YES;
    [_bookDetailTableView reloadData];
}
-(void)showSecondDetailCell {
    _showSecondDetail = NO;
    [_bookDetailTableView reloadData];
}
-(void)backToSecondSimpleCell {
    _showSecondDetail = YES;
    [_bookDetailTableView reloadData];
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
    static NSString  *SecondFullContentCellIdentiferId = @"BookDetailSecondSectionWithFullContentTableViewCell";
    static NSString *ThirdCellIdentiferId = @"BookTagTableViewCell";
    switch (indexPath.section) {
        case 0:{
            BookDetailFirstSectionTableViewCell *cell = (BookDetailFirstSectionTableViewCell *)[tableView dequeueReusableCellWithIdentifier:FirstCellIdentiferId];
            cell.titleLabel.text = _bookTitle;
            cell.rateLabel.text = [NSString stringWithFormat:@"%@", _rate];
            cell.rateLabel.textColor = [UIColor blackColor];
            cell.authorLabel.text = _author;
            cell.authorLabel.textColor = [UIColor blackColor];
            if (_translators.count > 0) {
                cell.translatorLabel.text = _translators[0];
                cell.translatorLabel.textColor = [UIColor blackColor];
            }
            cell.publisherLabel.text = _publisher;
            cell.publisherLabel.textColor = [UIColor blackColor];
            cell.priceLabel.text = _price;
            cell.priceLabel.textColor = [UIColor blackColor];
            cell.bookImageView.image = _bookImage;
            cell.starImageView.image = _starImage;
            return cell;
        }
        case 1: {
            NSString *labelText = _author_intro;
            UIFont *font = [UIFont systemFontOfSize:15];
            CGSize strSize = CGSizeMake([UIScreen mainScreen].bounds.size.width-10, MAXFLOAT);
            NSDictionary *attr= @{NSFontAttributeName:font};
            CGRect labelFrame = [labelText boundingRectWithSize:strSize options:NSStringDrawingUsesLineFragmentOrigin attributes:attr context:nil];
            CGFloat labelHeight = labelFrame.size.height;
            if (labelHeight <= 80) {
                BookDetailSecondSectionTableViewCell *cell = (BookDetailSecondSectionTableViewCell *)[tableView dequeueReusableCellWithIdentifier:SecondCellIdentiferId];
                if (indexPath.row == 1) {
                    cell.introLabel.text = @"作者简介";
                    cell.detailLabel.text = _author_intro;
                    cell.detailLabel.textColor = [UIColor blackColor];
                    cell.pullDownButton.hidden = YES;
                    return cell;
                } else {
                    cell.introLabel.text = @"简介";
                    cell.detailLabel.text = _summary;
                    cell.detailLabel.textColor = [UIColor blackColor];
                    cell.pullDownButton.hidden = YES;
                    return cell;
                }
            } else {
                if (indexPath.row == 1) {
                    BookDetailSecondSectionTableViewCell *cell = (BookDetailSecondSectionTableViewCell *)[tableView dequeueReusableCellWithIdentifier:SecondCellIdentiferId];
                    cell.delegate = self;
                    if (_showDetail) {
                        cell.introLabel.text = @"作者简介";
                        cell.detailLabel.text = _author_intro;
                        cell.detailLabel.textColor = [UIColor blackColor];
                        cell.pullDownImageView.image = [UIImage imageNamed:@"down"];
                        return cell;
                    } else {
                        BookDetailSecondSectionWithFullContentTableViewCell *fullContentCell = (BookDetailSecondSectionWithFullContentTableViewCell *)[tableView dequeueReusableCellWithIdentifier:SecondFullContentCellIdentiferId];
                        fullContentCell.delegate = self;
                        fullContentCell.introLabel.text = @"作者简介";
                        fullContentCell.detailLabel.text = _author_intro;
                        fullContentCell.detailLabel.textColor = [UIColor blackColor];
                        fullContentCell.pullUpImageView.image = [UIImage imageNamed:@"up"];
                        return fullContentCell;
                    }
                } else {
                    BookDetailSecondSectionTableViewCell *cell = (BookDetailSecondSectionTableViewCell *)[tableView dequeueReusableCellWithIdentifier:SecondCellIdentiferId];
                    cell.delegate = self;
                    if (_showSecondDetail) {
                        cell.introLabel.text = @"简介";
                        cell.detailLabel.text = _summary;
                        cell.detailLabel.textColor = [UIColor blackColor];
                        cell.pullDownImageView.image = [UIImage imageNamed:@"down"];
                        return cell;
                    } else {
                        BookDetailSecondSectionWithFullContentTableViewCell *fullContentCell = (BookDetailSecondSectionWithFullContentTableViewCell *)[tableView dequeueReusableCellWithIdentifier:SecondFullContentCellIdentiferId];
                        fullContentCell.delegate = self;
                        fullContentCell.introLabel.text = @"简介";
                        fullContentCell.detailLabel.text = _summary;
                        fullContentCell.detailLabel.textColor = [UIColor blackColor];
                        fullContentCell.pullUpImageView.image = [UIImage imageNamed:@"up"];
                        return fullContentCell;
                    }
                }
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

@end
