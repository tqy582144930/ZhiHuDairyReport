//
//  ZDINextManger.m
//  iOS知乎日报
//
//  Created by 涂强尧 on 2018/11/18.
//  Copyright © 2018 涂强尧. All rights reserved.
//

#import "ZDINextManger.h"

@implementation ZDINextManger

static ZDINextManger *manager = nil;

+ (id)sharedManager {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[self alloc] init];
    });
    return manager;
}

- (void)fetchNextDataId:(NSString *)idNumber Succeed:(ZDINextData)succeedBlock error:(ErrorHandle)errorBlock {
    NSString *urlSting = [NSString stringWithFormat:@"https://news-at.zhihu.com/api/4/news/%@", idNumber];
    NSURL * url = [NSURL URLWithString:urlSting];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
            NSMutableArray *data = [[NSMutableArray alloc] init];
            [data addObject:dic];
            if (error == nil) {
                succeedBlock(data);
            } else {
                errorBlock(error);
            }
        });
    }];
    [dataTask resume];
}

@end
