//
//  ZDITableViewSectionView.m
//  iOS知乎日报
//
//  Created by 涂强尧 on 2018/11/5.
//  Copyright © 2018 涂强尧. All rights reserved.
//

#import "ZDITableViewSectionView.h"

@implementation ZDITableViewSectionView

- (instancetype) initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor colorWithRed:0.02f green:0.56f blue:0.84f alpha:1.00f];
        _sectionLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        _sectionLabel.textColor = [UIColor whiteColor];
        _sectionLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:_sectionLabel];
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
