//
//  ZDICommentsView.h
//  iOS知乎日报
//
//  Created by 涂强尧 on 2018/11/19.
//  Copyright © 2018 涂强尧. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ZDICommentsView : UIView <UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UIView *bottonView;
@property (nonatomic, strong) UIButton *backButton;
@property (nonatomic, strong) UIButton *readButton;

- (void) commentsViewInit;

@end

NS_ASSUME_NONNULL_END
