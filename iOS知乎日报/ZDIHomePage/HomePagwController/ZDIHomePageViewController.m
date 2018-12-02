//
//  ZDIHomePageViewController.m
//  iOS知乎日报
//
//  Created by 涂强尧 on 2018/11/5.
//  Copyright © 2018 涂强尧. All rights reserved.
//

#import "ZDIHomePageViewController.h"
#import "ZDINextViewController.h"

@interface ZDIHomePageViewController ()
@property (nonatomic, assign) NSInteger days;
@property (nonatomic, assign) BOOL isLoading;
@property (nonatomic, strong) NSMutableArray *dayMutableArray;
@end

@implementation ZDIHomePageViewController

    
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
        NSString *serctionString = [NSString stringWithFormat:@"%lu", section + 1];
        _sectionView.sectionLabel.text = serctionString;
        return _sectionView;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSInteger section = indexPath.section;
    NSInteger row = indexPath.row;
    
    _idNumber = [[_dayMutableArray[section] valueForKey:@"stories"][row] valueForKey:@"id"];
    ZDINextViewController *nextViewController = [[ZDINextViewController alloc] init];
    nextViewController.idNumber = _idNumber;
    nextViewController.section = section;
    nextViewController.row = row;
    nextViewController.allIdnumberMutableArray = [NSMutableArray arrayWithArray:_allIdNumberMutableArray];
    [self.navigationController pushViewController:nextViewController animated:NO];
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
//    NSLog(@"%f", scrollView.contentOffset.y);
    
    if (scrollView.contentOffset.y < ([[_homePageView.modelArray[0] valueForKey:@"stories"] count] * 90 + 220)) {
        self.navigationController.navigationBar.hidden = NO;
        self.navigationItem.title = @"今日热闻";
        UIImage *colorImage = [ZDIHomePageViewController creatImageWithColor:[UIColor colorWithRed:0.24f green:0.78f blue:0.99f alpha:1.00f]];
        UIImage *colorLastImage = [ZDIHomePageViewController imageByApplyingAlpha:scrollView.contentOffset.y / 220.0 image:colorImage];
        [self.navigationController.navigationBar setBackgroundImage:colorLastImage forBarMetrics:UIBarMetricsDefault];
    } else {
        self.navigationController.navigationBar.hidden = YES;
    }
    
    
    if (self.homePageView.homePageTableView.userInteractionEnabled == NO) {
        return;
    }
    if (scrollView.contentOffset.y + [UIScreen mainScreen].bounds.size.height > scrollView.contentSize.height) {
        self.homePageView.homePageTableView.userInteractionEnabled = NO;
        [self updataHomePageView];
      
    }
}

- (void)updataHomePageView {
    if (_days == -1) {
        [[ZDIHomePageManager sharedManager] fetchHomePageDataDay:self.days Succeed:^(ZDITotallJSONModel *homaPageModel) {
            [self.homePageView.modelArray addObject:homaPageModel];
            [self->_dayMutableArray addObject:homaPageModel];
            
            NSMutableArray *sectionIdMutableArray = [[NSMutableArray alloc] init];
            for (int i = 0 ; i < [homaPageModel.stories count]; i++) {
                NSString *idString = [[homaPageModel valueForKey:@"stories"][i] valueForKey:@"id"];
                [sectionIdMutableArray addObject:idString];
            }
            [self->_allIdNumberMutableArray addObject:sectionIdMutableArray];
            
            self->_dataMutableArray = [[NSMutableArray alloc] init];
            for (int i = 0; i < [homaPageModel.top_stories count]; i++) {
                NSString *string = [NSString stringWithString:[homaPageModel.top_stories[i] imageStr]];
                NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:string]];
                UIImage *result = [UIImage imageWithData: data];
                [self->_dataMutableArray addObject:result];
            }
            self->_homePageView.images = self->_dataMutableArray;
        
            [self->_homePageView.homePageTableView reloadData];
            self.homePageView.homePageTableView.userInteractionEnabled = YES;
        } error:^(NSError *error) {
            
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
            self.homePageView.homePageTableView.userInteractionEnabled = YES;
        } error:^(NSError *error) {
            
        }];
    }
    _days++;
    
}

-(void)viewWillAppear:(BOOL)animated{
    self.navigationController.navigationBar.hidden = YES;
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
