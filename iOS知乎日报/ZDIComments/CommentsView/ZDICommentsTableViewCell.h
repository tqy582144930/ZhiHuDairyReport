//
//  ZDICommentsTableViewCell.h
//  iOS知乎日报
//
//  Created by 涂强尧 on 2018/11/19.
//  Copyright © 2018 涂强尧. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ZDICommentsTableViewCell : UITableViewCell
@property (nonatomic, strong) UIImageView *headImageView;
@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UIButton *zanButton;
@property (nonatomic, strong) UITextView *pinglinTextView;
@property (nonatomic, strong) UILabel *timeLabel;
@end

NS_ASSUME_NONNULL_END
