//
//  ZDINextView.m
//  iOS知乎日报
//
//  Created by 涂强尧 on 2018/11/24.
//  Copyright © 2018 涂强尧. All rights reserved.
//

#import "ZDINextView.h"
#import <Masonry.h>

@implementation ZDINextView

- (void) nextViewInit{
    
    _backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_backButton setImage:[UIImage imageNamed:@"2fanhui"] forState:UIControlStateNormal];
    [self addSubview:_backButton];
    [_backButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(0);
        make.left.mas_equalTo(0);
        make.size.mas_equalTo(CGSizeMake([UIScreen mainScreen].bounds.size.width/5, 50));
    }];
    
    _xiangxiaButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_xiangxiaButton setImage:[UIImage imageNamed:@"xiangxia"] forState:UIControlStateNormal];
    [self addSubview:_xiangxiaButton];
    [_xiangxiaButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(0);
        make.left.mas_equalTo([UIScreen mainScreen].bounds.size.width/5);
        make.size.mas_equalTo(CGSizeMake([UIScreen mainScreen].bounds.size.width/5, 50));
    }];
    
    _dianzanButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_dianzanButton setImage:[UIImage imageNamed:@"zan"] forState:UIControlStateNormal];
    [self addSubview:_dianzanButton];
    [_dianzanButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(0);
        make.left.mas_equalTo([UIScreen mainScreen].bounds.size.width/5*2);
        make.size.mas_equalTo(CGSizeMake([UIScreen mainScreen].bounds.size.width/5, 50));
    }];
    
    _fenxiangButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_fenxiangButton setImage:[UIImage imageNamed:@"fenxiang"] forState:UIControlStateNormal];
    [self addSubview:_fenxiangButton];
    [_fenxiangButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(0);
        make.left.mas_equalTo([UIScreen mainScreen].bounds.size.width/5*3);
        make.size.mas_equalTo(CGSizeMake([UIScreen mainScreen].bounds.size.width/5, 50));
    }];
    
    _pinglunButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_pinglunButton setImage:[UIImage imageNamed:@"pinglun"] forState:UIControlStateNormal];
    [self addSubview:_pinglunButton];
    [_pinglunButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(0);
        make.left.mas_equalTo([UIScreen mainScreen].bounds.size.width/5*4);
        make.size.mas_equalTo(CGSizeMake([UIScreen mainScreen].bounds.size.width/5, 50));
    }];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
