//
//  ZDISideMenuViewController.m
//  iOS知乎日报
//
//  Created by 涂强尧 on 2018/11/5.
//  Copyright © 2018 涂强尧. All rights reserved.
//

#import "ZDISideMenuViewController.h"
#import "ZDISideMenuView.h"
#import "ZDICollectViewController.h"

@interface ZDISideMenuViewController ()

@end

@implementation ZDISideMenuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor colorWithRed:0.13f green:0.16f blue:0.19f alpha:1.00f];
    self.view.frame = CGRectMake(-[UIScreen mainScreen].bounds.size.width/2, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
    _sideMenuView = [[ZDISideMenuView alloc] initWithFrame:self.view.bounds];
    [_sideMenuView ZDISideMenuViewInit];
    [_sideMenuView.itemButton addTarget:self action:@selector(menuItemSelected:) forControlEvents:  UIControlEventTouchUpInside];
    [_sideMenuView.colletctButton addTarget:self action:@selector(clickedButton:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_sideMenuView];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(sendCollection:) name:@"sendCollection" object:nil];
    _collectionMutableArray = [NSMutableArray new];
}
//选中菜单栏
- (void)menuItemSelected: (UIButton *)sender
{
    //判断是否响应这个代理方法
    if ([self.delegate respondsToSelector:@selector(menuController:didSelectItemAtIndex:)]) {
        [self.delegate menuController:self didSelectItemAtIndex:sender.tag - 1];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)clickedButton:(UIButton *)button {
    ZDICollectViewController *collectViewController = [[ZDICollectViewController alloc] init];
    collectViewController.collectionMutableArray = [NSMutableArray arrayWithArray:_collectionMutableArray];
    UINavigationController *navigation = [[UINavigationController alloc] initWithRootViewController:collectViewController];
    [self presentViewController:navigation animated:YES completion:nil];
}

- (void)sendCollection:(NSNotification *)notification {
    [_collectionMutableArray addObject:notification.object];
    
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
