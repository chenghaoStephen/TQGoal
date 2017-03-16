//
//  TQEvaluateMemberBottomView.m
//  wegoal
//
//  Created by joker on 2017/3/16.
//  Copyright © 2017年 xdkj. All rights reserved.
//

#import "TQEvaluateMemberBottomView.h"

@implementation TQEvaluateMemberBottomView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        
        [self addSubview:self.averageSignLabel];
        [self addSubview:self.averageLabel];
        [self addSubview:self.unitSignLabel];
        [self addSubview:self.nextStepButton];
    }
    return self;
}

- (UILabel *)averageSignLabel
{
    if (!_averageSignLabel) {
        _averageSignLabel = [[UILabel alloc] init];
        _averageSignLabel.text = @"当前平均分：";
        _averageSignLabel.textColor = kNavTitleColor;
        _averageSignLabel.font = [UIFont systemFontOfSize:10.f];
    }
    return _averageSignLabel;
}

- (UILabel *)averageLabel
{
    if (!_averageLabel) {
        _averageLabel = [[UILabel alloc] init];
        _averageLabel.textColor = kSubjectBackColor;
        _averageLabel.font = [UIFont systemFontOfSize:14.f];
    }
    return _averageLabel;
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

- (UIButton *)nextStepButton
{
    if (!_nextStepButton) {
        _nextStepButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_nextStepButton setTitle:@"下一步" forState:UIControlStateNormal];
        _nextStepButton.titleLabel.font = [UIFont systemFontOfSize:12.f];
        [_nextStepButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_nextStepButton setBackgroundColor:kSubjectBackColor];
        [_nextStepButton addTarget:self action:@selector(nextStepAction) forControlEvents:UIControlEventTouchUpInside];
        
    }
    return _nextStepButton;
}

- (void)nextStepAction
{
    if (_nextStepBlk) {
        _nextStepBlk();
    }
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    //当前平均分
    [_averageSignLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).with.offset(15);
        make.centerY.equalTo(self.mas_centerY);
    }];
    
    //分数
    [_averageLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_averageSignLabel.mas_right).with.offset(2);
        make.centerY.equalTo(self.mas_centerY);
    }];
    
    //单位
    [_unitSignLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_averageLabel.mas_right).with.offset(2);
        make.centerY.equalTo(self.mas_centerY);
    }];
    
    //下一步
    [_nextStepButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_top);
        make.bottom.equalTo(self.mas_bottom);
        make.right.equalTo(self.mas_right);
        make.width.mas_equalTo(120);
    }];
    
}

@end
