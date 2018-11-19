//
//  ZDICommentsModel.m
//  iOS知乎日报
//
//  Created by 涂强尧 on 2018/11/19.
//  Copyright © 2018 涂强尧. All rights reserved.
//

#import "ZDICommentsModel.h"

@implementation ZDICommentsModel
+(BOOL)propertyIsOptional:(NSString *)propertyName{
    return  YES;
}
@end

@implementation ZDIReply_toModel
+(BOOL)propertyIsOptional:(NSString *)propertyName{
    return  YES;
}
@end
