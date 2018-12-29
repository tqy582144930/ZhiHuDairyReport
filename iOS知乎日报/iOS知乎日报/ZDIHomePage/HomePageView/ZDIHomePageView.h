//
//  ZDIHomePageView.h
//  iOS知乎日报
//
//  Created by 涂强尧 on 2018/11/5.
//  Copyright © 2018 涂强尧. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZDITableViewSectionView.h"
#import "ZDITopStoriseJSONModel.h"

@interface ZDIHomePageView : UIView <UITableViewDataSource, UIScrollViewDelegate>

@property (nonatomic, strong) UIScrollView *homePageScrollView;
@property (nonatomic, strong) UITableView *homePageTableView;
@property (nonatomic, strong) NSMutableArray *modelArray;
@property (nonatomic, strong) NSArray *images;
@property (nonatomic, strong) NSArray *titles;
@property (nonatomic, strong) NSArray *lables;
@property (nonatomic, strong) UIPageControl *homePageController;
@property (nonatomic, strong) NSTimer *timer;
@property (nonatomic, strong) UIColor *currentPageColor;
@property (nonatomic, strong) UIColor *pageColor;
//是否竖向滚动
@property (nonatomic, assign, getter=isScrollDorectionPortrait) BOOL scrollDorectionPortrait;

@property (nonatomic, strong) ZDITableViewSectionView *sectionView;

@property (nonatomic, strong) NSMutableArray *storiesTitleMutableArray;
@property (nonatomic, strong) NSMutableArray *storiesImageMutableArray;
@property (nonatomic, strong) NSMutableArray *titleMutableArray;
@property (nonatomic, strong) NSMutableArray *pictureMutableArray;
@property (nonatomic, assign) BOOL isInternetExist;

@end
