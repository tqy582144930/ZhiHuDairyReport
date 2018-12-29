//
//  ZDICollectView.h
//  iOS知乎日报
//
//  Created by 涂强尧 on 2018/12/11.
//  Copyright © 2018 涂强尧. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZDIHomePageTableViewCell.h"

NS_ASSUME_NONNULL_BEGIN

@interface ZDICollectView : UIView<UITableViewDataSource>

@property (nonatomic, strong) UITableView *collectTableView;
@property (nonatomic, strong) NSMutableArray *collectMutableArray;

- (void) collectViewInit;

@end

NS_ASSUME_NONNULL_END
