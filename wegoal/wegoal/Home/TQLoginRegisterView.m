//
//  TQLoginRegisterView.m
//  wegoal
//
//  Created by joker on 2017/3/31.
//  Copyright © 2017年 xdkj. All rights reserved.
//

#import "TQLoginRegisterView.h"
#import "TQRegisterViewController.h"
#import "TQLoginViewController.h"

@interface TQLoginRegisterView()

@property (nonatomic, strong) UIButton *loginButton;     //登录
@property (nonatomic, strong) UIButton *registerButton;  //注册
@property (nonatomic, strong) UIButton *jumpButton;      //跳过
@property (nonatomic, strong) UILabel *copyrightLbl;     //版权

@end

@implementation TQLoginRegisterView


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.loginButton];
        [self addSubview:self.registerButton];
        [self addSubview:self.jumpButton];
        [self addSubview:self.copyrightLbl];
        [self setSubViewsFrame];
    }
    return self;
}

- (UIButton *)loginButton
{
    if (!_loginButton) {
        _loginButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _loginButton.backgroundColor = kSubjectBackColor;
        [_loginButton setTitle:@"登录" forState:UIControlStateNormal];
        [_loginButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _loginButton.titleLabel.font = [UIFont systemFontOfSize:16.f];
        [_loginButton addTarget:self action:@selector(loginAction) forControlEvents:UIControlEventTouchUpInside];
        _loginButton.layer.masksToBounds = YES;
        _loginButton.layer.cornerRadius = 24;
    }
    return _loginButton;
}

- (UIButton *)registerButton
{
    if (!_registerButton) {
        _registerButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _registerButton.backgroundColor = [UIColor whiteColor];
        [_registerButton setTitle:@"注册" forState:UIControlStateNormal];
        [_registerButton setTitleColor:kSubjectBackColor forState:UIControlStateNormal];
        _registerButton.titleLabel.font = [UIFont systemFontOfSize:16.f];
        [_registerButton addTarget:self action:@selector(registerAction) forControlEvents:UIControlEventTouchUpInside];
        _registerButton.layer.masksToBounds = YES;
        _registerButton.layer.cornerRadius = 24;
        _registerButton.layer.borderWidth = 2;
        _registerButton.layer.borderColor = kSubjectBackColor.CGColor;
    }
    return _registerButton;
}

- (UIButton *)jumpButton
{
    if (!_jumpButton) {
        _jumpButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _jumpButton.backgroundColor = [UIColor clearColor];
        [_jumpButton addTarget:self action:@selector(jumpAction) forControlEvents:UIControlEventTouchUpInside];
        
        NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:@"跳过"];
        NSRange strRange = {0,[str length]};
        [str addAttributes:@{NSUnderlineStyleAttributeName:[NSNumber numberWithInteger:NSUnderlineStyleSingle], NSFontAttributeName:[UIFont systemFontOfSize:12.f], NSForegroundColorAttributeName:kNavTitleColor} range:strRange];
        [_jumpButton setAttributedTitle:str forState:UIControlStateNormal];
    }
    return _jumpButton;
}

- (UILabel *)copyrightLbl
{
    if (!_copyrightLbl) {
        _copyrightLbl = [[UILabel alloc] init];
        _copyrightLbl.textAlignment = NSTextAlignmentCenter;
        _copyrightLbl.textColor = kTitleTextColor;
        _copyrightLbl.font = [UIFont systemFontOfSize:10.f];
        _copyrightLbl.text = @"Copyright © 2016-2017 WeGoal LLC.";
    }
    return _copyrightLbl;
}

- (void)setSubViewsFrame
{
    _copyrightLbl.frame = CGRectMake(0, SCREEN_HEIGHT - 15, SCREEN_WIDTH, 15);
    _jumpButton.frame = CGRectMake((SCREEN_WIDTH - 50)/2, _copyrightLbl.top - 45, 50, 20);
    _registerButton.frame = CGRectMake((SCREEN_WIDTH - 244)/2, _jumpButton.top - 80, 244, 48);
    _loginButton.frame = CGRectMake((SCREEN_WIDTH - 244)/2, _registerButton.top - 64, 244, 48);
}


#pragma mark - events

- (void)loginAction
{
    TQLoginViewController *loginVC = [[TQLoginViewController alloc] init];
    [self.viewController.navigationController pushViewController:loginVC animated:YES];
}

- (void)registerAction
{
    TQRegisterViewController *registerVC = [[TQRegisterViewController alloc] init];
    [self.viewController.navigationController pushViewController:registerVC animated:YES];
}

- (void)jumpAction
{
    //跳过，直接到主界面
    [[NSNotificationCenter defaultCenter] postNotificationName:kWelcomeToHome object:nil userInfo:nil];
}



@end
