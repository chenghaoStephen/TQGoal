//
//  TQMatchDetailBottomView.m
//  wegoal
//
//  Created by joker on 2017/3/15.
//  Copyright © 2017年 xdkj. All rights reserved.
//

#import "TQMatchDetailBottomView.h"

@implementation TQMatchDetailBottomView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        
        [self addSubview:self.totalSignLabel];
        [self addSubview:self.totalPriceLabel];
        [self addSubview:self.drawBackButton];
        [self addSubview:self.payButton];
    }
    return self;
}

- (UILabel *)totalSignLabel
{
    if (!_totalSignLabel) {
        _totalSignLabel = [[UILabel alloc] init];
        _totalSignLabel.text = @"合计：";
        _totalSignLabel.textColor = kNavTitleColor;
        _totalSignLabel.font = [UIFont systemFontOfSize:10.f];
    }
    return _totalSignLabel;
}

- (UILabel *)totalPriceLabel
{
    if (!_totalPriceLabel) {
        _totalPriceLabel = [[UILabel alloc] init];
        _totalPriceLabel.textColor = kNavTitleColor;
        _totalPriceLabel.font = [UIFont systemFontOfSize:14.f];
    }
    return _totalPriceLabel;
}

- (UIButton *)drawBackButton
{
    if (!_drawBackButton) {
        _drawBackButton = [UIButton buttonWithType:UIButtonTypeCustom];
        NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:@"退款条约"];
        NSRange strRange = {0,[str length]};
        [str addAttributes:@{NSUnderlineStyleAttributeName:[NSNumber numberWithInteger:NSUnderlineStyleSingle], NSFontAttributeName:[UIFont systemFontOfSize:10.f], NSForegroundColorAttributeName:kTitleTextColor} range:strRange];
        [_drawBackButton setAttributedTitle:str forState:UIControlStateNormal];
    }
    return _drawBackButton;
}

- (UIButton *)payButton
{
    if (!_payButton) {
        _payButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_payButton setTitle:@"立即支付" forState:UIControlStateNormal];
        _payButton.titleLabel.font = [UIFont systemFontOfSize:12.f];
        [_payButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_payButton setBackgroundColor:kRedBackColor];
        
    }
    return _payButton;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    //合计
    [_totalSignLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).with.offset(10);
        make.centerY.equalTo(self.mas_centerY);
    }];
    
    //费用
    [_totalPriceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_totalSignLabel.mas_right);
        make.centerY.equalTo(self.mas_centerY);
    }];
    
    //退款条约
    [_drawBackButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_totalPriceLabel.mas_right).with.offset(10);
        make.centerY.equalTo(self.mas_centerY);
    }];
    
    //立即支付
    [_payButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_top);
        make.bottom.equalTo(self.mas_bottom);
        make.right.equalTo(self.mas_right);
        make.width.mas_equalTo(90);
    }];
    
}


@end





