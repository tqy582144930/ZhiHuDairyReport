//
//  ZDIShareView.m
//  iOS知乎日报
//
//  Created by 涂强尧 on 2018/12/9.
//  Copyright © 2018 涂强尧. All rights reserved.
//

#import "ZDIShareView.h"
#import <Masonry.h>


@implementation ZDIShareView

- (void) InitShareView {
    self.backgroundColor = [UIColor colorWithRed:0.91f green:0.91f blue:0.92f alpha:1.00f];
    _titleLabel = [[UILabel alloc] init];
    _titleLabel.text = @"分享这篇内容";
    _titleLabel.textAlignment = NSTextAlignmentCenter;
    _titleLabel.textColor = [UIColor blackColor];
    [self addSubview:_titleLabel];
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(10);
        make.centerX.mas_equalTo(self);
        make.size.mas_equalTo(CGSizeMake(200, 20));
    }];

    _weChatImageView = [[UIImageView alloc] init];
    _weChatImageView.image = [UIImage imageNamed:@"weixin"];
    _weChatImageView.layer.masksToBounds=YES;
    _weChatImageView.layer.cornerRadius = 30;
    [self addSubview:_weChatImageView];
    [_weChatImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(45);
        make.left.mas_equalTo(25);
        make.size.mas_equalTo(CGSizeMake(60, 60));
    }];

    _weChatLabel = [[UILabel alloc] init];
    _weChatLabel.text = @"微信好友";
    _weChatLabel.textAlignment = NSTextAlignmentCenter;
    _weChatLabel.font = [UIFont systemFontOfSize:12];
    _weChatLabel.textColor = [UIColor grayColor];
    [self addSubview:_weChatLabel];
    [_weChatLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self->_weChatImageView.mas_bottom).mas_equalTo(5);
        make.left.mas_equalTo(25);
        make.size.mas_equalTo(CGSizeMake(60, 20));
    }];
    
    _httpsImageView = [[UIImageView alloc] init];
    _httpsImageView.image = [UIImage imageNamed:@"lianjie"];
    _httpsImageView.layer.masksToBounds=YES;
    _httpsImageView.layer.cornerRadius = 30;
    [self addSubview:_httpsImageView];
    [_httpsImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self->_weChatLabel.mas_bottom).mas_equalTo(20);
        make.left.mas_equalTo(25);
        make.size.mas_equalTo(CGSizeMake(60, 60));
    }];

    _httpsLabel = [[UILabel alloc] init];
    _httpsLabel.text = @"复制链接";
    _httpsLabel.textAlignment = NSTextAlignmentCenter;
    _httpsLabel.font = [UIFont systemFontOfSize:12];
    _httpsLabel.textColor = [UIColor grayColor];
    [self addSubview:_httpsLabel];
    [_httpsLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self->_httpsImageView.mas_bottom).mas_equalTo(5);
        make.left.mas_equalTo(25);
        make.size.mas_equalTo(CGSizeMake(60, 20));
    }];

    _weChatQuanImageViewl = [[UIImageView alloc] init];
    _weChatQuanImageViewl.image = [UIImage imageNamed:@"pengyouquan"];
    _weChatQuanImageViewl.layer.masksToBounds=YES;
    _weChatQuanImageViewl.layer.cornerRadius = 30;
    [self addSubview:_weChatQuanImageViewl];
    [_weChatQuanImageViewl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(45);
        make.left.mas_equalTo(self->_weChatImageView.mas_right).mas_equalTo(40);
        make.size.mas_equalTo(CGSizeMake(60, 60));
    }];

    _weChatQuanLabel = [[UILabel alloc] init];
    _weChatQuanLabel.text = @"微信朋友圈";
    _weChatQuanLabel.textAlignment = NSTextAlignmentCenter;
    _weChatQuanLabel.font = [UIFont systemFontOfSize:12];
    _weChatQuanLabel.textColor = [UIColor grayColor];
    [self addSubview:_weChatQuanLabel];
    [_weChatQuanLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self->_weChatImageView.mas_bottom).mas_equalTo(5);
        make.left.mas_equalTo(self->_weChatLabel.mas_right).mas_equalTo(35);
        make.size.mas_equalTo(CGSizeMake(70, 20));
    }];

    _emailImageView = [[UIImageView alloc] init];
    _emailImageView.image = [UIImage imageNamed:@"youjian"];
    _emailImageView.layer.masksToBounds=YES;
    _emailImageView.layer.cornerRadius = 30;
    [self addSubview:_emailImageView];
    [_emailImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self->_weChatQuanLabel.mas_bottom).mas_equalTo(20);
        make.left.mas_equalTo(self->_httpsImageView.mas_right).mas_equalTo(40);
        make.size.mas_equalTo(CGSizeMake(60, 60));
    }];

    _emailLabel = [[UILabel alloc] init];
    _emailLabel.text = @"电子邮件";
    _emailLabel.textAlignment = NSTextAlignmentCenter;
    _emailLabel.font = [UIFont systemFontOfSize:12];
    _emailLabel.textColor = [UIColor grayColor];
    [self addSubview:_emailLabel];
    [_emailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self->_emailImageView.mas_bottom).mas_equalTo(5);
        make.left.mas_equalTo(self->_httpsLabel.mas_right).mas_equalTo(40);
        make.size.mas_equalTo(CGSizeMake(60, 20));
    }];


    _QQImageView = [[UIImageView alloc] init];
    _QQImageView.image = [UIImage imageNamed:@"qq"];
    _QQImageView.layer.masksToBounds=YES;
    _QQImageView.layer.cornerRadius = 30;
    [self addSubview:_QQImageView];
    [_QQImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(45);
        make.left.mas_equalTo(self->_weChatQuanImageViewl.mas_right).mas_equalTo(40);
        make.size.mas_equalTo(CGSizeMake(60, 60));
    }];

    _QQLabel = [[UILabel alloc] init];
    _QQLabel.text = @"QQ";
    _QQLabel.textAlignment = NSTextAlignmentCenter;
    _QQLabel.font = [UIFont systemFontOfSize:12];
    _QQLabel.textColor = [UIColor grayColor];
    [self addSubview:_QQLabel];
    [_QQLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self->_QQImageView.mas_bottom).mas_equalTo(5);
        make.left.mas_equalTo(self->_weChatQuanLabel.mas_right).mas_equalTo(35);
        make.size.mas_equalTo(CGSizeMake(60, 20));
    }];

    _youdaoyunImageView = [[UIImageView alloc] init];
    _youdaoyunImageView.image = [UIImage imageNamed:@"youdaoyunbiji"];
    _youdaoyunImageView.layer.masksToBounds=YES;
    _youdaoyunImageView.layer.cornerRadius = 30;
    [self addSubview:_youdaoyunImageView];
    [_youdaoyunImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self->_QQLabel.mas_bottom).mas_equalTo(20);
        make.left.mas_equalTo(self->_emailImageView.mas_right).mas_equalTo(40);
        make.size.mas_equalTo(CGSizeMake(60, 60));
    }];

    _youdaoyunLabel = [[UILabel alloc] init];
    _youdaoyunLabel.text = @"有道云笔记";
    _youdaoyunLabel.textAlignment = NSTextAlignmentCenter;
    _youdaoyunLabel.font = [UIFont systemFontOfSize:12];
    _youdaoyunLabel.textColor = [UIColor grayColor];
    [self addSubview:_youdaoyunLabel];
    [_youdaoyunLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self->_youdaoyunImageView.mas_bottom).mas_equalTo(5);
        make.left.mas_equalTo(self->_emailLabel.mas_right).mas_equalTo(35);
        make.size.mas_equalTo(CGSizeMake(70, 20));
    }];

    _weiBoImageView = [[UIImageView alloc] init];
    _weiBoImageView.image = [UIImage imageNamed:@"weibo"];
    _weiBoImageView.layer.masksToBounds=YES;
    _weiBoImageView.layer.cornerRadius = 30;
    [self addSubview:_weiBoImageView];
    [_weiBoImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(45);
        make.left.mas_equalTo(self->_QQImageView.mas_right).mas_equalTo(40);
        make.size.mas_equalTo(CGSizeMake(60, 60));
    }];

    _weiBoLabel = [[UILabel alloc] init];
    _weiBoLabel.text = @"新浪微博";
    _weiBoLabel.textAlignment = NSTextAlignmentCenter;
    _weiBoLabel.font = [UIFont systemFontOfSize:12];
    _weiBoLabel.textColor = [UIColor grayColor];
    [self addSubview:_weiBoLabel];
    [_weiBoLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self->_weiBoImageView.mas_bottom).mas_equalTo(5);
        make.left.mas_equalTo(self->_QQLabel.mas_right).mas_equalTo(40);
        make.size.mas_equalTo(CGSizeMake(60, 20));
    }];

    _yinxiangImageView = [[UIImageView alloc] init];
    _yinxiangImageView.image = [UIImage imageNamed:@"fenxiang_yinxiangbiji"];
    _yinxiangImageView.layer.masksToBounds=YES;
    _yinxiangImageView.layer.cornerRadius = 30;
    [self addSubview:_yinxiangImageView];
    [_yinxiangImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self->_weiBoLabel.mas_bottom).mas_equalTo(20);
        make.left.mas_equalTo(self->_youdaoyunImageView.mas_right).mas_equalTo(40);
        make.size.mas_equalTo(CGSizeMake(60, 60));
    }];

    _yinxiangLabel = [[UILabel alloc] init];
    _yinxiangLabel.text = @"印象笔记";
    _yinxiangLabel.textAlignment = NSTextAlignmentCenter;
    _yinxiangLabel.font = [UIFont systemFontOfSize:12];
    _yinxiangLabel.textColor = [UIColor grayColor];
    [self addSubview:_yinxiangLabel];
    [_yinxiangLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self->_yinxiangImageView.mas_bottom).mas_equalTo(5);
        make.left.mas_equalTo(self->_youdaoyunLabel.mas_right).mas_equalTo(35);
        make.size.mas_equalTo(CGSizeMake(60, 20));
    }];

    _collectButton = [[UIButton alloc] init];
    [_collectButton setTitle:@"收藏" forState:UIControlStateNormal];
    [_collectButton setTitle:@"取消收藏" forState:UIControlStateSelected];
    [_collectButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [_collectButton setBackgroundColor:[UIColor whiteColor]];
    _collectButton.titleLabel.font = [UIFont systemFontOfSize: 14.0];
    [self addSubview:_collectButton];
    [_collectButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self->_youdaoyunLabel.mas_bottom).mas_equalTo(20);
        make.left.mas_equalTo(25);
        make.right.mas_equalTo(-25);
        make.height.mas_equalTo(40);
    }];
    
    _cancelButton = [[UIButton alloc] init];
    [_cancelButton setTitle:@"取消" forState:UIControlStateNormal];
    [_cancelButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [_cancelButton setBackgroundColor:[UIColor whiteColor]];
    _cancelButton.titleLabel.font = [UIFont systemFontOfSize: 14.0];
    [_cancelButton addTarget:self action:@selector(backToNext:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_cancelButton];
    [_cancelButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self->_collectButton.mas_bottom).mas_equalTo(15);
        make.left.mas_equalTo(25);
        make.right.mas_equalTo(-25);
        make.height.mas_equalTo(40);
    }];
}

- (void)backToNext:(UIButton *)button {
    
}



/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
