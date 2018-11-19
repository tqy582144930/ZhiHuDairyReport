//
//  ZDICommentsManager.h
//  iOS知乎日报
//
//  Created by 涂强尧 on 2018/11/19.
//  Copyright © 2018 涂强尧. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZDICommentsModel.h"

NS_ASSUME_NONNULL_BEGIN

//返回当天数据
typedef void(^ZDICommentsData)(NSMutableArray *homaPageModel);

// 请求失败统一回调block
typedef void(^ErrorHandle)(NSError *error);

@interface ZDICommentsManager : NSObject

+ (instancetype)sharedManager;

- (void)fetchCommentsDataId:(NSString *)idNumber Succeed:(ZDICommentsData)succeedBlock error:(ErrorHandle)errorBlock;

@end

NS_ASSUME_NONNULL_END
