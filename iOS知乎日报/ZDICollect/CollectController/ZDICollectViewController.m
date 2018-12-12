//
//  ZDICollectViewController.m
//  iOS知乎日报
//
//  Created by 涂强尧 on 2018/12/11.
//  Copyright © 2018 涂强尧. All rights reserved.
//

#import "ZDICollectViewController.h"
#import "ZDINextViewController.h"


@interface ZDICollectViewController ()

@end

@implementation ZDICollectViewController

- (void)viewWillAppear:(BOOL)animated {
    self.navigationController.navigationBar.hidden = NO;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"收藏";
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:0.00f green:0.64f blue:0.93f alpha:1.00f];
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];
    UIBarButtonItem *menuItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"2fanhui"] style:UIBarButtonItemStyleDone target:self action:@selector(back:)];
    menuItem.tintColor = [UIColor whiteColor];
    self.navigationItem.leftBarButtonItem = menuItem;
    
    _collectView = [[ZDICollectView alloc] initWithFrame:CGRectMake(0, 60, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
    _collectView.collectMutableArray = [NSMutableArray arrayWithArray:_collectionMutableArray];
    [_collectView collectViewInit];
    [_collectView.collectTableView reloadData];
    _collectView.collectTableView.delegate = self;
    [self.view addSubview:_collectView];
}

- (void) back:(UIButton *)button {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 90;
}

- (CGFloat) tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0;
}

- (UIView *) tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    return nil;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    ZDINextViewController *nextViewController = [[ZDINextViewController alloc] init];
    nextViewController.idNumber = _collectionMutableArray[indexPath.row][0];
    [self.navigationController pushViewController:nextViewController animated:YES];
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
