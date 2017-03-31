//
//  TQLoginViewController.m
//  wegoal
//
//  Created by joker on 2017/3/31.
//  Copyright © 2017年 xdkj. All rights reserved.
//

#import "TQLoginViewController.h"
#import "TQRegisterViewController.h"

@interface TQLoginViewController ()<UITextFieldDelegate, UITextViewDelegate>

@property (nonatomic, strong) UILabel *phoneLabel;              //手机号
@property (nonatomic, strong) UILabel *passwordLabel;           //密码
@property (nonatomic, strong) UIButton *phoneDeleteButton;      //手机号清空
@property (nonatomic, strong) UIButton *passwordDeleteButton;   //密码清空
@property (nonatomic, strong) UITextField *phoneTextField;      //手机号输入
@property (nonatomic, strong) UITextField *passwordTextField;   //密码输入
@property (nonatomic, strong) UIButton *registerButton;         //注册按钮
@property (nonatomic, strong) UITextView *noticeView;           //提示信息
@property (nonatomic, strong) UIImageView *breakLine;           //分割线
@property (nonatomic, strong) UILabel *thirdLoginLabel;         //第三方登录
@property (nonatomic, strong) UIButton *wechatLoginButton;      //微信登录
@property (nonatomic, strong) UIButton *qqLoginButton;          //qq登录

@end

@implementation TQLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.phoneLabel];
    [self.view addSubview:self.passwordLabel];
    [self.view addSubview:self.phoneDeleteButton];
    [self.view addSubview:self.passwordDeleteButton];
    [self.view addSubview:self.phoneTextField];
    [self.view addSubview:self.passwordTextField];
    [self.view addSubview:self.registerButton];
    [self.view addSubview:self.noticeView];
    [self.view addSubview:self.breakLine];
    [self.view addSubview:self.thirdLoginLabel];
    [self.view addSubview:self.wechatLoginButton];
    [self.view addSubview:self.qqLoginButton];
}

- (UIBarButtonItem*)buildRightNavigationItem{
    UIButton *toRegisterBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    toRegisterBtn.frame = CGRectMake(0, 0, 100, 44);
    [toRegisterBtn addTarget:self action:@selector(gotoRegister) forControlEvents:UIControlEventTouchUpInside];
    [toRegisterBtn setTitle:@"新用户，去注册" forState:UIControlStateNormal];
    [toRegisterBtn setTitleColor:kNavTitleColor forState:UIControlStateNormal];
    toRegisterBtn.titleLabel.font = [UIFont systemFontOfSize:12.f];
    UIBarButtonItem *toRegisterBarBtn = [[UIBarButtonItem alloc] initWithCustomView:toRegisterBtn];
    return toRegisterBarBtn;
}


#pragma mark - subViews

- (UILabel *)phoneLabel
{
    if (!_phoneLabel) {
        _phoneLabel = [[UILabel alloc] initWithFrame:CGRectMake((SCREEN_WIDTH - 244)/2, 36, 244, 48)];
        _phoneLabel.textAlignment = NSTextAlignmentCenter;
        _phoneLabel.backgroundColor = kInputBackColor;
        _phoneLabel.font = [UIFont systemFontOfSize:16.f];
        _phoneLabel.textColor = kTitleTextColor;
        _phoneLabel.text = @"手机";
        _phoneLabel.layer.masksToBounds = YES;
        _phoneLabel.layer.cornerRadius = 24;
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(editPhone)];
        [_phoneLabel addGestureRecognizer:tapGesture];
    }
    return _phoneLabel;
}

- (UILabel *)passwordLabel
{
    if (!_passwordLabel) {
        _passwordLabel = [[UILabel alloc] initWithFrame:CGRectMake((SCREEN_WIDTH - 244)/2, _phoneLabel.bottom + 16, 244, 48)];
        _passwordLabel.textAlignment = NSTextAlignmentCenter;
        _passwordLabel.backgroundColor = kInputBackColor;
        _passwordLabel.font = [UIFont systemFontOfSize:16.f];
        _passwordLabel.textColor = kTitleTextColor;
        _passwordLabel.text = @"密码";
        _passwordLabel.layer.masksToBounds = YES;
        _passwordLabel.layer.cornerRadius = 24;
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(editPassword)];
        [_passwordLabel addGestureRecognizer:tapGesture];
    }
    return _passwordLabel;
}

- (UIButton *)phoneDeleteButton
{
    if (!_phoneDeleteButton) {
        _phoneDeleteButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _phoneDeleteButton.frame = CGRectMake(_phoneLabel.right - 32, _phoneLabel.top + (_phoneLabel.height - 16)/2, 16, 16);
        [_phoneDeleteButton setImage:[UIImage imageNamed:@"login_delete"] forState:UIControlStateNormal];
        [_phoneDeleteButton addTarget:self action:@selector(clearPhone) forControlEvents:UIControlEventTouchUpInside];
        _phoneDeleteButton.hidden = YES;
    }
    return _phoneDeleteButton;
}

- (UIButton *)passwordDeleteButton
{
    if (!_passwordDeleteButton) {
        _passwordDeleteButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _passwordDeleteButton.frame = CGRectMake(_passwordLabel.right - 32, _passwordLabel.top + (_passwordLabel.height - 16)/2, 16, 16);
        [_passwordDeleteButton setImage:[UIImage imageNamed:@"login_delete"] forState:UIControlStateNormal];
        [_passwordDeleteButton addTarget:self action:@selector(clearPassword) forControlEvents:UIControlEventTouchUpInside];
        _passwordDeleteButton.hidden = YES;
    }
    return _passwordDeleteButton;
}

- (UITextField *)phoneTextField
{
    if (!_phoneTextField) {
        _phoneTextField = [[UITextField alloc] init];
        _phoneTextField.delegate = self;
    }
    return _phoneTextField;
}

- (UITextField *)passwordTextField
{
    if (!_passwordTextField) {
        _passwordTextField = [[UITextField alloc] init];
        _passwordTextField.delegate = self;
    }
    return _passwordTextField;
}

- (UIButton *)registerButton
{
    if (!_registerButton) {
        _registerButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _registerButton.frame = CGRectMake((SCREEN_WIDTH - 244)/2, _passwordLabel.bottom + 16, 244, 48);
        _registerButton.backgroundColor = kSubTextColor;
        [_registerButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_registerButton setTitle:@"注册" forState:UIControlStateNormal];
        _registerButton.titleLabel.font = [UIFont systemFontOfSize:16.f];
        _registerButton.layer.masksToBounds = YES;
        _registerButton.layer.cornerRadius = 24;
        _registerButton.enabled = NO;
        [_registerButton addTarget:self action:@selector(doRegister) forControlEvents:UIControlEventTouchUpInside];
    }
    return _registerButton;
}

- (UITextView *)noticeView
{
    if (!_noticeView) {
        _noticeView = [[UITextView alloc] initWithFrame:CGRectMake((SCREEN_WIDTH- 250)/2, _registerButton.bottom + 15, 250, 15)];
        _noticeView.backgroundColor = [UIColor clearColor];
        _noticeView.delegate = self;
        _noticeView.editable = NO;
        _noticeView.font = [UIFont systemFontOfSize:10.f];
        _noticeView.textColor = kTitleTextColor;
        _noticeView.tintColor = kNavTitleColor;
        _noticeView.contentInset = UIEdgeInsetsZero;
        _noticeView.textContainer.lineFragmentPadding = 0;
        _noticeView.textContainerInset = UIEdgeInsetsZero;
        _noticeView.scrollEnabled = NO;
        _noticeView.text = @"使用WeGoal,就表示您同意WeGoal的使用条款和隐私政策";
    }
    return _noticeView;
}

- (UIImageView *)breakLine
{
    if (!_breakLine) {
        _breakLine = [[UIImageView alloc] initWithFrame:CGRectMake((SCREEN_WIDTH - 244)/2, _noticeView.bottom + 32, 244, 1)];
        _breakLine.backgroundColor = kTitleTextColor;
    }
    return _breakLine;
}

- (UILabel *)thirdLoginLabel
{
    if (!_thirdLoginLabel) {
        _thirdLoginLabel = [[UILabel alloc] initWithFrame:CGRectMake((SCREEN_WIDTH - 83)/2, _noticeView.bottom + 25, 83, 15)];
        _thirdLoginLabel.textColor = kTitleTextColor;
        _thirdLoginLabel.font = [UIFont systemFontOfSize:10.f];
        _thirdLoginLabel.text = @"第三方账号登录";
        _thirdLoginLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _thirdLoginLabel;
}

- (UIButton *)wechatLoginButton
{
    if (!_wechatLoginButton) {
        _wechatLoginButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _wechatLoginButton.frame = CGRectMake((SCREEN_WIDTH - 94*2)/3, _breakLine.bottom + 25, 94, 32);
        [_wechatLoginButton setImage:[UIImage imageNamed:@"wechat_login"] forState:UIControlStateNormal];
        [_wechatLoginButton setTitle:@"   微信" forState:UIControlStateNormal];
        [_wechatLoginButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _wechatLoginButton.titleLabel.font = [UIFont systemFontOfSize:12.f];
        _wechatLoginButton.backgroundColor = kWechatColor;
        _wechatLoginButton.layer.masksToBounds = YES;
        _wechatLoginButton.layer.cornerRadius = 16;
        [_wechatLoginButton addTarget:self action:@selector(wechatLogin) forControlEvents:UIControlEventTouchUpInside];
    }
    return _wechatLoginButton;
}

- (UIButton *)qqLoginButton
{
    if (!_qqLoginButton) {
        _qqLoginButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _qqLoginButton.frame = CGRectMake(_wechatLoginButton.right + (SCREEN_WIDTH - 94*2)/3, _breakLine.bottom + 25, 94, 32);
        [_qqLoginButton setImage:[UIImage imageNamed:@"qq_login"] forState:UIControlStateNormal];
        [_qqLoginButton setTitle:@"   QQ" forState:UIControlStateNormal];
        [_qqLoginButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _qqLoginButton.titleLabel.font = [UIFont systemFontOfSize:12.f];
        _qqLoginButton.backgroundColor = kQQColor;
        _qqLoginButton.layer.masksToBounds = YES;
        _qqLoginButton.layer.cornerRadius = 16;
        [_qqLoginButton addTarget:self action:@selector(qqLogin) forControlEvents:UIControlEventTouchUpInside];
    }
    return _qqLoginButton;
}


#pragma mark - events

- (void)gotoRegister
{
    for (UIViewController *vc in self.navigationController.viewControllers) {
        if ([vc isKindOfClass:[TQRegisterViewController class]]) {
            [self.navigationController popToViewController:vc animated:YES];
            return;
        }
    }
    
    TQRegisterViewController *registerVC = [[TQRegisterViewController alloc] init];
    [self.navigationController pushViewController:registerVC animated:YES];
}

- (void)editPhone
{
    
}

- (void)editPassword
{
    
}

- (void)clearPhone
{
    
}

- (void)clearPassword
{
    
}

- (void)doRegister
{
    
}

- (void)wechatLogin
{
    
}

- (void)qqLogin
{
    
}


#pragma mark - UITextField Delegate





#pragma mark - UITextView Delegate




@end
