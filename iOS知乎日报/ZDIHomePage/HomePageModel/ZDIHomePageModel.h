//
//  ZDIHomePageModel.h
//  iOS知乎日报
//
//  Created by 涂强尧 on 2018/11/5.
//  Copyright © 2018 涂强尧. All rights reserved.
//

#import "JSONModel.h"

@interface ZDIHomePageModel : JSONModel
@property (nonatomic, strong) NSMutableArray *storiesTitleMutableArray;
@property (nonatomic, strong) NSMutableArray *storiseImagesMutableArray;
@property (nonatomic, strong) NSMutableArray *topStoriesTitleMutableArray;
@property (nonatomic, strong) NSMutableArray *topStoriesImagesMutableArray;
- (void) load;
@end

@interface topStoriseJSONModel : JSONModel
@property (nonatomic, strong) NSString *image;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *id;
@end

@interface storiesJSONModel : JSONModel
@property (nonatomic, strong) NSArray *images;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *id;
@end

@interface totallJSONModel : JSONModel
@property (nonatomic, strong) NSString *date;
@property (nonatomic, strong) NSArray <topStoriseJSONModel *> *top_stories;
@property (nonatomic, strong) NSArray <storiesJSONModel *> *stories;
@end
