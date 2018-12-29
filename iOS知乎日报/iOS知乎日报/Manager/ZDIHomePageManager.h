//
//  ZDIHomePageManager.h
//  iOS知乎日报
//
//  Created by 涂强尧 on 2018/11/8.
//  Copyright © 2018 涂强尧. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZDITopStoriseJSONModel.h"

@protocol ZDIHomePageManagerDelegete <NSObject>

- (void) selectDataInZDIHomePageView:(NSMutableArray *) titleArray AndPictures:(NSMutableArray *) pictureArray;
- (void) selectDataInZDIHomePageView:(NSMutableArray *) titleArray AndTopPictures:(NSMutableArray *) pictureArray;

@end

//返回当天数据
typedef void(^ZDIHomePageData)(ZDITotallJSONModel *homaPageModel);

// 请求失败统一回调block
typedef void(^ErrorHandle)(NSError *error);

@interface ZDIHomePageManager : NSObject

@property (nonatomic, strong) NSString *fileNameString;
@property (nonatomic, strong) NSMutableArray *titleMutableArray;
@property (nonatomic, strong) NSMutableArray *pictureMutableArray;
@property (nonatomic, weak) id<ZDIHomePageManagerDelegete> delegete;

+ (instancetype)sharedManager;

- (void)FMDatabaseCreate;
- (void)insertDataAndTitleMutabeArray:(NSMutableArray *) titleMutableArray AndPictureMutableArray:(NSMutableArray *) pictureMutableArray;
- (void)selectData;
- (void)deleteData;

- (void) FMDatabaseTopCreate;
- (void)insertDataAndTopTitleArray:(NSMutableArray *) topTitleMutableArray AndTopPictureMutableArray:(NSMutableArray *) topPictureMutableArray;
- (void)selectTopData;
- (void)deleteTopData;

- (void)fetchHomePageDataDay:(NSInteger)day Succeed:(ZDIHomePageData)succeedBlock error:(ErrorHandle)errorBlock;
- (void)fetchDatBeforeHomePageDataDay:(NSInteger)day Succeed:(ZDIHomePageData)succeedBlock error:(ErrorHandle)errorBlock;
@end
