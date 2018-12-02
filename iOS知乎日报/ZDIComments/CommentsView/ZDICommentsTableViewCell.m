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
        _nameLabel.font = [UIFont systemFontOfSize:15];
        [self.contentView addSubview:_nameLabel];
        [_nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(20);
            make.left.mas_equalTo(65);
            make.size.mas_equalTo(CGSizeMake(300, 20));
        }];
        
        _headImageView = [[UIImageView alloc] init];
        _headImageView.layer.masksToBounds=YES;
        _headImageView.layer.cornerRadius = 20;
        [self.contentView addSubview:_headImageView];
        [_headImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(15);
            make.left.mas_equalTo(15);
            make.size.mas_equalTo(CGSizeMake(40, 40));
        }];
        
        _zanButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_zanButton setImage:[UIImage imageNamed:@"zan1"] forState:UIControlStateNormal];
        _zanButton.tintColor = [UIColor blackColor];
        [_zanButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        
        [self.contentView addSubview:_zanButton];
        [_zanButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(15);
            make.right.mas_equalTo(-15);
            make.size.mas_equalTo(CGSizeMake(40, 20));
        }];
        
        _pinglinTextLabel = [[UILabel alloc] init];
        [self.contentView addSubview:_pinglinTextLabel];
        _pinglinTextLabel.numberOfLines = 0;
        _pinglinTextLabel.font = [UIFont systemFontOfSize:18];
        [_pinglinTextLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(45);
            make.left.mas_equalTo(65);
            make.right.mas_equalTo(-15);

        }];
        
        _replyLabel = [[UILabel alloc] init];
        [self.contentView addSubview:_replyLabel];
        _replyLabel.numberOfLines = 2;
        _replyLabel.font = [UIFont systemFontOfSize:18];
        _replyLabel.textColor = [UIColor grayColor];
        [_replyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.pinglinTextLabel.mas_bottom).mas_equalTo(5);
            make.left.mas_equalTo(65);
            make.right.mas_equalTo(-15);
        }];
        
        _timeLabel = [[UILabel alloc] init];
        _timeLabel.numberOfLines = 0;
        _timeLabel.font = [UIFont systemFontOfSize:15];
        [self.contentView addSubview:_timeLabel];
        [_timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self->_replyLabel.mas_bottom).mas_equalTo(10);
            make.left.mas_equalTo(65);
            make.height.mas_equalTo(20);
            make.width.mas_equalTo(100);
        }];
        
        _unfoldButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_unfoldButton setTitle:@"展开" forState:UIControlStateNormal];
        [_unfoldButton setTitle:@"收起" forState:UIControlStateSelected];
        _unfoldButton.backgroundColor = [UIColor colorWithRed:0.85f green:0.89f blue:0.95f alpha:1.00f];
        [_unfoldButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [_unfoldButton setTitleColor:[UIColor grayColor] forState:UIControlStateSelected];
        [self.contentView addSubview:_unfoldButton];
        [_unfoldButton addTarget:self action:@selector(unfoldButton:) forControlEvents:UIControlEventTouchUpInside];
        [_unfoldButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self->_replyLabel.mas_bottom).mas_equalTo(10);
            make.right.mas_equalTo(-15);
            make.size.mas_equalTo(CGSizeMake(60, 20));
        }];
        
    }
    return self;
}

- (void) unfoldButton:(UIButton *)button {
    button.selected = !button.selected;
    if (button.selected) {
        _replyLabel.numberOfLines = 0;
        _sign = 1;
    } else {
        _replyLabel.numberOfLines = 2;
        _sign = 0;
    }
    [[NSNotificationCenter defaultCenter] postNotificationName:@"sendSign" object:@(_sign)];
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
