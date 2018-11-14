//
//  ZDIDataUtils.m
//  iOS知乎日报
//
//  Created by 涂强尧 on 2018/11/14.
//  Copyright © 2018 涂强尧. All rights reserved.
//

#import "ZDIDataUtils.h"

@implementation ZDIDataUtils

+(NSString *)todayDateString {
    NSDate *today = [NSDate date];
    NSDateFormatter *formatter = [NSDateFormatter new];
    [formatter setDateFormat:@"yyyyMMdd"];
    
    return [formatter stringFromDate:today];
}

+(NSString *)dateStringBeforeDays:(NSInteger)days {
    NSDateFormatter *formatter = [NSDateFormatter new];
    [formatter setDateFormat:@"yyyyMMdd"];
    NSDate *before = [NSDate dateWithTimeIntervalSinceNow:-days*60*60*24];
    
    return [formatter stringFromDate:before];
}
@end
