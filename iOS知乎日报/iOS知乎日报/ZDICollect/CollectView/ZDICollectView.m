//
//  ZDICollectView.m
//  iOS知乎日报
//
//  Created by 涂强尧 on 2018/12/11.
//  Copyright © 2018 涂强尧. All rights reserved.
//

#import "ZDICollectView.h"
#import <UIImageView+WebCache.h>

@implementation ZDICollectView

- (void) collectViewInit {
    _collectTableView = [[UITableView alloc] initWithFrame:[UIScreen mainScreen].bounds style:UITableViewStylePlain];
    _collectTableView.dataSource = self;
    _collectTableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    
    [_collectTableView registerClass:[ZDIHomePageTableViewCell class] forCellReuseIdentifier:@"pictureCell"];
    [self addSubview:_collectTableView];

}

- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [_collectMutableArray count];
}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ZDIHomePageTableViewCell *cell = nil;
    if (cell == nil) {
        cell = [_collectTableView dequeueReusableCellWithIdentifier:@"pictureCell" forIndexPath:indexPath];
    }
    cell.titleLabel.text = _collectMutableArray[indexPath.row][1];
    [cell.titleImageView sd_setImageWithURL:_collectMutableArray[indexPath.row][2]];

    return cell;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
