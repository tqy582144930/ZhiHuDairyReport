//
//  ZDINextView.h
//  iOS知乎日报
//
//  Created by 涂强尧 on 2018/11/18.
//  Copyright © 2018 涂强尧. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ZDINextView : UIView
@property (nonatomic, strong) UIButton *backButton;
@property (nonatomic, strong) UIButton *xiangxiaButton;
@property (nonatomic, strong) UIButton *dianzanButton;
@property (nonatomic, strong) UIButton *fenxiangButton;
@property (nonatomic, strong) UIButton *pinglunButton;

- (void) nextViewInit;
@end

NS_ASSUME_NONNULL_END
