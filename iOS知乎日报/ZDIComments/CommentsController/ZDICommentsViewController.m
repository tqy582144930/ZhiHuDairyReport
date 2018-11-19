//
//  ZDICommentsViewController.m
//  iOS知乎日报
//
//  Created by 涂强尧 on 2018/11/19.
//  Copyright © 2018 涂强尧. All rights reserved.
//

#import "ZDICommentsViewController.h"
#import "ZDICommentsTableViewCell.h"
#import "ZDICommentsManager.h"

@interface ZDICommentsViewController () <UITableViewDelegate>

@end

@implementation ZDICommentsViewController 

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"37条点评";
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:0.00f green:0.64f blue:0.93f alpha:1.00f];
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];
    _commentsView = [[ZDICommentsView alloc] initWithFrame:self.view.bounds];
    [_commentsView commentsViewInit];
    [self.view addSubview:_commentsView];
    _commentsView.tableView.delegate = self;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(sendFinished:) name:@"sendIdNumber" object:nil];
//    NSLog(@"%@", _idNumber);
//    [self updateCommentsView];
}

- (void)updateCommentsView {
    [[ZDICommentsManager sharedManager] fetchCommentsDataId:_idNumber Succeed:^(NSMutableArray * _Nonnull homaPageModel){
        NSMutableArray *array = [[NSMutableArray alloc] init];
        [array addObject:homaPageModel];
        NSLog(@"%@", homaPageModel);

    } error:^(NSError * _Nonnull error) {

    }];
}

- (void) sendFinished:(NSNotification *) notifaction {
    NSLog(@"%@", notifaction);
    
}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 260;
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
