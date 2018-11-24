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

- (void)viewWillAppear:(BOOL)animated {
    [self updateCommentsView];
    self.navigationController.navigationBar.hidden = NO;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"点评";
    self.navigationController.navigationBar.backgroundColor = [UIColor colorWithRed:0.00f green:0.64f blue:0.93f alpha:1.00f];
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];
    self.navigationItem.hidesBackButton = YES;
    
    _commentsView = [[ZDICommentsView alloc] initWithFrame:self.view.bounds];
    [_commentsView commentsViewInit];
    [self.view addSubview:_commentsView];
    _commentsView.tableView.delegate = self;
    [_commentsView.backButton addTarget:self action:@selector(backToNextView) forControlEvents:UIControlEventTouchUpInside];
    
    _cellHeightMutableArray = [[NSMutableArray alloc] init];
    _cell1HeightMutableArray = [[NSMutableArray alloc] init];
    _allCellHeightMutableArray = [[NSMutableArray alloc] init];

}

- (void)backToNextView {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)updateCommentsView {
    [[ZDICommentsManager sharedManager] fetchCommentsDataId:_idNumber Succeed:^(ZDICommentsModel * _Nonnull homaPageModel){
        self->_commentsView.allJSONModel = homaPageModel;
        NSDictionary *attri = @{NSFontAttributeName:[UIFont systemFontOfSize:18]};
        for (NSString *cellString in [self->_commentsView.allJSONModel.comments valueForKey:@"content"]) {
            CGRect tmpRect = [cellString boundingRectWithSize:CGSizeMake([UIScreen mainScreen].bounds.size.width - 80, 1000) options:NSStringDrawingUsesLineFragmentOrigin attributes:attri context:nil];
            CGFloat nameH = tmpRect.size.height + 80;
            [self->_cellHeightMutableArray addObject:@(nameH)];
        }
        [self->_allCellHeightMutableArray addObject:self->_cellHeightMutableArray];
        [self->_commentsView.tableView reloadData];
    } error:^(NSError * _Nonnull error) {

    }];
    
    [[ZDICommentsManager sharedManager] fetchShortCommentsDataId:_idNumber Succeed:^(ZDICommentsModel * _Nonnull homaPageModel) {
        self->_commentsView.allShortJSONModel = homaPageModel;
        NSDictionary *attri = @{NSFontAttributeName:[UIFont systemFontOfSize:18]};
        for (NSString *cellString1 in [self->_commentsView.allShortJSONModel.comments valueForKey:@"content"]) {
            CGRect tmpRect1 = [cellString1 boundingRectWithSize:CGSizeMake([UIScreen mainScreen].bounds.size.width - 100, 1000) options:NSStringDrawingUsesLineFragmentOrigin attributes:attri context:nil];
            CGFloat nameH1 = tmpRect1.size.height + 80;
            [self->_cell1HeightMutableArray addObject:@(nameH1)];
        }
        [self->_allCellHeightMutableArray addObject:self->_cell1HeightMutableArray];
        [self->_commentsView.tableView reloadData];
    } error:^(NSError * _Nonnull error) {
        
    }];
}



- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [_allCellHeightMutableArray[indexPath.section][indexPath.row] integerValue];
}


- (CGFloat) tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 40;
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
