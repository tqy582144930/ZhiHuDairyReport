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

@implementation ZDICommentsView

- (void)commentsViewInit {
    _tableView = [[UITableView alloc] init];
    _tableView.dataSource = self;
    [self addSubview:_tableView];
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(0);
        make.left.mas_equalTo(0);
        make.size.mas_equalTo(CGSizeMake([UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height - 50));
    }];
    [_tableView registerClass:[ZDICommentsTableViewCell class] forCellReuseIdentifier:@"comments"];
    
    _bottonView = [[UIView alloc] init];
    _bottonView.backgroundColor = [UIColor colorWithRed:0.24f green:0.24f blue:0.24f alpha:1.00f];
    [self addSubview:_bottonView];
    [_bottonView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(0);
        make.left.mas_equalTo(0);
        make.size.mas_equalTo(CGSizeMake([UIScreen mainScreen].bounds.size.width, 50));
    }];
                              
    _backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_backButton setImage:[UIImage imageNamed:@"2fanhui"] forState:UIControlStateNormal];
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
    return 3;
}

- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView {
    return 4;
}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ZDICommentsTableViewCell *cell = nil;
    if (cell == nil) {
        cell = [_tableView dequeueReusableCellWithIdentifier:@"comments" forIndexPath:indexPath];
    }
    return cell;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
