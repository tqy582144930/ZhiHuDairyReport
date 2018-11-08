//
//  ZDIHomePageManager.h
//  iOS知乎日报
//
//  Created by 涂强尧 on 2018/11/8.
//  Copyright © 2018 涂强尧. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZDIHomePageModel.h"

//返回当天数据
typedef void(^ZDIHomePageData)(NSMutableArray *homaPageModel);

// 请求失败统一回调block
typedef void(^ErrorHandle)(NSError *error);

@interface ZDIHomePageManager : NSObject

+ (instancetype)sharedManager;

- (void)fetchHomePageDataSucceed:(ZDIHomePageData)succeedBlock error:(ErrorHandle)errorBlock;

@end
