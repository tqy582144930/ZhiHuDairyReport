//
//  ZDIHomePageViewController.m
//  iOS知乎日报
//
//  Created by 涂强尧 on 2018/11/5.
//  Copyright © 2018 涂强尧. All rights reserved.
//

#import "ZDIHomePageViewController.h"

@interface ZDIHomePageViewController ()
@property (nonatomic, assign) NSInteger days;
@property (nonatomic, assign) BOOL isLoading;
@property (nonatomic, strong) NSMutableArray *dayMutableArray;
@end

@implementation ZDIHomePageViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self updataHomePageView];
}
    
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.days = -1;
    _dayMutableArray = [NSMutableArray new];
    self.navigationItem.title = @"今日热闻";
    [self.navigationController.navigationBar setBackgroundImage:[[UIImage alloc] init] forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];
    self.navigationController.navigationBar.hidden = NO;
    self.navigationController.navigationBar.barStyle = UIBaselineAdjustmentNone;
    UIBarButtonItem *menuItem = [[UIBarButtonItem alloc] initWithTitle:@"菜单" style:UIBarButtonItemStylePlain target:self action:@selector(openCloseMenu:)];
    self.navigationItem.leftBarButtonItem = menuItem;
    
    _homePageView = [[ZDIHomePageView alloc] initWithFrame:self.view.frame];
    _homePageView.homePageTableView.delegate = self;
    [self.view addSubview:_homePageView];
}

- (void)openCloseMenu: (UIBarButtonItem *)sender
{
    [self.navigationController.parentViewController performSelector:@selector(openCloseMenu)];
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
    if (scrollView.contentOffset.y < ([_homePageView.allJsonModel.stories count] * 90 + 200)) {
        self.navigationController.navigationBar.hidden = NO;
        self.navigationItem.title = @"今日热闻";
        UIImage *colorImage = [ZDIHomePageViewController creatImageWithColor:[UIColor colorWithRed:0.24f green:0.78f blue:0.99f alpha:1.00f]];
        UIImage *colorLastImage = [ZDIHomePageViewController imageByApplyingAlpha:scrollView.contentOffset.y / 200.0 image:colorImage];
        [self.navigationController.navigationBar setBackgroundImage:colorLastImage forBarMetrics:UIBarMetricsDefault];
    } else {
        self.navigationController.navigationBar.hidden = YES;
    }
    
//    NSLog(@"%f %lu",scrollView.contentOffset.y,[_homePageView.allJsonModel.stories count] * 90 + 200);
//    NSLog(@"%f",scrollView.frame.size.height);
//    NSLog(@"%f",scrollView.contentSize.height);
    if (scrollView.contentOffset.y + scrollView.frame.size.height >= (([_homePageView.allJsonModel.stories count] * 90 * _dayMutableArray.count) + 200 )) {
        NSLog(@"111");
        [UIView commitAnimations];
        
        [UIView animateWithDuration:2.0 animations:^{
            self.homePageView.homePageTableView.contentInset = UIEdgeInsetsMake(0, 0, 60, 0);
        } completion:^(BOOL finished) {
            [self updataHomePageView];
            self.homePageView.homePageTableView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
        }];
    }
}

- (void)updataHomePageView {
    self.isLoading = YES;
    if (_days == -1) {
        [[ZDIHomePageManager sharedManager] fetchHomePageDataDay:self.days Succeed:^(ZDITotallJSONModel *homaPageModel) {
            self.homePageView.allJsonModel = homaPageModel;
            [self->_dayMutableArray addObject:homaPageModel];
            NSLog(@"a%li", self->_dayMutableArray.count);
            self->_days++;
            self.homePageView.number = [self->_dayMutableArray count];
            self->_dataMutableArray = [[NSMutableArray alloc] init];
            for (int i = 0; i < [homaPageModel.top_stories count]; i++) {
                NSString *string = [NSString stringWithString:[homaPageModel.top_stories[i] imageStr]];
                NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:string]];
                UIImage *result = [UIImage imageWithData: data];
                [self->_dataMutableArray addObject:result];
            }
            self->_homePageView.images = self->_dataMutableArray;
            [self->_homePageView.homePageTableView reloadData];
        } error:^(NSError *error) {
            
        }];
    } else {
        [[ZDIHomePageManager sharedManager] fetchDatBeforeHomePageDataDay:self.days Succeed:^(ZDITotallJSONModel *homaPageModel) {
            self.homePageView.allJsonModel = homaPageModel;
            [self->_dayMutableArray addObject:homaPageModel];
            self->_days++;
            self.homePageView.number = [self->_dayMutableArray count];
            [self->_homePageView.homePageTableView reloadData];
        } error:^(NSError *error) {
            
        }];
    }
    self.isLoading = NO;
    
    NSLog(@"b%li", [_dayMutableArray count]);
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
