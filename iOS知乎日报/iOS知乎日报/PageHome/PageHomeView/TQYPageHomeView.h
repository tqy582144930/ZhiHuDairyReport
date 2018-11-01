//
//  TQYPageHomeView.h
//  iOS知乎日报
//
//  Created by 涂强尧 on 2018/10/16.
//  Copyright © 2018年 涂强尧. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZDITableViewSectionView.h"

@interface TQYPageHomeView : UIView<UITableViewDataSource, UIScrollViewDelegate>

@property (nonatomic, strong) UIScrollView *homePageScrollView;
@property (nonatomic, strong) UITableView *homePageTableView;
@property (nonatomic, strong) NSArray *images;
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

@end
