//
//  ZDIHomePageManager.m
//  iOS知乎日报
//
//  Created by 涂强尧 on 2018/11/8.
//  Copyright © 2018 涂强尧. All rights reserved.
//

#import "ZDIHomePageManager.h"
#import "ZDIDataUtils.h"

@implementation ZDIHomePageManager

static ZDIHomePageManager *manager = nil;

+ (id)sharedManager {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[self alloc] init];
    });
    return manager;
}

- (void)fetchHomePageDataDay:(NSInteger)day Succeed:(ZDIHomePageData)succeedBlock error:(ErrorHandle)errorBlock  {
    NSURL * url = [NSURL URLWithString:@"https://news-at.zhihu.com/api/4/news/latest"];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
            if (!error) {
                ZDITotallJSONModel *allJSONModel = [[ZDITotallJSONModel alloc] initWithDictionary:dic error:nil];
                succeedBlock(allJSONModel);
            } else {
                errorBlock(error);
            }
        });
    }];
    [dataTask resume];
}

- (void)fetchDatBeforeHomePageDataDay:(NSInteger)day Succeed:(ZDIHomePageData)succeedBlock error:(ErrorHandle)errorBlock {
    NSString *urlString = nil;
    urlString = [@"https://news-at.zhihu.com/api/4/news/before/"
               stringByAppendingString:[ZDIDataUtils dateStringBeforeDays:day]];
    NSURL * url = [NSURL URLWithString:urlString];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            if (error == nil) {
                NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
                ZDITotallJSONModel *allJSONModel = [[ZDITotallJSONModel alloc] initWithDictionary:dic error:nil];
                succeedBlock(allJSONModel);
            } else {
                errorBlock(error);
            }
        });
    }];
    [dataTask resume];
}
@end
