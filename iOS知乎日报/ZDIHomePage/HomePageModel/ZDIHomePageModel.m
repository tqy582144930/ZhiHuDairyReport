//
//  ZDIHomePageModel.m
//  iOS知乎日报
//
//  Created by 涂强尧 on 2018/11/5.
//  Copyright © 2018 涂强尧. All rights reserved.
//

#import "ZDIHomePageModel.h"

@implementation ZDIHomePageModel

- (void)load {
    NSURL * url = [NSURL URLWithString:@"https://news-at.zhihu.com/api/4/news/latest"];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        dispatch_async(dispatch_get_main_queue(), ^{
            NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
            totallJSONModel *allJSONModel = [[totallJSONModel alloc] initWithDictionary:dic error:nil];
            //        NSLog(@"%@", allJSONModel);
            self->_storiesTitleMutableArray = [[NSMutableArray alloc] init];
            self->_storiseImagesMutableArray = [[NSMutableArray alloc] init];
            for (int i = 0; i < allJSONModel.stories.count; i++) {
                storiesJSONModel *stories = [[storiesJSONModel alloc] initWithDictionary:dic[@"stories"][i] error:nil];
                [self->_storiesTitleMutableArray addObject:stories.title];
                [self->_storiseImagesMutableArray addObject:stories.images];
            }
            self->_topStoriesTitleMutableArray = [[NSMutableArray alloc] init];
            self->_topStoriesImagesMutableArray = [[NSMutableArray alloc] init];
            for (int j = 0; j < allJSONModel.top_stories.count; j++) {
                topStoriseJSONModel *topStories = [[topStoriseJSONModel alloc] initWithDictionary:dic[@"top_stories"][j] error:nil];
                //                NSLog(@"%@",topStories);
                [self->_topStoriesImagesMutableArray addObject:topStories.image];
                [self->_topStoriesTitleMutableArray addObject:topStories.title];
            }
            
            [[NSNotificationCenter defaultCenter] postNotificationName:@"sendStoriesTitle" object:self->_storiesTitleMutableArray];
            [[NSNotificationCenter defaultCenter] postNotificationName:@"sendStoriesImages" object:self->_storiseImagesMutableArray];
            
            [[NSNotificationCenter defaultCenter] postNotificationName:@"sendTopStoriesTitle" object:self->_topStoriesTitleMutableArray];
            [[NSNotificationCenter defaultCenter] postNotificationName:@"sendTopStoriesImages" object:self->_topStoriesImagesMutableArray];
        });
    }];
    [dataTask resume];
    
}
@end

@implementation topStoriseJSONModel
@end

@implementation storiesJSONModel
@end

@implementation totallJSONModel
@end

