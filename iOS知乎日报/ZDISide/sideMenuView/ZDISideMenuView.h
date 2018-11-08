//
//  ZDISideMenuView.h
//  iOS知乎日报
//
//  Created by 涂强尧 on 2018/11/5.
//  Copyright © 2018 涂强尧. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZDISideMenuView : UIView
@property (nonatomic, strong) UIButton *itemButton;
@property (nonatomic, strong) UIButton *colletctButton;
@property (nonatomic, strong) UIButton *messageButton;
@property (nonatomic, strong) UIButton *setUpButton;
@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UIImageView *headPortraitImageView;

- (void )ZDISideMenuViewInit;
@end
