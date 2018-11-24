//
//  ZDICommentsView.h
//  iOS知乎日报
//
//  Created by 涂强尧 on 2018/11/19.
//  Copyright © 2018 涂强尧. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZDICommentsModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface ZDICommentsView : UIView <UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UIView *bottonView;
@property (nonatomic, strong) UIButton *backButton;
@property (nonatomic, strong) UIButton *readButton;
@property (nonatomic, strong) ZDICommentsModel *allJSONModel;
@property (nonatomic, strong) ZDICommentsModel *allShortJSONModel;

- (void) commentsViewInit;
- (NSString *)getTimeFromTimestamp:(double) time;

@end

NS_ASSUME_NONNULL_END
