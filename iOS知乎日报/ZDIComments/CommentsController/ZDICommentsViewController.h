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
@end

NS_ASSUME_NONNULL_END
