//
//  ZDICommentsView.m
//  iOS知乎日报
//
//  Created by 涂强尧 on 2018/11/19.
//  Copyright © 2018 涂强尧. All rights reserved.
//

#import "ZDICommentsView.h"
#import <Masonry.h>
#import "ZDICommentsTableViewCell.h"
#import "UIImageView+WebCache.h"

@implementation ZDICommentsView

- (void)commentsViewInit {
    _tableView = [[UITableView alloc] init];
    _tableView.separatorStyle = UITableViewStyleGrouped;
    _tableView.dataSource = self;
    [self addSubview:_tableView];
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self);
        make.bottom.equalTo(self).offset(-50);
        make.left.and.right.equalTo(self);
    }];
    [_tableView registerClass:[ZDICommentsTableViewCell class] forCellReuseIdentifier:@"comments"];
    
    _bottonView = [[UIView alloc] init];
    _bottonView.backgroundColor = [UIColor colorWithRed:0.24f green:0.24f blue:0.24f alpha:1.00f];
    [self addSubview:_bottonView];
    [_bottonView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self->_tableView.mas_bottom);
        make.bottom.equalTo(self);
        make.left.and.right.equalTo(self);
    }];
                              
    _backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_backButton setImage:[UIImage imageNamed:@"2fanhui"] forState:UIControlStateNormal];
    _backButton.tintColor = [UIColor whiteColor];
    [_bottonView addSubview:_backButton];
    [_backButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(0);
        make.left.mas_equalTo(0);
        make.size.mas_equalTo(CGSizeMake([UIScreen mainScreen].bounds.size.width/5, 50));
    }];
    
    _readButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_readButton setTitle:@"写点评" forState:UIControlStateNormal];
    [_bottonView addSubview:_readButton];
    [_readButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(0);
        make.left.mas_equalTo([UIScreen mainScreen].bounds.size.width/5);
        make.size.mas_equalTo(CGSizeMake([UIScreen mainScreen].bounds.size.width/5*4, 50));
    }];
    
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSInteger longNumber = [[_allJSONModel valueForKey:@"comments"] count];
    NSInteger shortNumber = [[_allShortJSONModel valueForKey:@"comments"] count];
    NSArray *array = [NSArray arrayWithObjects:@(longNumber), @(shortNumber), nil];
    return [[array objectAtIndex:section] integerValue];
}

- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ZDICommentsTableViewCell *cell = nil;
    ZDICommentsTableViewCell *cell1 = nil;
    if (indexPath.section == 0) {
        if (cell == nil) {
            cell = [_tableView dequeueReusableCellWithIdentifier:@"comments" forIndexPath:indexPath];
        }
        
        cell.nameLabel.text = [_allJSONModel.comments[indexPath.row] valueForKey:@"author"];
        [cell.zanButton setTitle:[NSString stringWithFormat:@"%@", [_allJSONModel.comments[indexPath.row] valueForKey:@"likes"]] forState:UIControlStateNormal];
        cell.pinglinTextLabel.text = [_allJSONModel.comments[indexPath.row] valueForKey:@"content"];
        
        NSString *replyContentString = [[_allJSONModel.comments[indexPath.row] valueForKey:@"reply_to"] valueForKey:@"content"];
        NSString *replyAuthorString = [[_allJSONModel.comments[indexPath.row] valueForKey:@"reply_to"] valueForKey:@"author"];
        if (![replyAuthorString isKindOfClass:[NSString class]]) {
            cell.replyLabel.text = @"";
            cell.unfoldButton.hidden = YES;
        } else {
            cell.replyLabel.text = [NSString stringWithFormat:@"//%@:%@", replyAuthorString, replyContentString];
            cell.unfoldButton.hidden = NO;
        }
        
        double time = [[_allJSONModel.comments[indexPath.row] valueForKey:@"time"] doubleValue];
        NSDate * myDate=[NSDate dateWithTimeIntervalSince1970:time];
        //设置时间格式
        NSDateFormatter * formatter=[[NSDateFormatter alloc]init];
        [formatter setDateFormat:@"MM-dd HH:mm"];
        //将时间转换为字符串
        NSString *timeStr=[formatter stringFromDate:myDate];
        cell.timeLabel.text = timeStr;

        NSMutableString *urlString = [[NSMutableString alloc] initWithString:[_allJSONModel.comments[indexPath.row] valueForKey:@"avatar"]];
        [urlString insertString:@"s" atIndex:4];
        NSURL *url = [NSURL URLWithString:urlString];
        [cell.headImageView sd_setImageWithURL:url];
        
        return cell;
    } else {
        if (cell1 == nil) {
            cell1 = [_tableView dequeueReusableCellWithIdentifier:@"comments" forIndexPath:indexPath];
        }
        cell1.nameLabel.text = [_allShortJSONModel.comments[indexPath.row] valueForKey:@"author"];
        [cell1.zanButton setTitle:[NSString stringWithFormat:@"%@",[_allShortJSONModel.comments[indexPath.row] valueForKey:@"likes"]]  forState:UIControlStateNormal];
        cell1.pinglinTextLabel.text = [_allShortJSONModel.comments[indexPath.row] valueForKey:@"content"];
        
        NSString *replyContentString = [[_allShortJSONModel.comments[indexPath.row] valueForKey:@"reply_to"] valueForKey:@"content"];
        NSString *replyAuthorString = [[_allShortJSONModel.comments[indexPath.row] valueForKey:@"reply_to"] valueForKey:@"author"];
        
        if (![replyAuthorString isKindOfClass:[NSString class]]) {
            cell1.replyLabel.text = @"";
            cell1.unfoldButton.hidden = YES;
        } else {
            cell1.replyLabel.text = [NSString stringWithFormat:@"//%@:%@", replyAuthorString, replyContentString];
            cell1.unfoldButton.hidden = NO;
        }
        
        double time = [[_allShortJSONModel.comments[indexPath.row] valueForKey:@"time"] doubleValue];
        NSDate * myDate=[NSDate dateWithTimeIntervalSince1970:time];
        //设置时间格式
        NSDateFormatter * formatter=[[NSDateFormatter alloc]init];
        [formatter setDateFormat:@"MM-dd HH:mm"];
        //将时间转换为字符串
        NSString *timeStr=[formatter stringFromDate:myDate];
        cell1.timeLabel.text = timeStr;
        
        NSMutableString *urlString1 = [[NSMutableString alloc] initWithString:[_allShortJSONModel.comments[indexPath.row] valueForKey:@"avatar"]];
        [urlString1 insertString:@"s" atIndex:4];
        NSURL *url1 = [NSURL URLWithString:urlString1];
        [cell1.headImageView sd_setImageWithURL:url1];
        
        if (_flag == 1) {
            cell1.hidden = NO;
        } else {
            cell1.hidden = YES;
        }
       
        return cell1;
    }
    
}


@end
