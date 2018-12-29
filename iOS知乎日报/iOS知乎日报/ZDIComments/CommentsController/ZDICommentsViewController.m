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

@interface ZDICommentsViewController () <UITableViewDelegate, ZDICommentsTableViewDelegate>

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
    _isSelectedMutableArray = [[NSMutableArray alloc] init];
    
    _clickedButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_clickedButton setImage:[UIImage imageNamed:@"xiangxia"] forState:UIControlStateNormal];
    [_clickedButton setImage:[UIImage imageNamed:@"xiangshang"] forState:UIControlStateSelected];
    _flag = 0;
   
    [self setIsSelectedMutbaleArray];

    self.commentsView.delegate = self;
    _commentsView.isSelectedMutableArray = _isSelectedMutableArray;
}

- (void)backToNextView {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)updateCommentsView {
    [[ZDICommentsManager sharedManager] fetchCommentsDataId:_idNumber Succeed:^(ZDICommentsModel * _Nonnull homaPageModel){
        self->_commentsView.allJSONModel = homaPageModel;
        [self calculateLongCellHeight];
        [self->_commentsView.tableView reloadData];
    } error:^(NSError * _Nonnull error) {

    }];
    
    [[ZDICommentsManager sharedManager] fetchShortCommentsDataId:_idNumber Succeed:^(ZDICommentsModel * _Nonnull homaPageModel) {
        self->_commentsView.allShortJSONModel = homaPageModel;
        [self calculateShortCellHeight];
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

    if (_flag == 0) {
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:1];
        [self.commentsView.tableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionTop animated:NO];
    }

    [_commentsView.tableView reloadData];
}

- (void) calculateLongCellHeight{
    NSDictionary *attri = @{NSFontAttributeName:[UIFont systemFontOfSize:18]};
    CGFloat nameH1 = 0.0, nameH2 = 0.0, nameH3 = 0.0;
    for (int i = 0; i < [self->_commentsView.allJSONModel.comments count]; i++) {
        NSString *string1 = [self->_commentsView.allJSONModel.comments valueForKey:@"content"][i];
        CGRect tmpRect1 = [string1 boundingRectWithSize:CGSizeMake([UIScreen mainScreen].bounds.size.width - 80, 1500) options:NSStringDrawingUsesLineFragmentOrigin attributes:attri context:nil];
        nameH1 = tmpRect1.size.height + 85;
        
        NSString *string2 = [NSString stringWithFormat:@"//%@:%@",[[self->_commentsView.allJSONModel.comments valueForKey:@"reply_to"] valueForKey:@"author"][i], [[self->_commentsView.allJSONModel.comments valueForKey:@"reply_to"] valueForKey:@"content"][i]];
        NSLog(@"string2 = %@", string2);
        if ([string2 isEqualToString:@"//<null>:<null>"]) {
            nameH2 = 0.0;
        } else {
            nameH2= 53.3333;
        }
        CGRect tmpRect2 = [string2 boundingRectWithSize:CGSizeMake([UIScreen mainScreen].bounds.size.width - 80, 1500) options:NSStringDrawingUsesLineFragmentOrigin attributes:attri context:nil];
        nameH3 = tmpRect2.size.height;
        [self->_cellHeightMutableArray addObject:@(nameH1 + nameH2)];
        [self->_commentsView.LongReplyHeightMutableArray addObject:@(nameH3)];
    }
    [self->_allCellHeightMutableArray addObject:self->_cellHeightMutableArray];
}

- (void) calculateShortCellHeight{
    CGFloat nameH1 = 0.0, nameH2 = 0.0, nameH3 = 0.0;
    NSDictionary *attri = @{NSFontAttributeName:[UIFont systemFontOfSize:18]};
    for (int i = 0; i < [self->_commentsView.allShortJSONModel.comments count]; i++) {
        NSString *string1 = [self->_commentsView.allShortJSONModel.comments valueForKey:@"content"][i];
        CGRect tmpRect1 = [string1 boundingRectWithSize:CGSizeMake([UIScreen mainScreen].bounds.size.width - 80, 1500) options:NSStringDrawingUsesLineFragmentOrigin attributes:attri context:nil];
        nameH1 = tmpRect1.size.height + 85;
        
        NSString *string2 = [NSString stringWithFormat:@"//%@:%@",[[self->_commentsView.allShortJSONModel.comments valueForKey:@"reply_to"] valueForKey:@"author"][i], [[self->_commentsView.allShortJSONModel.comments valueForKey:@"reply_to"] valueForKey:@"content"][i]];
        if ([string2 isEqualToString:@"//<null>:<null>"]) {
            nameH2 = 0.0;
        } else {
            nameH2= 53.3333;
        }
        CGRect tmpRect2 = [string2 boundingRectWithSize:CGSizeMake([UIScreen mainScreen].bounds.size.width - 80, 1500) options:NSStringDrawingUsesLineFragmentOrigin attributes:attri context:nil];
        nameH3 = tmpRect2.size.height;
        [self->_cell1HeightMutableArray addObject:@(nameH1 + nameH2)];
        [self->_commentsView.shortReplyHeightMutableArray addObject:@(nameH3)];
    }
    [self->_allCellHeightMutableArray addObject:self->_cell1HeightMutableArray];

}

- (NSNumber *) calculateClickedLongCellHeight:(NSIndexPath *) indexpath andSign:(NSInteger) sign{
    NSDictionary *attri = @{NSFontAttributeName:[UIFont systemFontOfSize:18]};
    CGFloat nameH1 = 0.0, nameH2 = 0.0;
    NSString *string1 = [self->_commentsView.allJSONModel.comments valueForKey:@"content"][indexpath.row];
    CGRect tmpRect1 = [string1 boundingRectWithSize:CGSizeMake([UIScreen mainScreen].bounds.size.width - 80, 1500) options:NSStringDrawingUsesLineFragmentOrigin attributes:attri context:nil];
    nameH1 = tmpRect1.size.height + 85;
    
    NSString *string2 = [NSString stringWithFormat:@"//%@:%@",[[self->_commentsView.allJSONModel.comments valueForKey:@"reply_to"] valueForKey:@"author"][indexpath.row], [[self->_commentsView.allJSONModel.comments valueForKey:@"reply_to"] valueForKey:@"content"][indexpath.row]];
    if (_sign == 1) {
        CGRect tmpRect2 = [string2 boundingRectWithSize:CGSizeMake([UIScreen mainScreen].bounds.size.width - 80, 1500) options:NSStringDrawingUsesLineFragmentOrigin attributes:attri context:nil];
        nameH2 = tmpRect2.size.height;
    } else {
        nameH2 = 53.3333;
    }
    return @(nameH1 + nameH2);
}

- (NSNumber *) calculateClickedShortCellHeight:(NSIndexPath *) indexpath andSign:(NSInteger) sign{
    NSDictionary *attri = @{NSFontAttributeName:[UIFont systemFontOfSize:18]};
    CGFloat nameH1 = 0.0, nameH2 = 0.0;
    NSString *string1 = [self->_commentsView.allShortJSONModel.comments valueForKey:@"content"][indexpath.row];
    CGRect tmpRect1 = [string1 boundingRectWithSize:CGSizeMake([UIScreen mainScreen].bounds.size.width - 80, 1500) options:NSStringDrawingUsesLineFragmentOrigin attributes:attri context:nil];
    nameH1 = tmpRect1.size.height + 85;
    
    NSString *string2 = [NSString stringWithFormat:@"//%@:%@",[[self->_commentsView.allShortJSONModel.comments valueForKey:@"reply_to"] valueForKey:@"author"][indexpath.row], [[self->_commentsView.allShortJSONModel.comments valueForKey:@"reply_to"] valueForKey:@"content"][indexpath.row]];
    if (_sign == 1) {
        CGRect tmpRect2 = [string2 boundingRectWithSize:CGSizeMake([UIScreen mainScreen].bounds.size.width - 80, 1500) options:NSStringDrawingUsesLineFragmentOrigin attributes:attri context:nil];
        nameH2 = tmpRect2.size.height;
    } else {
        nameH2 = 53.3333;
    }
    return @(nameH1 + nameH2);
}

- (void) setIsSelectedMutbaleArray {
    NSMutableArray *longArray = [NSMutableArray arrayWithObjects:@"0", @"0", @"0", @"0", @"0", @"0", @"0", @"0", @"0", @"0", @"0", @"0", @"0", @"0", @"0", @"0", @"0", @"0", @"0", @"0", nil];
    NSMutableArray *shortArray = [NSMutableArray arrayWithObjects:@"0", @"0", @"0", @"0", @"0", @"0", @"0", @"0", @"0", @"0", @"0", @"0", @"0", @"0", @"0", @"0", @"0", @"0", @"0", @"0", nil];
    [_isSelectedMutableArray addObject:longArray];
    [_isSelectedMutableArray addObject:shortArray];
    _commentsView.isSelectedMutableArray = [NSMutableArray arrayWithArray:_isSelectedMutableArray];
}

- (void) clickedButton:(UIButton *)button {
    NSIndexPath *myIndex=[_commentsView.tableView indexPathForCell:(ZDICommentsTableViewCell *)[[button superview] superview]];
    
    NSNumber *number = [[NSNumber alloc] init];
    if ([_isSelectedMutableArray[myIndex.section][myIndex.row] isEqualToString:@"0"]) {
        [_isSelectedMutableArray[myIndex.section] replaceObjectAtIndex:myIndex.row withObject:@"1"];
        if (myIndex.section == 0) {
            _sign = 1;
            number = [self calculateClickedLongCellHeight:myIndex andSign:_sign];
        }else {
            _sign = 1;
            number = [self calculateClickedShortCellHeight:myIndex andSign:_sign];
        }
    }else {
        [_isSelectedMutableArray[myIndex.section] replaceObjectAtIndex:myIndex.row withObject:@"0"];
        if (myIndex.section == 0) {
            _sign = 0;
            number = [self calculateClickedLongCellHeight:myIndex andSign:_sign];
        }else {
            _sign = 0;
            number = [self calculateClickedShortCellHeight:myIndex andSign:_sign];
        }
    }
  
    [_allCellHeightMutableArray[myIndex.section] replaceObjectAtIndex:myIndex.row withObject:number];
    [_commentsView.tableView reloadRowsAtIndexPaths:@[myIndex] withRowAnimation:UITableViewRowAnimationNone];
}

@end
