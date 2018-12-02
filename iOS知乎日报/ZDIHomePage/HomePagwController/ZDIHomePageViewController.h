//
//  ZDIHomePageViewController.h
//  iOS知乎日报
//
//  Created by 涂强尧 on 2018/11/5.
//  Copyright © 2018 涂强尧. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZDIHomePageView.h"
#import "ZDITableViewSectionView.h"
#import "ZDIHomePageManager.h"

@interface ZDIHomePageViewController : UIViewController <UITableViewDelegate>
@property (nonatomic, strong) ZDIHomePageView *homePageView;
@property (nonatomic, strong) ZDITableViewSectionView *sectionView;
@property (nonatomic, strong) NSMutableArray *navigitionMutableArray;
@property (nonatomic, strong) NSData *data;
@property (nonatomic, strong) NSMutableArray *dataMutableArray;
@property (nonatomic, strong) NSString *idNumber;
@property (nonatomic, strong) NSMutableArray *allIdNumberMutableArray;

+ (UIImage *) creatImageWithColor:(UIColor *)color;

@end
