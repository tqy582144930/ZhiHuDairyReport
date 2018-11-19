//
//  ZDICommentsTableViewCell.m
//  iOS知乎日报
//
//  Created by 涂强尧 on 2018/11/19.
//  Copyright © 2018 涂强尧. All rights reserved.
//

#import "ZDICommentsTableViewCell.h"
#import <Masonry.h>

@implementation ZDICommentsTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _nameLabel = [[UILabel alloc] init];
        _nameLabel.numberOfLines = 0;
        _nameLabel.font = [UIFont systemFontOfSize:17];
        _nameLabel.backgroundColor = [UIColor blackColor];
        [self.contentView addSubview:_nameLabel];
        [_nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(15);
            make.left.mas_equalTo(60);
            make.size.mas_equalTo(CGSizeMake(100, 40));
        }];
        
        _headImageView = [[UIImageView alloc] init];
        _headImageView.layer.masksToBounds=YES;
        _headImageView.layer.cornerRadius = 20;
        _headImageView.backgroundColor = [UIColor blackColor];
        [self addSubview:_headImageView];
        [_headImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(15);
            make.left.mas_equalTo(15);
            make.size.mas_equalTo(CGSizeMake(40, 40));
        }];
        
        _zanButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _zanButton.backgroundColor = [UIColor blackColor];
        [_zanButton setImage:[UIImage imageNamed:@"zan"] forState:UIControlStateNormal];
        [self addSubview:_zanButton];
        [_zanButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(15);
            make.right.mas_equalTo(-15);
            make.size.mas_equalTo(CGSizeMake(20, 20));
        }];
        
        _pinglinTextView = [[UITextView alloc] init];
        _pinglinTextView.backgroundColor = [UIColor blackColor];
        [self addSubview:_pinglinTextView];
        [_pinglinTextView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(55);
            make.left.mas_equalTo(60);
            make.size.mas_equalTo(CGSizeMake(340, 100));
        }];
        
        _timeLabel = [[UILabel alloc] init];
        _timeLabel.numberOfLines = 0;
        _timeLabel.font = [UIFont systemFontOfSize:17];
        _timeLabel.backgroundColor = [UIColor blackColor];
        [self.contentView addSubview:_timeLabel];
        [_timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.mas_equalTo(-15);
            make.left.mas_equalTo(60);
            make.size.mas_equalTo(CGSizeMake(100, 40));
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
