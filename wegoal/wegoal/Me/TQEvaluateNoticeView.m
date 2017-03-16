//
//  TQEvaluateNoticeView.m
//  wegoal
//
//  Created by joker on 2017/3/16.
//  Copyright © 2017年 xdkj. All rights reserved.
//

#import "TQEvaluateNoticeView.h"

@implementation TQEvaluateNoticeView


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        
        [self addSubview:self.pointSignLabel];
        [self addSubview:self.pointLabel];
        [self addSubview:self.unitSignLabel];
        [self addSubview:self.noticeLabel];
        [self addSubview:self.noticeImageView];
    }
    return self;
}

- (UILabel *)pointSignLabel
{
    if (!_pointSignLabel) {
        _pointSignLabel = [[UILabel alloc] init];
        _pointSignLabel.text = @"得分：";
        _pointSignLabel.textColor = kNavTitleColor;
        _pointSignLabel.font = [UIFont systemFontOfSize:10.f];
    }
    return _pointSignLabel;
}

- (UILabel *)pointLabel
{
    if (!_pointLabel) {
        _pointLabel = [[UILabel alloc] init];
        _pointLabel.textColor = kSubjectBackColor;
        _pointLabel.font = [UIFont systemFontOfSize:14.f];
    }
    return _pointLabel;
}

- (UILabel *)unitSignLabel
{
    if (!_unitSignLabel) {
        _unitSignLabel = [[UILabel alloc] init];
        _unitSignLabel.text = @"分";
        _unitSignLabel.textColor = kNavTitleColor;
        _unitSignLabel.font = [UIFont systemFontOfSize:10.f];
    }
    return _unitSignLabel;
}

- (UILabel *)noticeLabel
{
    if (!_noticeLabel) {
        _noticeLabel = [[UILabel alloc] init];
        _noticeLabel.text = @"球员评价：整体平均分不得超过球队平均分";
        _noticeLabel.textColor = kTitleTextColor;
        _noticeLabel.font = [UIFont systemFontOfSize:10.f];
    }
    return _noticeLabel;
}

- (UIImageView *)noticeImageView
{
    if (!_noticeImageView) {
        _noticeImageView = [[UIImageView alloc] init];
        _noticeImageView.image = [UIImage imageNamed:@"point_rules"];
    }
    return _noticeImageView;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    //得分
    [_pointSignLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).with.offset(10);
        make.centerY.equalTo(self.mas_centerY);
    }];
    
    //分数
    [_pointLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_pointSignLabel.mas_right).with.offset(2);
        make.centerY.equalTo(self.mas_centerY);
    }];
    
    //单位
    [_unitSignLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_pointLabel.mas_right).with.offset(2);
        make.centerY.equalTo(self.mas_centerY);
    }];
    
    //提示
    [_noticeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.mas_right).with.offset(-10);
        make.centerY.equalTo(self.mas_centerY);
    }];
    
    //提示标志
    [_noticeImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(_noticeLabel.mas_left).with.offset(-3);
        make.centerY.equalTo(self.mas_centerY);
    }];
    
}

@end
