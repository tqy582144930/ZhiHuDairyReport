//
//  ZDICommentsManager.m
//  iOS知乎日报
//
//  Created by 涂强尧 on 2018/11/19.
//  Copyright © 2018 涂强尧. All rights reserved.
//

#import "ZDICommentsManager.h"

@implementation ZDICommentsManager

static ZDICommentsManager *manager;

+ (instancetype) sharedManager {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[self alloc] init];
    });
    return manager;
}

- (void) fetchCommentsDataId:(NSString *)idNumber Succeed:(ZDICommentsData)succeedBlock error:(ErrorHandle)errorBlock {
    NSString *urlSting = [NSString stringWithFormat:@"https://news-at.zhihu.com/api/4/story/%@/long-comments", idNumber];
    NSURL * url = [NSURL URLWithString:urlSting];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
//            NSLog(@"%@", dic);
            if (error == nil) {
                ZDICommentsModel *allJSONModel = [[ZDICommentsModel alloc] initWithDictionary:dic error:nil];
//                NSLog(@"%@", allJSONModel);
                succeedBlock(allJSONModel);
            } else {
                errorBlock(error);
            }
        });
    }];
    [dataTask resume];
}

- (void) fetchShortCommentsDataId:(NSString *)idNumber Succeed:(ZDICommentsData)succeedBlock error:(ErrorHandle)errorBlock {
    NSString *urlSting = [NSString stringWithFormat:@"https://news-at.zhihu.com/api/4/story/%@/short-comments", idNumber];
    NSURL * url = [NSURL URLWithString:urlSting];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
            //            NSLog(@"%@", dic);
            if (error == nil) {
                ZDICommentsModel *allJSONModel = [[ZDICommentsModel alloc] initWithDictionary:dic error:nil];
                //                NSLog(@"%@", allJSONModel);
                succeedBlock(allJSONModel);
            } else {
                errorBlock(error);
            }
        });
    }];
    [dataTask resume];
}
@end
