//
//  TQPayTypeSelectView.m
//  wegoal
//
//  Created by joker on 2017/4/21.
//  Copyright © 2017年 xdkj. All rights reserved.
//

#import "TQPayTypeSelectView.h"

#define kPayTypeButtonBaseTag     89001
@interface TQPayTypeSelectView()

@property (nonatomic, strong) UIView *titleView;
@property (nonatomic, strong) UILabel *titleLbl;
@property (nonatomic, strong) UIView *wechatPayView;
@property (nonatomic, strong) UIImageView *wechatPayImageView;
@property (nonatomic, strong) UILabel *wechatPayLbl;
@property (nonatomic, strong) UIButton *wechatPayBtn;
@property (nonatomic, strong) UIView *alipayView;
@property (nonatomic, strong) UIImageView *alipayImageView;
@property (nonatomic, strong) UILabel *alipayLbl;
@property (nonatomic, strong) UIButton *alipayBtn;

@end

@implementation TQPayTypeSelectView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = kMainBackColor;
        
        [self addSubview:self.titleView];
        [self addSubview:self.wechatPayView];
        [self addSubview:self.alipayView];
    }
    return self;
}

- (UIView *)titleView
{
    if (!_titleView) {
        _titleView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 36)];
        _titleView.backgroundColor = [UIColor whiteColor];
        
        [_titleView addSubview:self.titleLbl];
    }
    return _titleView;
}

- (UILabel *)titleLbl
{
    if (!_titleLbl) {
        _titleLbl = [[UILabel alloc] initWithFrame:CGRectMake(8, 0, SCREEN_WIDTH - 16, 36)];
        _titleLbl.backgroundColor = [UIColor whiteColor];
        _titleLbl.font = [UIFont systemFontOfSize:12.f];
        _titleLbl.textColor = kNavTitleColor;
        _titleLbl.text = @"支付方式";
    }
    return _titleLbl;
}

- (UIView *)wechatPayView
{
    if (!_wechatPayView) {
        _wechatPayView = [[UIView alloc] initWithFrame:CGRectMake(0, _titleView.bottom + 1, SCREEN_WIDTH, 36)];
        _wechatPayView.backgroundColor = [UIColor whiteColor];
        
        [_wechatPayView addSubview:self.wechatPayImageView];
        [_wechatPayView addSubview:self.wechatPayLbl];
        [_wechatPayView addSubview:self.wechatPayBtn];
    }
    return _wechatPayView;
}

- (UIImageView *)wechatPayImageView
{
    if (!_wechatPayImageView) {
        _wechatPayImageView = [[UIImageView alloc] initWithFrame:CGRectMake(8, 10, 16, 16)];
        _wechatPayImageView.image = [UIImage imageNamed:@"wechat_pay"];
    }
    return _wechatPayImageView;
}

- (UILabel *)wechatPayLbl
{
    if (!_wechatPayLbl) {
        _wechatPayLbl = [[UILabel alloc] initWithFrame:CGRectMake(_wechatPayImageView.right + 8, 0, 100, 36)];
        _wechatPayLbl.backgroundColor = [UIColor whiteColor];
        _wechatPayLbl.font = [UIFont systemFontOfSize:12.f];
        _wechatPayLbl.textColor = kNavTitleColor;
        _wechatPayLbl.text = @"微信支付";
    }
    return _wechatPayLbl;
}

- (UIButton *)wechatPayBtn
{
    if (!_wechatPayBtn) {
        _wechatPayBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _wechatPayBtn.frame = CGRectMake(SCREEN_WIDTH - 24, 10, 16, 16);
        [_wechatPayBtn setImage:[UIImage imageNamed:@"select_default"] forState:UIControlStateNormal];
        [_wechatPayBtn setImage:[UIImage imageNamed:@"select_select"] forState:UIControlStateSelected];
        _wechatPayBtn.tag = kPayTypeButtonBaseTag + PayTypeWechat;
        [_wechatPayBtn addTarget:self action:@selector(selectPayType:) forControlEvents:UIControlEventTouchUpInside];
        _wechatPayBtn.selected = YES;
    }
    return _wechatPayBtn;
}

- (UIView *)alipayView
{
    if (!_alipayView) {
        _alipayView = [[UIView alloc] initWithFrame:CGRectMake(0, _wechatPayView.bottom + 1, SCREEN_WIDTH, 36)];
        _alipayView.backgroundColor = [UIColor whiteColor];
        
        [_alipayView addSubview:self.alipayImageView];
        [_alipayView addSubview:self.alipayLbl];
        [_alipayView addSubview:self.alipayBtn];
    }
    return _alipayView;
}

- (UIImageView *)alipayImageView
{
    if (!_alipayImageView) {
        _alipayImageView = [[UIImageView alloc] initWithFrame:CGRectMake(8, 10, 16, 16)];
        _alipayImageView.image = [UIImage imageNamed:@"alipay"];
    }
    return _alipayImageView;
}

- (UILabel *)alipayLbl
{
    if (!_alipayLbl) {
        _alipayLbl = [[UILabel alloc] initWithFrame:CGRectMake(_alipayImageView.right + 8, 0, 100, 36)];
        _alipayLbl.backgroundColor = [UIColor whiteColor];
        _alipayLbl.font = [UIFont systemFontOfSize:12.f];
        _alipayLbl.textColor = kNavTitleColor;
        _alipayLbl.text = @"支付宝支付";
    }
    return _alipayLbl;
}

- (UIButton *)alipayBtn
{
    if (!_alipayBtn) {
        _alipayBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _alipayBtn.frame = CGRectMake(SCREEN_WIDTH - 24, 10, 16, 16);
        [_alipayBtn setImage:[UIImage imageNamed:@"select_default"] forState:UIControlStateNormal];
        [_alipayBtn setImage:[UIImage imageNamed:@"select_select"] forState:UIControlStateSelected];
        _alipayBtn.tag = kPayTypeButtonBaseTag + PayTypeAlipay;
        [_alipayBtn addTarget:self action:@selector(selectPayType:) forControlEvents:UIControlEventTouchUpInside];
        _alipayBtn.selected = NO;
    }
    return _alipayBtn;
}


#pragma mark - events

- (void)selectPayType:(UIButton *)payTypeBtn
{
    _wechatPayBtn.selected = NO;
    _alipayBtn.selected = NO;
    payTypeBtn.selected = YES;
    
    PayType type = payTypeBtn.tag - kPayTypeButtonBaseTag;
    if (_payTypeBlock) {
        _payTypeBlock(type);
    }
}




@end












