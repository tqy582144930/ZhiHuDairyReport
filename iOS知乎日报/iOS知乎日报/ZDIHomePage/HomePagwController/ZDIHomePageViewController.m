//
//  ZDIHomePageViewController.m
//  iOS知乎日报
//
//  Created by 涂强尧 on 2018/11/5.
//  Copyright © 2018 涂强尧. All rights reserved.
//

#import "ZDIHomePageViewController.h"
#import "ZDINextViewController.h"
#import "FMDB.h"

@interface ZDIHomePageViewController ()
@property (nonatomic, assign) NSInteger days;
@property (nonatomic, assign) BOOL isLoading;
@property (nonatomic, strong) NSMutableArray *dayMutableArray;
@end

@implementation ZDIHomePageViewController


- (void)viewWillAppear:(BOOL)animated {
    self.navigationController.navigationBar.hidden = YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.days = -1;
    _dayMutableArray = [NSMutableArray new];
    _allIdNumberMutableArray = [NSMutableArray new];
    self.navigationItem.title = @"今日热闻";
    [self.navigationController.navigationBar setBackgroundImage:[[UIImage alloc] init] forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];
    self.navigationController.navigationBar.hidden = NO;
    self.navigationController.navigationBar.barStyle = UIBaselineAdjustmentNone;

    
    UIBarButtonItem *menuItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"gengduo-"] style:UIBarButtonItemStyleDone target:self action:@selector(openCloseMenu:)];
    menuItem.tintColor = [UIColor whiteColor];
    self.navigationItem.leftBarButtonItem = menuItem;
    
    _homePageView = [[ZDIHomePageView alloc] initWithFrame:self.view.frame];
    _homePageView.homePageTableView.delegate = self;
    [self.view addSubview:_homePageView];
    [self updataHomePageView];
    
    _manager = [ZDIHomePageManager sharedManager];
    _manager.delegete = self;
    [_manager FMDatabaseCreate];
    [_manager FMDatabaseTopCreate];
    self.internetIsExist = YES;
}

- (void)openCloseMenu: (UIBarButtonItem *)sender {
    [self.navigationController.parentViewController performSelector:@selector(openCloseMenu)];
}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 90;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return 0;
    } else {
        return 50;
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
        _sectionView = [[ZDITableViewSectionView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 50)];
        
        NSString *sectionString = [NSString stringWithFormat:@"%@", [_dayMutableArray[section] date]];
        NSDateFormatter* dateFormat = [[NSDateFormatter alloc]init];//实例化一个NSDateFormatter对象
        [dateFormat setDateFormat:@"yyyyMMdd"];//设定时间格式,要注意跟下面的dateString匹配，否则日起将无效
        NSDate *date =[dateFormat dateFromString:sectionString];
        NSArray *weekdays = [NSArray arrayWithObjects:@"星期天",@"星期一",@"星期二",@"星期三",@"星期四",@"星期五",@"星期六",nil];
        NSCalendar *calendar = [[NSCalendar alloc]initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
        NSTimeZone *timeZone = [[NSTimeZone alloc]initWithName:@"Asia/Shanghai"];
        [calendar setTimeZone: timeZone];
        NSCalendarUnit calendarUnit = NSCalendarUnitWeekday;
        NSDateComponents* theComponents = [calendar components:calendarUnit fromDate:date];
        
        NSString *monthsString = [sectionString substringWithRange:NSMakeRange(4, 2)];
        NSString *dayString = [sectionString substringWithRange:NSMakeRange(6, 2)];
//        NSLog(@"%@",  [weekdays objectAtIndex:theComponents.weekday]);
        NSString *dateString = [NSString stringWithFormat:@"%@月%@日 %@", monthsString, dayString, [weekdays objectAtIndex:theComponents.weekday]];
        _sectionView.sectionLabel.text = dateString;
        return _sectionView;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSInteger section = indexPath.section;
    NSInteger row = indexPath.row;
    
    ZDINextViewController *nextViewController = [[ZDINextViewController alloc] init];
    if (_internetIsExist == NO) {
        _idNumber = [[_dayMutableArray[section] valueForKey:@"stories"][row] valueForKey:@"id"];
        nextViewController.idNumber = _idNumber;
        nextViewController.section = section;
        nextViewController.row = row;
        nextViewController.allIdnumberMutableArray = [NSMutableArray arrayWithArray:_allIdNumberMutableArray];
        nextViewController.modelArray = [NSMutableArray arrayWithArray:_dayMutableArray];
        [self.navigationController pushViewController:nextViewController animated:NO];
    } else {
        [self.navigationController pushViewController:nextViewController animated:NO];
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
+ (UIImage *)imageByApplyingAlpha:(CGFloat)alpha  image:(UIImage*)image {
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
//    NSLog(@"%f", scrollView.contentOffset.y);
    if (_internetIsExist == NO) {
        if (scrollView.contentOffset.y < ([[_homePageView.modelArray[0] valueForKey:@"stories"] count] * 90 + 220)) {
            self.navigationController.navigationBar.hidden = NO;
            self.navigationItem.title = @"今日热闻";
            UIImage *colorImage = [ZDIHomePageViewController creatImageWithColor:[UIColor colorWithRed:0.02f green:0.56f blue:0.84f alpha:1.00f]];
            UIImage *colorLastImage = [ZDIHomePageViewController imageByApplyingAlpha:scrollView.contentOffset.y / 220.0 image:colorImage];
            [self.navigationController.navigationBar setBackgroundImage:colorLastImage forBarMetrics:UIBarMetricsDefault];
        } else {
            self.navigationController.navigationBar.hidden = YES;
        }
    } else if (_internetIsExist == YES) {
        if (scrollView.contentOffset.y < ([_noInternetTitleMutableArray count] * 90 + 220)) {
            self.navigationController.navigationBar.hidden = NO;
            self.navigationItem.title = @"今日热闻";
            UIImage *colorImage = [ZDIHomePageViewController creatImageWithColor:[UIColor colorWithRed:0.02f green:0.56f blue:0.84f alpha:1.00f]];
            UIImage *colorLastImage = [ZDIHomePageViewController imageByApplyingAlpha:scrollView.contentOffset.y / 220.0 image:colorImage];
            [self.navigationController.navigationBar setBackgroundImage:colorLastImage forBarMetrics:UIBarMetricsDefault];
        } else {
            self.navigationController.navigationBar.hidden = YES;
        }
    }
    
    
    if (scrollView.contentOffset.y + [UIScreen mainScreen].bounds.size.height > scrollView.contentSize.height) {
        if (self.isLoading) {
            return;
        } else {
            [self updataHomePageView];
        }
    }
}

- (void)selectDataInZDIHomePageView:(NSMutableArray *)titleArray AndPictures:(NSMutableArray *)pictureArray {
    _noInternetTitleMutableArray = [NSMutableArray arrayWithArray:titleArray];
    self.homePageView.titleMutableArray = [NSMutableArray arrayWithArray:self->_noInternetTitleMutableArray];
    self.homePageView.pictureMutableArray = [NSMutableArray arrayWithArray:pictureArray];
}

- (void)selectDataInZDIHomePageView:(NSMutableArray *)titleArray AndTopPictures:(NSMutableArray *)pictureArray {
    NSMutableArray *topPictureMutableArray = [NSMutableArray new];
    for (int i = 0; i < pictureArray.count; i++) {
        NSData *topPictureData = pictureArray[i];
        UIImage *topImage = [UIImage imageWithData:topPictureData];
        [topPictureMutableArray addObject:topImage];
    }
    self->_homePageView.images = [NSMutableArray arrayWithArray:topPictureMutableArray];
    self->_homePageView.titles = [NSMutableArray arrayWithArray:titleArray];
}

- (void)updataHomePageView {
    self.isLoading = YES;
    if (_days == -1) {
        [[ZDIHomePageManager sharedManager] fetchHomePageDataDay:self.days Succeed:^(ZDITotallJSONModel *homaPageModel) {
            //是否存在网络
            self->_internetIsExist = NO;
            [self.homePageView.modelArray addObject:homaPageModel];
            [self->_dayMutableArray addObject:homaPageModel];
            
            //设定标记数组
            NSMutableArray *sectionIdMutableArray = [[NSMutableArray alloc] init];
            for (int i = 0 ; i < [homaPageModel.stories count]; i++) {
                NSString *idString = [[homaPageModel valueForKey:@"stories"][i] valueForKey:@"id"];
                [sectionIdMutableArray addObject:idString];
            }
            [self->_allIdNumberMutableArray addObject:sectionIdMutableArray];
            
            //获取cell中图片
            NSMutableArray *pictureArray = [NSMutableArray new];
            for (int i = 0; i <[homaPageModel.stories count] ; i++) {
                NSArray *picturearray = [homaPageModel.stories[i] images];
                NSString *string = picturearray[0];
                [pictureArray addObject:string];
            }
            
            //cell调用数据库
            [self->_manager deleteData];
            [self->_manager insertDataAndTitleMutabeArray:[[self->_dayMutableArray valueForKey:@"stories"] valueForKey:@"title"] AndPictureMutableArray:pictureArray];
            self.homePageView.isInternetExist = self->_internetIsExist;
            [self->_homePageView.homePageTableView reloadData];
            
            //给轮播图赋值
            self->_dataMutableArray = [[NSMutableArray alloc] init];
            self->_titleMutableArray = [[NSMutableArray alloc] init];
            for (int i = 0; i < [homaPageModel.top_stories count]; i++) {
                NSString *string = [NSString stringWithString:[homaPageModel.top_stories[i] imageStr]];
                NSString *titleString = [NSString stringWithString:[homaPageModel.top_stories[i] title]];
                NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:string]];
                UIImage *result = [UIImage imageWithData: data];
                [self->_dataMutableArray addObject:result];
                [self->_titleMutableArray addObject:titleString];
            }
            self->_homePageView.images = self->_dataMutableArray;
            self->_homePageView.titles = [NSMutableArray arrayWithArray:self->_titleMutableArray];
            
            
            NSMutableArray *topPictureArray = [NSMutableArray new];
            for (int i = 0; i <[homaPageModel.top_stories count] ; i++) {
                NSString *topPictureString = [homaPageModel.top_stories[i] imageStr];
//                UIImage *topimage = [UIImage imageNamed:topPictureString];
                NSData *topData = [NSData dataWithContentsOfURL:[NSURL URLWithString:topPictureString]];
                [topPictureArray addObject:topData];
            }
            
            //给轮播图数据库赋值
            [self->_manager deleteTopData];
            [self->_manager insertDataAndTopTitleArray:[[self->_dayMutableArray valueForKey:@"top_stories"] valueForKey:@"title"] AndTopPictureMutableArray:topPictureArray];
            NSLog(@"topTitleArray = %@, topPictureArray = %@", [[self->_dayMutableArray valueForKey:@"top_stories"] valueForKey:@"title"], topPictureArray);
            
            self.isLoading = NO;
        } error:^(NSError *error) {
            self.homePageView.isInternetExist = self->_internetIsExist;
            if (self.internetIsExist == YES) {
                dispatch_time_t time = dispatch_time(DISPATCH_TIME_NOW, 3*NSEC_PER_SEC);
                dispatch_after(time, dispatch_get_main_queue(), ^{
                    [self->_manager selectData];
                    [self->_manager selectTopData];
                    [self.homePageView.homePageTableView reloadData];
                });
            }
        }];
    } else {
        [[ZDIHomePageManager sharedManager] fetchDatBeforeHomePageDataDay:self.days Succeed:^(ZDITotallJSONModel *homaPageModel) {
            [self.homePageView.modelArray addObject:homaPageModel];
            [self->_dayMutableArray addObject:homaPageModel];
            
            NSMutableArray *sectionIdMutableArray = [[NSMutableArray alloc] init];
            for (int i = 0 ; i < [homaPageModel.stories count]; i++) {
                NSString *idString = [[homaPageModel valueForKey:@"stories"][i] valueForKey:@"id"];
                [sectionIdMutableArray addObject:idString];
            }
            [self->_allIdNumberMutableArray addObject:sectionIdMutableArray];
            [self->_homePageView.homePageTableView reloadData];
            self.isLoading = NO;
        } error:^(NSError *error) {
            
        }];
    }
    _days++;
    
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
