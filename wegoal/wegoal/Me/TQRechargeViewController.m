//
//  TQRechargeViewController.m
//  wegoal
//
//  Created by joker on 2017/4/21.
//  Copyright © 2017年 xdkj. All rights reserved.
//

#import "TQRechargeViewController.h"
#import "TQPayTypeSelectView.h"
#import "TQAmountSelectView.h"

@interface TQRechargeViewController ()
{
    NSArray *amountsArray;
}

@property (nonatomic, strong) TQAmountSelectView *amountSelectView;
@property (nonatomic, strong) TQPayTypeSelectView *payTypeView;
@property (nonatomic, strong) UIButton *rechargeBtn;

@property (nonatomic, strong) NSString *amount;
@property (nonatomic, assign) PayType type;

@end

@implementation TQRechargeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = kMainBackColor;
    self.title = @"充值保证金";
    
    amountsArray = @[@"300", @"150", @"100"];
    _amount = @"";
    _type = PayTypeWechat;
    [self.view addSubview:self.amountSelectView];
    [self.view addSubview:self.payTypeView];
    [self.view addSubview:self.rechargeBtn];
}

- (TQAmountSelectView *)amountSelectView
{
    if (!_amountSelectView) {
        _amountSelectView = [[TQAmountSelectView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, kAmountInterval*(amountsArray.count + 3) + kAmountCellHeight * amountsArray.count + 26)];
        _amountSelectView.backgroundColor = kMainBackColor;
        _amountSelectView.amountsArray = amountsArray;
        __weak typeof(self) weakSelf = self;
        _amountSelectView.amountSelectBlock = ^(NSString *amount) {
            weakSelf.amount = amount;
        };
    }
    return _amountSelectView;
}

- (TQPayTypeSelectView *)payTypeView
{
    if (!_payTypeView) {
        _payTypeView = [[TQPayTypeSelectView alloc] initWithFrame:CGRectMake(0, _amountSelectView.bottom + 4, SCREEN_WIDTH, 110)];
        _payTypeView.backgroundColor = kMainBackColor;
        __weak typeof(self) weakSelf = self;
        _payTypeView.payTypeBlock = ^(PayType type) {
            weakSelf.type = type;
        };
    }
    return _payTypeView;
}

- (UIButton *)rechargeBtn
{
    if (!_rechargeBtn) {
        _rechargeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _rechargeBtn.frame = CGRectMake(0, SCREEN_HEIGHT - 44 - 44, SCREEN_WIDTH, 44);
        _rechargeBtn.backgroundColor = kSubjectBackColor;
        [_rechargeBtn setTitle:@"马上充值" forState:UIControlStateNormal];
        [_rechargeBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_rechargeBtn addTarget:self action:@selector(rechargeAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _rechargeBtn;
}


#pragma mark - events

- (void)rechargeAction
{
    NSLog(@"do recharge with amount:%@, type:%ld", _amount, _type);
}


@end







