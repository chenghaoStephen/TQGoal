//
//  TQLoginViewController.m
//  wegoal
//
//  Created by joker on 2017/3/31.
//  Copyright © 2017年 xdkj. All rights reserved.
//

#import "TQLoginViewController.h"
#import "TQRegisterViewController.h"
#import "TQForgetPasswordViewController.h"

@interface TQLoginViewController ()<UITextFieldDelegate>

//@property (nonatomic, strong) UILabel *phoneLabel;              //手机号
//@property (nonatomic, strong) UILabel *passwordLabel;           //密码
//@property (nonatomic, strong) UIButton *phoneDeleteButton;      //手机号清空
//@property (nonatomic, strong) UIButton *passwordDeleteButton;   //密码清空
@property (nonatomic, strong) UITextField *phoneTextField;      //手机号输入
@property (nonatomic, strong) UITextField *passwordTextField;   //密码输入
@property (nonatomic, strong) UIButton *loginButton;            //登录按钮
@property (nonatomic, strong) UIButton *forgetButton;           //忘记密码
@property (nonatomic, strong) UIImageView *breakLine;           //分割线
@property (nonatomic, strong) UILabel *thirdLoginLabel;         //第三方登录
@property (nonatomic, strong) UIButton *wechatLoginButton;      //微信登录
@property (nonatomic, strong) UIButton *qqLoginButton;          //qq登录

@end

@implementation TQLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
//    [self.view addSubview:self.phoneLabel];
//    [self.view addSubview:self.passwordLabel];
//    [self.view addSubview:self.phoneDeleteButton];
//    [self.view addSubview:self.passwordDeleteButton];
    [self.view addSubview:self.phoneTextField];
    [self.view addSubview:self.passwordTextField];
    [self.view addSubview:self.loginButton];
    [self.view addSubview:self.forgetButton];
    [self.view addSubview:self.breakLine];
    [self.view addSubview:self.thirdLoginLabel];
    [self.view addSubview:self.wechatLoginButton];
    [self.view addSubview:self.qqLoginButton];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(textFieldDidChanged)
                                                 name:UITextFieldTextDidChangeNotification
                                               object:nil];
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
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

//- (UILabel *)phoneLabel
//{
//    if (!_phoneLabel) {
//        _phoneLabel = [[UILabel alloc] initWithFrame:CGRectMake((SCREEN_WIDTH - 244)/2, 36, 244, 48)];
//        _phoneLabel.textAlignment = NSTextAlignmentCenter;
//        _phoneLabel.backgroundColor = kInputBackColor;
////        _phoneLabel.font = [UIFont systemFontOfSize:16.f];
//        _phoneLabel.font = [UIFont fontWithName:@"Arial" size:15.0];
//        _phoneLabel.textColor = kTitleTextColor;
//        _phoneLabel.text = @"手机";
//        _phoneLabel.layer.masksToBounds = YES;
//        _phoneLabel.layer.cornerRadius = 24;
//        _phoneLabel.userInteractionEnabled = YES;
//        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(editPhone)];
//        [_phoneLabel addGestureRecognizer:tapGesture];
//    }
//    return _phoneLabel;
//}
//
//- (UILabel *)passwordLabel
//{
//    if (!_passwordLabel) {
//        _passwordLabel = [[UILabel alloc] initWithFrame:CGRectMake((SCREEN_WIDTH - 244)/2, _phoneLabel.bottom + 16, 244, 48)];
//        _passwordLabel.textAlignment = NSTextAlignmentCenter;
//        _passwordLabel.backgroundColor = kInputBackColor;
////        _passwordLabel.font = [UIFont systemFontOfSize:16.f];
//        _passwordLabel.font = [UIFont fontWithName:@"Arial" size:15.0];
//        _passwordLabel.textColor = kTitleTextColor;
//        _passwordLabel.text = @"密码";
//        _passwordLabel.layer.masksToBounds = YES;
//        _passwordLabel.layer.cornerRadius = 24;
//        _passwordLabel.userInteractionEnabled = YES;
//        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(editPassword)];
//        [_passwordLabel addGestureRecognizer:tapGesture];
//    }
//    return _passwordLabel;
//}
//
//- (UIButton *)phoneDeleteButton
//{
//    if (!_phoneDeleteButton) {
//        _phoneDeleteButton = [UIButton buttonWithType:UIButtonTypeCustom];
//        _phoneDeleteButton.frame = CGRectMake(_phoneLabel.right - 32, _phoneLabel.top + (_phoneLabel.height - 16)/2, 16, 16);
//        [_phoneDeleteButton setImage:[UIImage imageNamed:@"login_delete"] forState:UIControlStateNormal];
//        [_phoneDeleteButton addTarget:self action:@selector(clearPhone) forControlEvents:UIControlEventTouchUpInside];
//        _phoneDeleteButton.hidden = YES;
//    }
//    return _phoneDeleteButton;
//}
//
//- (UIButton *)passwordDeleteButton
//{
//    if (!_passwordDeleteButton) {
//        _passwordDeleteButton = [UIButton buttonWithType:UIButtonTypeCustom];
//        _passwordDeleteButton.frame = CGRectMake(_passwordLabel.right - 32, _passwordLabel.top + (_passwordLabel.height - 16)/2, 16, 16);
//        [_passwordDeleteButton setImage:[UIImage imageNamed:@"login_delete"] forState:UIControlStateNormal];
//        [_passwordDeleteButton addTarget:self action:@selector(clearPassword) forControlEvents:UIControlEventTouchUpInside];
//        _passwordDeleteButton.hidden = YES;
//    }
//    return _passwordDeleteButton;
//}

- (UITextField *)phoneTextField
{
    if (!_phoneTextField) {
        _phoneTextField = [[UITextField alloc] initWithFrame:CGRectMake((SCREEN_WIDTH - 244)/2, 36, 244, 48)];
        _phoneTextField.delegate = self;
        _phoneTextField.keyboardType = UIKeyboardTypeNumberPad;
        _phoneTextField.borderStyle = UITextBorderStyleNone;
        _phoneTextField.textAlignment = NSTextAlignmentCenter;
        _phoneTextField.backgroundColor = kInputBackColor;
        _phoneTextField.font = [UIFont fontWithName:@"Arial" size:16.0];
        _phoneTextField.textColor = kTitleTextColor;
        _phoneTextField.placeholder = @"手机";
        _phoneTextField.layer.masksToBounds = YES;
        _phoneTextField.layer.cornerRadius = 24;
        _phoneTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
    }
    return _phoneTextField;
}

- (UITextField *)passwordTextField
{
    if (!_passwordTextField) {
        _passwordTextField = [[UITextField alloc] initWithFrame:CGRectMake((SCREEN_WIDTH - 244)/2, _phoneTextField.bottom + 16, 244, 48)];
        _passwordTextField.delegate = self;
        _passwordTextField.borderStyle = UITextBorderStyleNone;
        _passwordTextField.textAlignment = NSTextAlignmentCenter;
        _passwordTextField.backgroundColor = kInputBackColor;
        _passwordTextField.font = [UIFont fontWithName:@"Arial" size:16.0];
        _passwordTextField.textColor = kTitleTextColor;
        _passwordTextField.placeholder = @"密码";
        _passwordTextField.secureTextEntry = YES;
        _passwordTextField.layer.masksToBounds = YES;
        _passwordTextField.layer.cornerRadius = 24;
        _passwordTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
    }
    return _passwordTextField;
}

- (UIButton *)loginButton
{
    if (!_loginButton) {
        _loginButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _loginButton.frame = CGRectMake((SCREEN_WIDTH - 244)/2, _passwordTextField.bottom + 16, 244, 48);
        _loginButton.backgroundColor = kSubTextColor;
        [_loginButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_loginButton setTitle:@"登录" forState:UIControlStateNormal];
        _loginButton.titleLabel.font = [UIFont fontWithName:@"Arial" size:16.0];
        _loginButton.layer.masksToBounds = YES;
        _loginButton.layer.cornerRadius = 24;
        _loginButton.enabled = NO;
        [_loginButton addTarget:self action:@selector(doLogin) forControlEvents:UIControlEventTouchUpInside];
    }
    return _loginButton;
}

- (UIButton *)forgetButton
{
    if (!_forgetButton) {
        _forgetButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _forgetButton.frame = CGRectMake((SCREEN_WIDTH - 60)/2, _loginButton.bottom + 8, 60, 30);
        [_forgetButton setTitleColor:kNavTitleColor forState:UIControlStateNormal];
        [_forgetButton setTitle:@"忘记密码" forState:UIControlStateNormal];
        _forgetButton.titleLabel.font = [UIFont systemFontOfSize:12.f];
        [_forgetButton addTarget:self action:@selector(doForget) forControlEvents:UIControlEventTouchUpInside];
    }
    return _forgetButton;
}

- (UIImageView *)breakLine
{
    if (!_breakLine) {
        _breakLine = [[UIImageView alloc] initWithFrame:CGRectMake((SCREEN_WIDTH - 244)/2, _forgetButton.bottom + 25, 244, 1)];
        _breakLine.backgroundColor = kTitleTextColor;
    }
    return _breakLine;
}

- (UILabel *)thirdLoginLabel
{
    if (!_thirdLoginLabel) {
        _thirdLoginLabel = [[UILabel alloc] initWithFrame:CGRectMake((SCREEN_WIDTH - 83)/2, _forgetButton.bottom + 18, 83, 15)];
        _thirdLoginLabel.backgroundColor = [UIColor whiteColor];
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
    registerVC.originVC = _originVC;
    [self.navigationController pushViewController:registerVC animated:YES];
}

- (void)editPhone
{
    [_phoneTextField becomeFirstResponder];
}

- (void)editPassword
{
    [_passwordTextField becomeFirstResponder];
}

//- (void)clearPhone
//{
//    _phoneTextField.text = @"";
//    _phoneLabel.textColor = kTitleTextColor;
//    _phoneLabel.text = @"手机";
//    _phoneDeleteButton.hidden = YES;
//    [self updateLoginButtonStatus];
//}
//
//- (void)clearPassword
//{
//    _passwordTextField.text = @"";
//    _passwordLabel.textColor = kTitleTextColor;
//    _passwordLabel.text = @"密码";
//    _passwordDeleteButton.hidden = YES;
//    [self updateLoginButtonStatus];
//}

- (void)doLogin
{
    [self endEdit];
    
    __weak typeof(self) weakSelf = self;
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"userName"] = _phoneTextField.text;
    params[@"password"] = _passwordTextField.text;
    [ZDMIndicatorView showInView:self.view];
    [[AFServer sharedInstance]GET:URL(kTQDomainURL, kAccountLogin) parameters:params finishBlock:^(id result) {
        [ZDMIndicatorView hiddenInView:weakSelf.view];
        
        if (result[@"status"] != nil && [result[@"status"] integerValue] == 1) {
            dispatch_async(dispatch_get_main_queue(), ^{
                //登录成功
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    [ZDMToast showWithText:@"登录成功"];
                });
                
                //存储个人信息
                [UserDataManager setUserData:result[@"data"]];
                
                if (weakSelf.originVC) {
                    //发出通知，登录成功
                    [[NSNotificationCenter defaultCenter] postNotificationName:kLoginSuccess object:nil userInfo:nil];
                    [weakSelf.navigationController popToViewController:weakSelf.originVC animated:YES];
                } else {
                    //发出通知，登录成功
                    [[NSNotificationCenter defaultCenter] postNotificationName:kWelcomeLoginSuccess object:nil userInfo:nil];
                }
                
            });
            
        } else {
            dispatch_async(dispatch_get_main_queue(), ^{
                [ZDMToast showWithText:result[@"msg"]];
            });
        }
        
        
    } failedBlock:^(NSError *error) {
        [ZDMIndicatorView hiddenInView:weakSelf.view];
        dispatch_async(dispatch_get_main_queue(), ^{
            [ZDMToast showWithText:@"网络连接失败，请稍后再试！"];
        });
    }];
    
}

- (void)doForget
{
    [self endEdit];
    if (_phoneTextField.text.length != 11) {
        [ZDMToast showWithText:@"请输入正确的手机号"];
        return;
    }
    
    TQForgetPasswordViewController *forgetPasswordVC = [[TQForgetPasswordViewController alloc] init];
    forgetPasswordVC.phoneNumber = _phoneTextField.text;
    [self.navigationController pushViewController:forgetPasswordVC animated:YES];
}

- (void)wechatLogin
{
    [self endEdit];
}

- (void)qqLogin
{
    [self endEdit];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self endEdit];
}

- (void)endEdit
{
    [_phoneTextField resignFirstResponder];
    [_passwordTextField resignFirstResponder];
}

#pragma mark - UITextField Delegate

- (void)textFieldDidChanged
{
    if ([_phoneTextField isFirstResponder]) {
//        if (_phoneTextField.text.length > 0) {
            if (_phoneTextField.text.length > 11) {
                _phoneTextField.text = [_phoneTextField.text substringToIndex:11];
            }
//            _phoneLabel.text = _phoneTextField.text;
//            _phoneLabel.textColor = kNavTitleColor;
//            _phoneDeleteButton.hidden = NO;
//        } else {
//            _phoneLabel.textColor = kTitleTextColor;
//            _phoneLabel.text = @"手机";
//            _phoneDeleteButton.hidden = YES;
//        }
//        
    }
    
    if ([_passwordTextField isFirstResponder]) {
//        if (_passwordTextField.text.length > 0) {
            if (_passwordTextField.text.length > 16) {
                _passwordTextField.text = [_passwordTextField.text substringToIndex:16];
            }
//            _passwordLabel.text = [self makeSecurityStringBy:_passwordTextField.text];
//            _passwordLabel.textColor = kNavTitleColor;
//            _passwordDeleteButton.hidden = NO;
//        } else {
//            _passwordLabel.textColor = kTitleTextColor;
//            _passwordLabel.text = @"密码";
//            _passwordDeleteButton.hidden = YES;
//        }
//        
    }
    
    //更新注册按钮状态
    [self updateLoginButtonStatus];
}

- (void)updateLoginButtonStatus
{
    if (_phoneTextField.text.length == 11 && _passwordTextField.text.length > 0) {
        _loginButton.backgroundColor = kSubjectBackColor;
        _loginButton.enabled = YES;
    } else {
        _loginButton.backgroundColor = kSubTextColor;
        _loginButton.enabled = NO;
    }
}

//- (NSString *)makeSecurityStringBy:(NSString *)str
//{
//    NSString *result = @"";
//    for (NSInteger i = 0; i < str.length; i++) {
//        result = [result stringByAppendingString:@"•"];
//    }
//    
//    return result;
//}


@end
