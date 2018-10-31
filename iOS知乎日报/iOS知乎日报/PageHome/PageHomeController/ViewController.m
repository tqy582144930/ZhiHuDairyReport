//
//  ViewController.m
//  iOS知乎日报
//
//  Created by 涂强尧 on 2018/10/16.
//  Copyright © 2018年 涂强尧. All rights reserved.
//

#import "ViewController.h"
#import "TQYHomePageTableViewCell.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.navigationItem.title = @"今日热闻";
    [self.navigationController.navigationBar setBackgroundImage:[[UIImage alloc] init] forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];
    self.navigationController.navigationBar.hidden = NO;
    self.navigationController.navigationBar.barStyle = UIBaselineAdjustmentNone;
    
    _homePageView = [[TQYPageHomeView alloc] initWithFrame:self.view.frame];
    _homePageView.homePageTableView.delegate = self;
//    _homePageView.images = ;
    [self.view addSubview:_homePageView];
    
    _homePageModel = [[HomePageModel alloc] init];
    [_homePageModel load];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(sendStoriesTitle:) name:@"sendStoriesTitle" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(sendStoriesImages:) name:@"sendStoriesImages" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(sendTopStoriesTitle:) name:@"sendTopStoriesTitle" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(sendTopStoriesImages:) name:@"sendTopStoriesImages" object:nil];
}

- (void) sendStoriesTitle: (NSNotification *)notifaction {
    _homePageView.storiesTitleMutableArray = [NSMutableArray arrayWithArray:notifaction.object];
    _navigitionMutableArray = [NSMutableArray arrayWithArray:notifaction.object];
    [_homePageView.homePageTableView reloadData];
//    NSLog(@"111%ld", _homePageView.storiesTitleMutableArray.count);
}

- (void) sendStoriesImages: (NSNotification *)notification {
    _homePageView.storiesImageMutableArray = [NSMutableArray arrayWithArray:notification.object];
    [_homePageView.homePageTableView reloadData];
//    NSLog(@"1111%@", _homePageView.storiesImageMutableArray);
}

- (void) sendTopStoriesTitle: (NSNotification *)notification {
//    _topStoriesTitleMutableArray = [NSMutableArray arrayWithArray:notification.object];
//    [_homePageView.homePageScrollView reloadData];
}

- (void) sendTopStoriesImages: (NSNotification *)notification {
//    _topStoriesImageMutableArray = [NSMutableArray arrayWithArray:notification.object];
//    [_homePageView.homePageScrollView reloadData];
}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 90;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return 0;
    } else {
        return 64;
    }
}

- (CGFloat) tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0;
}

- (UIView *) tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    return nil;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return nil;
    } else {
        _sectionView = [[ZDITableViewSectionView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 64)];
        NSString *serctionString = [NSString stringWithFormat:@"%lu", section];
        _sectionView.sectionLabel.text = serctionString;
        return _sectionView;
    }
}

//设置纯色图片
+ (UIImage *) creatImageWithColor:(UIColor *)color {
    CGRect rect=CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return theImage;
}

//设置图片透明度
+ (UIImage *)imageByApplyingAlpha:(CGFloat)alpha  image:(UIImage*)image
{
    UIGraphicsBeginImageContextWithOptions(image.size, NO, 0.0f);
    
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    CGRect area = CGRectMake(0, 0, image.size.width, image.size.height);
    
    CGContextScaleCTM(ctx, 1, -1);
    
    CGContextTranslateCTM(ctx, 0, -area.size.height);
    
    CGContextSetBlendMode(ctx, kCGBlendModeMultiply);
    
    CGContextSetAlpha(ctx, alpha);
    
    CGContextDrawImage(ctx, area, image.CGImage);
    
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return newImage;
}

//导航栏渐变
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (scrollView.contentOffset.y < (_navigitionMutableArray.count * 90 + 200)) {
        self.navigationController.navigationBar.hidden = NO;
        self.navigationItem.title = @"今日热闻";
        UIImage *colorImage = [ViewController creatImageWithColor:[UIColor colorWithRed:0.24f green:0.78f blue:0.99f alpha:1.00f]];
        UIImage *colorLastImage = [ViewController imageByApplyingAlpha:scrollView.contentOffset.y / 200.0 image:colorImage];
        [self.navigationController.navigationBar setBackgroundImage:colorLastImage forBarMetrics:UIBarMetricsDefault];
    } else {
        self.navigationController.navigationBar.hidden = YES;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
