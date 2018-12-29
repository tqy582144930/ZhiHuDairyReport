//
//  ZDIShareView.h
//  iOS知乎日报
//
//  Created by 涂强尧 on 2018/12/9.
//  Copyright © 2018 涂强尧. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ZDIShareView : UIView

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIImageView *weChatImageView;
@property (nonatomic, strong) UIImageView *weChatQuanImageViewl;
@property (nonatomic, strong) UIImageView *QQImageView;
@property (nonatomic, strong) UIImageView *weiBoImageView;
@property (nonatomic, strong) UIImageView *httpsImageView;
@property (nonatomic, strong) UIImageView *emailImageView;
@property (nonatomic, strong) UIImageView *youdaoyunImageView;
@property (nonatomic, strong) UIImageView *yinxiangImageView;
@property (nonatomic, strong) UIButton *collectButton;
@property (nonatomic, strong) UIButton *cancelButton;
@property (nonatomic, strong) UILabel *weChatLabel;
@property (nonatomic, strong) UILabel *weChatQuanLabel;
@property (nonatomic, strong) UILabel *QQLabel;
@property (nonatomic, strong) UILabel *weiBoLabel;
@property (nonatomic, strong) UILabel *httpsLabel;
@property (nonatomic, strong) UILabel *emailLabel;
@property (nonatomic, strong) UILabel *youdaoyunLabel;
@property (nonatomic, strong) UILabel *yinxiangLabel;

- (void) InitShareView;
@end

NS_ASSUME_NONNULL_END
