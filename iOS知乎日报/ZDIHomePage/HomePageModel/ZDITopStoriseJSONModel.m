//
//  ZDITopStoriseJSONModel.m
//  iOS知乎日报
//
//  Created by 涂强尧 on 2018/11/11.
//  Copyright © 2018 涂强尧. All rights reserved.
//

#import "ZDITopStoriseJSONModel.h"

@implementation ZDIStoriesJSONModel
+(BOOL)propertyIsOptional:(NSString *)propertyName{
    return  YES;
}

@end

@implementation ZDITopStoriseJSONModel
+ (BOOL)propertyIsOptional:(NSString *)propertyName {
    return YES;
}
+ (JSONKeyMapper *)keyMapper {
    return [[JSONKeyMapper alloc] initWithModelToJSONDictionary:@{ @"ID":@"id",
                                                                   @"imageStr":@"image"}];
}
@end

@implementation ZDITotallJSONModel
+(BOOL)propertyIsOptional:(NSString *)propertyName{
    return  YES;
}
@end
