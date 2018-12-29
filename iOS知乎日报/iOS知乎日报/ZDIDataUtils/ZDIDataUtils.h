//
//  ZDIDataUtils.h
//  iOS知乎日报
//
//  Created by 涂强尧 on 2018/11/14.
//  Copyright © 2018 涂强尧. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ZDIDataUtils : NSObject

+(NSString *)todayDateString;
+(NSString *)dateStringBeforeDays:(NSInteger)days;

@end

NS_ASSUME_NONNULL_END
