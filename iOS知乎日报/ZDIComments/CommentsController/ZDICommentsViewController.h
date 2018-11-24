//
//  ZDICommentsViewController.h
//  iOS知乎日报
//
//  Created by 涂强尧 on 2018/11/19.
//  Copyright © 2018 涂强尧. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZDICommentsView.h"

NS_ASSUME_NONNULL_BEGIN

@interface ZDICommentsViewController : UIViewController
@property (nonatomic, strong) ZDICommentsView *commentsView;
@property (nonatomic, strong) NSString *idNumber;
@property (nonatomic, strong) NSMutableArray *cellHeightMutableArray;
@property (nonatomic, strong) NSMutableArray *cell1HeightMutableArray;
@property (nonatomic, strong) NSMutableArray *allCellHeightMutableArray;
@property (nonatomic, strong) NSString *count;
@end

NS_ASSUME_NONNULL_END
