//
//  TQYHomePageTableViewCell.m
//  iOS知乎日报
//
//  Created by 涂强尧 on 2018/10/22.
//  Copyright © 2018 涂强尧. All rights reserved.
//

#import "TQYHomePageTableViewCell.h"
#import <Masonry.h>

@implementation TQYHomePageTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.numberOfLines = 0;
        _titleLabel.font = [UIFont systemFontOfSize:15];
        [self.contentView addSubview:_titleLabel];
        [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(15);
            make.left.mas_equalTo(20);
            make.right.mas_equalTo(-95);
        }];
        
        _titleImageView = [[UIImageView alloc] init];
        [self.contentView addSubview:_titleImageView];
        [_titleImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(15);
            make.right.mas_equalTo(-20);
            make.size.mas_equalTo(CGSizeMake(70, 60));
        }];
    }
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
