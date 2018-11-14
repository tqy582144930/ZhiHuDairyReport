//
//  ZDITopStoriseJSONModel.h
//  iOS知乎日报
//
//  Created by 涂强尧 on 2018/11/11.
//  Copyright © 2018 涂强尧. All rights reserved.
//

#import "JSONModel.h"


NS_ASSUME_NONNULL_BEGIN

@protocol ZDITopStoriseJSONModel

@end

@protocol ZDIStoriesJSONModel

@end

@interface ZDITopStoriseJSONModel : JSONModel
@property (nonatomic, strong) NSString *imageStr;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *id;
@end

@interface ZDIStoriesJSONModel : JSONModel
@property (nonatomic, strong) NSArray *images;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *id;
@end

@interface ZDITotallJSONModel : JSONModel
@property (nonatomic, strong) NSString *date;
@property (nonatomic, strong) NSArray <ZDITopStoriseJSONModel> *top_stories;
@property (nonatomic, strong) NSArray <ZDIStoriesJSONModel> *stories;
@end

NS_ASSUME_NONNULL_END
