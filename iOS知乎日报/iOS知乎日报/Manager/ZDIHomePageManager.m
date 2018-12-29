//
//  ZDIHomePageManager.m
//  iOS知乎日报
//
//  Created by 涂强尧 on 2018/11/8.
//  Copyright © 2018 涂强尧. All rights reserved.
//

#import "ZDIHomePageManager.h"
#import "ZDIDataUtils.h"
#import <FMDB.h>

@implementation ZDIHomePageManager

static ZDIHomePageManager *manager = nil;

+ (id)sharedManager {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[self alloc] init];
    });
    return manager;
}

- (void) FMDatabaseTopCreate {
    NSString *document = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    _fileNameString = [document stringByAppendingPathComponent:@"zhihuDatabase.sqlite"];
    FMDatabase *db = [FMDatabase databaseWithPath:_fileNameString];
    if ([db open]) {
        BOOL result = [db executeUpdate:@"CREATE TABLE IF NOT EXISTS 't_zhihuTopDatabase' ('topTitle' text, 'topPicture' text)"];
        if (result) {
            NSLog(@"创建数据库成功");
        } else {
            NSLog(@"创建数据库失败");
        }
        [db close];
    } else {
        NSLog(@"打开数据库失败");
    }
}

- (void)insertDataAndTopTitleArray:(NSMutableArray *) topTitleMutableArray AndTopPictureMutableArray:(NSMutableArray *) topPictureMutableArray{
    FMDatabase *db = [FMDatabase databaseWithPath:_fileNameString];
    if ([db open]) {
        for (int j = 0; j < [topTitleMutableArray[0] count]; j++) {
            BOOL result = [db executeUpdate:@"insert into t_zhihuTopDatabase (topTitle, topPicture) values(?, ?);", topTitleMutableArray[0][j], topPictureMutableArray[j]];
            if (result) {
                NSLog(@"添加数据成功");
            } else {
                NSLog(@"添加数据失败");
            }
        }
        [db close];
    } else {
        NSLog(@"打开数据库失败");
    }
}

- (void)selectTopData{
    FMDatabase *db = [FMDatabase databaseWithPath:_fileNameString];
    if ([db open]) {
        NSString * sql = @"select * from t_zhihuTopDatabase";
        FMResultSet * rs = [db executeQuery:sql];
        NSMutableArray *topTitleMutableArray = [NSMutableArray new];
        NSMutableArray *topPictureMutableArray = [NSMutableArray new];
        while ([rs next]) {
            NSString * topTitleString = [rs stringForColumn:@"topTitle"];
            NSData * topPictureData = [rs dataForColumn:@"topPicture"];
            [topTitleMutableArray addObject:topTitleString];
            [topPictureMutableArray addObject:topPictureData];
//            NSLog(@"topTitle = %@, topPicture = %@", topTitleString, topPictureData);
        }
        [db close];
        
        if ([_delegete respondsToSelector:@selector(selectDataInZDIHomePageView:AndTopPictures:)]) {
            [_delegete selectDataInZDIHomePageView:topTitleMutableArray AndTopPictures:topPictureMutableArray];
        } else {

        }
    } else {
        NSLog(@"打开数据库失败");
    }
}

- (void)deleteTopData{
    FMDatabase *db = [FMDatabase databaseWithPath:_fileNameString];
    if ([db open]) {
        BOOL result = [db executeUpdate:@"delete from t_zhihuTopDatabase"];
        if (result) {
            NSLog(@"删除数据成功");
        } else {
            NSLog(@"删除数据失败");
        }
        [db close];
    } else {
        NSLog(@"打开数据库失败");
    }
}

- (void)FMDatabaseCreate {
    NSString *document = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    _fileNameString = [document stringByAppendingPathComponent:@"zhihuDatabase.sqlite"];
    FMDatabase *db = [FMDatabase databaseWithPath:_fileNameString];
    if ([db open]) {
        BOOL result = [db executeUpdate:@"CREATE TABLE IF NOT EXISTS 't_zhihuDatabase' ('title' text , 'picture' text);"];
        if (result) {
            NSLog(@"创建数据库成功");
        } else {
            NSLog(@"创建数据库失败");
        }
        [db close];
    } else {
        NSLog(@"打开数据库失败");
    }

}

- (void)insertDataAndTitleMutabeArray:(NSMutableArray *) titleMutableArray AndPictureMutableArray:(NSMutableArray *) pictureMutableArray {
    FMDatabase *db = [FMDatabase databaseWithPath:_fileNameString];
    if ([db open]) {
        for (int i = 0 ; i < [titleMutableArray[0] count]; i++) {
            BOOL result = [db executeUpdate:@"insert into t_zhihuDatabase (title, picture) values(?, ?)", titleMutableArray[0][i], pictureMutableArray[i]];
            if (result) {
                NSLog(@"添加数据成功");
            } else {
                NSLog(@"添加数据失败");
            }
        }
        [db close];
    } else {
        NSLog(@"打开数据库失败");
    }
}

- (void)selectData {
    FMDatabase *db = [FMDatabase databaseWithPath:_fileNameString];
    if ([db open]) {
        NSString * sql = @"select * from t_zhihuDatabase";
        FMResultSet * rs = [db executeQuery:sql];
        NSMutableArray *titleMutableArray = [NSMutableArray new];
        NSMutableArray *pictureMutableArray = [NSMutableArray new];
        while ([rs next]) {
            NSString * titleString = [rs stringForColumn:@"title"];
            NSString * pictureString = [rs stringForColumn:@"picture"];
            [titleMutableArray addObject:titleString];
            [pictureMutableArray addObject:pictureString];
//            NSLog(@"title = %@, picture = %@", titleString, pictureString);
        }
        [db close];
        
        if ([_delegete respondsToSelector:@selector(selectDataInZDIHomePageView: AndPictures:)]) {
            [_delegete selectDataInZDIHomePageView:titleMutableArray AndPictures:pictureMutableArray];
        } else {
            
        }
    } else {
        NSLog(@"打开数据库失败");
    }
}

- (void)deleteData {
    FMDatabase *db = [FMDatabase databaseWithPath:_fileNameString];
    if ([db open]) {
        BOOL result = [db executeUpdate:@"delete from t_zhihuDatabase"];
        if (result) {
            NSLog(@"删除数据成功");
        } else {
            NSLog(@"删除数据失败");
        }
        [db close];
    } else {
        NSLog(@"打开数据库失败");
    }
}

- (void)fetchHomePageDataDay:(NSInteger)day Succeed:(ZDIHomePageData)succeedBlock error:(ErrorHandle)errorBlock  {
    NSURL * url = [NSURL URLWithString:@"https://news-at.zhihu.com/api/4/news/latest"];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            if (!error) {
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
