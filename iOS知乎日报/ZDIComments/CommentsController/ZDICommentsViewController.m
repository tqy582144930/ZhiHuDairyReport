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
#import <Masonry.h>

@interface ZDICommentsViewController () <UITableViewDelegate>

@end

@implementation ZDICommentsViewController

- (void)viewWillAppear:(BOOL)animated {
    [self updateCommentsView];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"点评";
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:0.00f green:0.64f blue:0.93f alpha:1.00f];
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
    
    _clickedButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_clickedButton setImage:[UIImage imageNamed:@"xiangxia"] forState:UIControlStateNormal];
    [_clickedButton setImage:[UIImage imageNamed:@"xiangshang"] forState:UIControlStateSelected];
    _flag = 0;
}

- (void)backToNextView {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)updateCommentsView {
    [[ZDICommentsManager sharedManager] fetchCommentsDataId:_idNumber Succeed:^(ZDICommentsModel * _Nonnull homaPageModel){
        self->_commentsView.allJSONModel = homaPageModel;
        NSDictionary *attri = @{NSFontAttributeName:[UIFont systemFontOfSize:18]};
        CGFloat nameH1 = 0.0, nameH2 = 0.0;
        for (int i = 0; i < [self->_commentsView.allJSONModel.comments count]; i++) {
            NSString *string1 = [self->_commentsView.allJSONModel.comments valueForKey:@"content"][i];
            CGRect tmpRect1 = [string1 boundingRectWithSize:CGSizeMake([UIScreen mainScreen].bounds.size.width - 80, 1000) options:NSStringDrawingUsesLineFragmentOrigin attributes:attri context:nil];
            nameH1 = tmpRect1.size.height + 105;
            
            NSString *string2 = [[self->_commentsView.allJSONModel.comments valueForKey:@"reply_to"] valueForKey:@"content"][i];
            if (![string2 isKindOfClass:[NSString class]]) {
                nameH2 = 0.0;
            } else {
                CGRect tmpRect2 = [string2 boundingRectWithSize:CGSizeMake([UIScreen mainScreen].bounds.size.width - 80, 1000) options:NSStringDrawingUsesLineFragmentOrigin attributes:attri context:nil];
                nameH2 = tmpRect2.size.height;
            }
            [self->_cellHeightMutableArray addObject:@(nameH1 + nameH2)];
        }
        [self->_allCellHeightMutableArray addObject:self->_cellHeightMutableArray];
        [self->_commentsView.tableView reloadData];
    } error:^(NSError * _Nonnull error) {

    }];
    
    [[ZDICommentsManager sharedManager] fetchShortCommentsDataId:_idNumber Succeed:^(ZDICommentsModel * _Nonnull homaPageModel) {
        self->_commentsView.allShortJSONModel = homaPageModel;
        CGFloat nameH1 = 0.0, nameH2 = 0.0;
        NSDictionary *attri = @{NSFontAttributeName:[UIFont systemFontOfSize:18]};
        for (int i = 0; i < [self->_commentsView.allShortJSONModel.comments count]; i++) {
            NSString *string1 = [self->_commentsView.allShortJSONModel.comments valueForKey:@"content"][i];
            CGRect tmpRect1 = [string1 boundingRectWithSize:CGSizeMake([UIScreen mainScreen].bounds.size.width - 80, 1000) options:NSStringDrawingUsesLineFragmentOrigin attributes:attri context:nil];
            nameH1 = tmpRect1.size.height + 105;
            
            NSString *string2 = [[self->_commentsView.allShortJSONModel.comments valueForKey:@"reply_to"] valueForKey:@"content"][i];
            if (![string2 isKindOfClass:[NSString class]]) {
                nameH2 = 0.0;
            } else {
                CGRect tmpRect2 = [string2 boundingRectWithSize:CGSizeMake([UIScreen mainScreen].bounds.size.width - 80, 1000) options:NSStringDrawingUsesLineFragmentOrigin attributes:attri context:nil];
                nameH2 = tmpRect2.size.height;
            }
            [self->_cell1HeightMutableArray addObject:@(nameH1 + nameH2)];
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

- (UIView *) tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        UIView *longView = [[UIView alloc] init];
        longView.backgroundColor = [UIColor whiteColor];
        UILabel *longLabel = [[UILabel alloc] initWithFrame:CGRectMake(5, 5, 100, 20)];
        longLabel.text = [NSString stringWithFormat:@"%lu 条长评",[_cellHeightMutableArray count]];
        [longView addSubview:longLabel];
        return longView;
    }else {
        UIView *shortView = [[UIView alloc] init];
        shortView.backgroundColor = [UIColor whiteColor];
        UILabel *shortLabel = [[UILabel alloc] initWithFrame:CGRectMake(5, 10, 100, 20)];
        shortLabel.text = [NSString stringWithFormat:@"%lu 条短评",[_cell1HeightMutableArray count]];
        [shortView addSubview:shortLabel];
        [_clickedButton addTarget:self action:@selector(clicked:) forControlEvents:UIControlEventTouchUpInside];
        [shortView addSubview:_clickedButton];
        [_clickedButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(-15);
            make.top.mas_equalTo(10);
            make.size.mas_equalTo(CGSizeMake(20, 20));
        }];
        return shortView;
    }
}

- (void)clicked:(UIButton *) button {
    button.selected = !button.selected;
    if (button.selected) {
        _flag++;
    }else {
        _flag--;
    }
    _commentsView.flag = _flag;
    double count = 0.0;
    for (int i = 0; i < self->_cellHeightMutableArray.count; i++) {
        count+= [_cellHeightMutableArray[i] doubleValue];
    }

    if (_flag == 1) {
        _commentsView.tableView.contentOffset = CGPointMake(0, -count);
    } else {
        _commentsView.tableView.contentOffset = CGPointMake(0, count);
    }
    [_commentsView.tableView reloadData];
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
