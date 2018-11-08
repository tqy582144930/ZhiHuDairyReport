//
//  ZDISideMenuView.m
//  iOS知乎日报
//
//  Created by 涂强尧 on 2018/11/5.
//  Copyright © 2018 涂强尧. All rights reserved.
//

#import "ZDISideMenuView.h"
#import <Masonry.h>

@implementation ZDISideMenuView

- (void)ZDISideMenuViewInit {
    _itemButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_itemButton setTitle:@"首页" forState:UIControlStateNormal];
    _itemButton.titleLabel.font = [UIFont systemFontOfSize:18];
    [_itemButton setImage:[UIImage imageNamed:@"home-page"] forState:UIControlStateNormal];
    [_itemButton setTitleEdgeInsets:UIEdgeInsetsMake(0 ,-80, 0.0,0.0)];
    [_itemButton setImageEdgeInsets:UIEdgeInsetsMake(10.0, 10.0, 10.0, 120)];
    _itemButton.tag = 1;
    [self addSubview:_itemButton];
    [_itemButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(130);
        make.left.mas_equalTo(0);
        make.size.mas_equalTo(CGSizeMake([UIScreen mainScreen].bounds.size.width/2, 50));
    }];
    
    _headPortraitImageView = [[UIImageView alloc] init];
    _headPortraitImageView.image = [UIImage imageNamed:@"headImage.jpg"];
    _headPortraitImageView.layer.masksToBounds=YES;
    _headPortraitImageView.layer.cornerRadius = 20;
    [self addSubview:_headPortraitImageView];
    [_headPortraitImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(30);
        make.left.mas_equalTo(15);
        make.size.mas_equalTo(CGSizeMake(40, 40));
    }];
    
    _nameLabel = [[UILabel alloc] init];
    _nameLabel.numberOfLines = 1;
    _nameLabel.text = @"祀梦";
    _nameLabel.font = [UIFont systemFontOfSize:15];
    _nameLabel.textColor = [UIColor whiteColor];
    [self addSubview:_nameLabel];
    [_nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(35);
        make.left.mas_equalTo(70);
        make.size.mas_equalTo(CGSizeMake(130, 30));
    }];
    
    _colletctButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_colletctButton setTitle:@"收藏" forState:UIControlStateNormal];
    _colletctButton.titleLabel.font = [UIFont systemFontOfSize:10];
    [_colletctButton setImage:[UIImage imageNamed:@"shoucang"] forState:UIControlStateNormal];
    [self initButton:_colletctButton];
    [self addSubview:_colletctButton];
    [_colletctButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(75);
        make.left.mas_equalTo(15);
        make.size.mas_equalTo(CGSizeMake(40, 40));
    }];
    
    _messageButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_messageButton setTitle:@"消息" forState:UIControlStateNormal];
    _messageButton.titleLabel.font = [UIFont systemFontOfSize:10];
    [_messageButton setImage:[UIImage imageNamed:@"message_icon"] forState:UIControlStateNormal];
    [self initButton:_messageButton];
    [self addSubview:_messageButton];
    [_messageButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(75);
        make.left.mas_equalTo(75);
        make.size.mas_equalTo(CGSizeMake(40, 40));
    }];
    
    _setUpButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_setUpButton setTitle:@"设置" forState:UIControlStateNormal];
    _setUpButton.titleLabel.font = [UIFont systemFontOfSize:10];
    [_setUpButton setImage:[UIImage imageNamed:@"shezhi"] forState:UIControlStateNormal];
    [self initButton:_setUpButton];
    [self addSubview:_setUpButton];
    [_setUpButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(75);
        make.left.mas_equalTo(140);
        make.size.mas_equalTo(CGSizeMake(40, 40));
    }];
    
}

-(void)initButton:(UIButton*)button{
    button.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;//使图片和文字水平居中显示
    [button setTitleEdgeInsets:UIEdgeInsetsMake(50 ,-30, 0.0,0.0)];//文字距离上边框的距离增加imageView的高度，距离左边框减少imageView的宽度，距离下边框和右边框距离不变
    [button setImageEdgeInsets:UIEdgeInsetsMake(0.0, 0.0,0.0, -15)];//图片距离右边框距离减少图片的宽度，其它不边
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
