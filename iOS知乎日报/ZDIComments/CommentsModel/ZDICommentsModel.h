//
//  ZDICommentsModel.h
//  iOS知乎日报
//
//  Created by 涂强尧 on 2018/11/19.
//  Copyright © 2018 涂强尧. All rights reserved.
//

#import "JSONModel.h"

NS_ASSUME_NONNULL_BEGIN
@protocol ZDIReply_toModel

@end

@interface ZDIReply_toModel : JSONModel
@property (nonatomic, strong) NSString *author;
@property (nonatomic, strong) NSString *content;
@property (nonatomic, strong) NSString *status;
@property (nonatomic, strong) NSString *id;
@end

@interface ZDICommentsModel : JSONModel
@property (nonatomic, strong) NSString *author;
@property (nonatomic, strong) NSString *content;
@property (nonatomic, strong) NSString *avatar;
@property (nonatomic, strong) NSString *time;
@property (nonatomic, strong) NSString *id;
@property (nonatomic, strong) NSString *likes;
@property (nonatomic, strong) NSArray <ZDIReply_toModel> *reply_to;
@end

NS_ASSUME_NONNULL_END
