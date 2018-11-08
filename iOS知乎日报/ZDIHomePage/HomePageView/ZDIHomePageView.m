//
//  ZDIHomePageView.m
//  iOS知乎日报
//
//  Created by 涂强尧 on 2018/11/5.
//  Copyright © 2018 涂强尧. All rights reserved.
//

#import "ZDIHomePageView.h"
#import <Masonry.h>
#import "ZDIHomePageTableViewCell.h"
#import "ZDITableViewSectionView.h"

static const int imageButtonCount = 3;

@implementation ZDIHomePageView
- (instancetype) initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        _homePageTableView = [[UITableView alloc] initWithFrame:[UIScreen mainScreen].bounds style:UITableViewStylePlain];
        _homePageTableView.dataSource = self;
        _homePageTableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        
        [_homePageTableView registerClass:[ZDIHomePageTableViewCell class] forCellReuseIdentifier:@"pictureCell"];
        [self addSubview:_homePageTableView];
        
        _homePageScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 220)];
        _homePageScrollView.delegate = self;
        //横竖两种滚轮都不显示
        _homePageScrollView.showsVerticalScrollIndicator = NO;
        _homePageScrollView.showsHorizontalScrollIndicator = NO;
        //需要分页
        _homePageScrollView.pagingEnabled = YES;
        //不需要回弹（试了一下加不加应该都没什么影响）
        _homePageScrollView.bounces = NO;
        _homePageTableView.tableHeaderView = _homePageScrollView;
        
        //在scrollView中添加三个图片按钮，因为后面需要响应点击事件，所以我直接用按钮不用imageView了，感觉更方便一些
        for (int i = 0;i < imageButtonCount; i++) {
            UIButton *imageBtn = [[UIButton alloc] init];
            UILabel *label = [[UILabel alloc] init];
            [_homePageScrollView addSubview:imageBtn];
            [imageBtn addSubview:label];
        }
        //添加pageControl
        _homePageController = [[UIPageControl alloc] init];
        [self addSubview:_homePageController];
        [_homePageController mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake([UIScreen mainScreen].bounds.size.width, 20));
            make.top.mas_equalTo(self.mas_top).mas_equalTo(200);
            make.centerX.mas_equalTo(self);
        }];
    }
    return self;
}

- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView {
    return 4;
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _storiesTitleMutableArray.count;
}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ZDIHomePageTableViewCell *cell = nil;
    if (cell == nil) {
        cell = [_homePageTableView dequeueReusableCellWithIdentifier:@"pictureCell" forIndexPath:indexPath];
    }
    cell.titleLabel.text = [_storiesTitleMutableArray objectAtIndex:indexPath.row];
    NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:[_storiesImageMutableArray objectAtIndex:indexPath.row][0]]];
    cell.titleImageView.image = [UIImage imageWithData:data];
    return cell;
}

//布局子控件
- (void)layoutSubviews {
    [super layoutSubviews];
    //设置scrollView的frame
    CGFloat width = self.bounds.size.width;
    CGFloat height = 220;
    //设置contentSize,不同轮播方向的时候contentSize是不一样的
    if (self.isScrollDorectionPortrait) { //竖向
        //contentSize要放三张图片
        _homePageScrollView.contentSize = CGSizeMake(width, height * imageButtonCount);
    } else { //横向
        _homePageScrollView.contentSize = CGSizeMake(width * imageButtonCount, height);
    }
    //设置三张图片的位置，并为三个按钮添加点击事件
    for (int i = 0; i < imageButtonCount; i++) {
        UIButton *imageBtn = _homePageScrollView.subviews[i];
        [imageBtn addTarget:self action:@selector(imageBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        if (self.isScrollDorectionPortrait) { //竖向
            imageBtn.frame = CGRectMake(0, i * height, width, height);
        } else { //横向
            imageBtn.frame = CGRectMake(i * width, 0, width, height);
        }
    }
    //设置contentOffset,显示最中间的图片
    if (self.isScrollDorectionPortrait) { //竖向
        _homePageScrollView.contentOffset = CGPointMake(0, height);
    } else { //横向
        _homePageScrollView.contentOffset = CGPointMake(width, 0);
    }
    
    //设置pageControl的位置
    //    CGFloat pageW = 100;
    //    CGFloat pageH = 20;
    //    CGFloat pageX = width/2 - 50;
    //    CGFloat pageY = height - pageH;
    //    _homePageController.frame = CGRectMake(pageX, pageY, pageW, pageH);
    
}
//设置pageControl的CurrentPageColor
- (void)setCurrentPageColor:(UIColor *)currentPageColor {
    _currentPageColor = currentPageColor;
    _homePageController.currentPageIndicatorTintColor = currentPageColor;
}
//设置pageControl的pageColor
- (void)setPageColor:(UIColor *)pageColor {
    _pageColor = pageColor;
    _homePageController.pageIndicatorTintColor = pageColor;
}
//根据传入的图片数组设置图片
- (void)setImages:(NSArray *)images  {
    _images = images;
    //pageControl的页数就是图片的个数
    _homePageController.numberOfPages = images.count;
    //默认一开始显示的是第0页
    _homePageController.currentPage = 0;
    //设置图片显示内容
    [self setContent];
    //开启定时器
    [self startTimer];
    
}
//设置显示内容
- (void)setContent {
    //设置三个imageBtn的显示图片
    for (int i = 0; i < _homePageScrollView.subviews.count; i++) {
        //取出三个imageBtn
        UIButton *imageBtn = _homePageScrollView.subviews[i];
        //这个是为了给图片做索引用的
        NSInteger index = _homePageController.currentPage;
        
        if (i == 0) { //第一个imageBtn，隐藏在当前显示的imageBtn的左侧
            index--; //当前页索引减1就是第一个imageBtn的图片索引
        } else if (i == 2) { //第三个imageBtn，隐藏在当前显示的imageBtn的右侧
            index++; //当前页索引加1就是第三个imageBtn的图片索引
        }
        //无限循环效果的处理就在这里
        if (index < 0) { //当上面index为0的时候，再向右拖动，左侧图片显示，这时候我们让他显示最后一张图片
            index = _homePageController.numberOfPages - 1;
        } else if (index == _homePageController.numberOfPages) { //当上面的index超过最大page索引的时候，也就是滑到最右再继续滑的时候，让他显示第一张图片
            index = 0;
        }
        imageBtn.tag = index;
        //用上面处理好的索引给imageBtn设置图片
        [imageBtn setBackgroundImage:self.images[index] forState:UIControlStateNormal];
        [imageBtn setBackgroundImage:self.images[index] forState:UIControlStateHighlighted];
    }
}
//状态改变之后更新显示内容
- (void)updateContent {
    CGFloat width = self.bounds.size.width;
    CGFloat height = self.bounds.size.height;
    [self setContent];
    //唯一跟设置显示内容不同的就是重新设置偏移量，让它永远用中间的按钮显示图片,滑动之后就偷偷的把偏移位置设置回去，这样就实现了永远用中间的按钮显示图片
    //设置偏移量在中间
    if (self.isScrollDorectionPortrait) {
        _homePageScrollView.contentOffset = CGPointMake(0, height);
    } else {
        _homePageScrollView.contentOffset = CGPointMake(width, 0);
    }
}

#pragma mark - UIScrollViewDelegate
//拖拽的时候执行哪些操作
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    //拖动的时候，哪张图片最靠中间，也就是偏移量最小，就滑到哪页
    //用来设置当前页
    NSInteger page = 0;
    //用来拿最小偏移量
    CGFloat minDistance = MAXFLOAT;
    //遍历三个imageView,看那个图片偏移最小，也就是最靠中间
    for (int i = 0; i < _homePageScrollView.subviews.count; i++) {
        UIButton *imageBtn = _homePageScrollView.subviews[i];
        CGFloat distance = 0;
        if (self.isScrollDorectionPortrait) {
            distance = ABS(imageBtn.frame.origin.y - scrollView.contentOffset.y);
        } else {
            distance = ABS(imageBtn.frame.origin.x - scrollView.contentOffset.x);
        }
        if (distance < minDistance) {
            minDistance = distance;
            page = imageBtn.tag;
        }
    }
    _homePageController.currentPage = page;
}
//开始拖拽的时候停止计时器
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    [self stopTimer];
}
//结束拖拽的时候开始定时器
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    [self startTimer];
}
//结束拖拽的时候更新image内容
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    [self updateContent];
}
//scroll滚动动画结束的时候更新image内容
- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView
{
    [self updateContent];
}
#pragma mark - 定时器
//开始计时器
- (void)startTimer {
    NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:2.0 target:self selector:@selector(nextImage) userInfo:nil repeats:YES];
    [[NSRunLoop mainRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
    self.timer = timer;
}
//停止计时器
- (void)stopTimer {
    //结束计时
    [self.timer invalidate];
    //计时器被系统强引用，必须手动释放
    self.timer = nil;
}
//通过改变contentOffset * 2换到下一张图片
- (void)nextImage {
    CGFloat height = 220;
    CGFloat width = self.bounds.size.width;
    if (self.isScrollDorectionPortrait) {
        [_homePageScrollView setContentOffset:CGPointMake(0, 2 * height) animated:YES];
    } else {
        [_homePageScrollView setContentOffset:CGPointMake(2 * width, 0) animated:YES];
    }
}


- (void)imageBtnClick:(UIButton *)btn {
    NSLog(@"%ld",btn.tag);
    //    if ([self.delegate respondsToSelector:@selector(carouselView:indexOfClickedImageBtn:)])
    //    {
    //        [self.delegate carouselView:self indexOfClickedImageBtn:btn.tag];
    //    }
    //
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
