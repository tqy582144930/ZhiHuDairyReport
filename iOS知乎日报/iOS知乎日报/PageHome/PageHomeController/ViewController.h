//
//  ViewController.h
//  iOS知乎日报
//
//  Created by 涂强尧 on 2018/10/16.
//  Copyright © 2018年 涂强尧. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TQYPageHomeView.h"
#import "HomePageModel.h"
#import "ZDITableViewSectionView.h"

@interface ViewController : UIViewController <UITableViewDelegate>

@property (nonatomic, strong) TQYPageHomeView *homePageView;
@property (nonatomic, strong) HomePageModel *homePageModel;
@property (nonatomic, strong) NSMutableArray *topStoriesTitleMutableArray;
@property (nonatomic, strong) NSMutableArray *topStoriesImageMutableArray;
@property (nonatomic, strong) ZDITableViewSectionView *sectionView;
@property (nonatomic, strong) NSMutableArray *navigitionMutableArray;
@property (nonatomic, strong) NSData *data;
@property (nonatomic, strong) NSMutableArray *dataMutableArray;

+ (UIImage *) creatImageWithColor:(UIColor *)color;
@end

