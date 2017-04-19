//
//  TQRegisterViewController.m
//  wegoal
//
//  Created by joker on 2017/3/31.
//  Copyright © 2017年 xdkj. All rights reserved.
//

#import "TQRegisterViewController.h"
#import "TQLoginViewController.h"
#import "TQRegisterConfirmViewController.h"

@interface TQRegisterViewController ()<UITextFieldDelegate, UITextViewDelegate>

//@property (nonatomic, strong) UILabel *phoneLabel;              //手机号
//@property (nonatomic, strong) UILabel *passwordLabel;           //密码
//@property (nonatomic, strong) UIButton *phoneDeleteButton;      //手机号清空
//@property (nonatomic, strong) UIButton *passwordDeleteButton;   //密码清空
@property (nonatomic, strong) UITextField *phoneTextField;      //手机号输入
@property (nonatomic, strong) UITextField *passwordTextField;   //密码输入
@property (nonatomic, strong) UIButton *registerButton;         //注册按钮
@property (nonatomic, strong) UITextView *noticeView;           //提示信息
@property (nonatomic, strong) UIImageView *breakLine;           //分割线
@property (nonatomic, strong) UILabel *thirdLoginLabel;         //第三方登录
@property (nonatomic, strong) UIButton *wechatLoginButton;      //微信登录
@property (nonatomic, strong) UIButton *qqLoginButton;          //qq登录

@end

@implementation TQRegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
//    [self.view addSubview:self.phoneLabel];
//    [self.view addSubview:self.passwordLabel];
//    [self.view addSubview:self.phoneDeleteButton];
//    [self.view addSubview:self.passwordDeleteButton];
    [self.view addSubview:self.phoneTextField];
    [self.view addSubview:self.passwordTextField];
    [self.view addSubview:self.registerButton];
    [self.view addSubview:self.noticeView];
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
    UIButton *toLoginBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    toLoginBtn.frame = CGRectMake(0, 0, 110, 44);
    [toLoginBtn addTarget:self action:@selector(gotoLogin) forControlEvents:UIControlEventTouchUpInside];
    [toLoginBtn setTitle:@"已有账号，去登录" forState:UIControlStateNormal];
    [toLoginBtn setTitleColor:kNavTitleColor forState:UIControlStateNormal];
    toLoginBtn.titleLabel.font = [UIFont systemFontOfSize:12.f];
    UIBarButtonItem *toLoginBarBtn = [[UIBarButtonItem alloc] initWithCustomView:toLoginBtn];
    return toLoginBarBtn;
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

- (UIButton *)registerButton
{
    if (!_registerButton) {
        _registerButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _registerButton.frame = CGRectMake((SCREEN_WIDTH - 244)/2, _passwordTextField.bottom + 16, 244, 48);
        _registerButton.backgroundColor = kSubTextColor;
        [_registerButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_registerButton setTitle:@"注册" forState:UIControlStateNormal];
        _registerButton.titleLabel.font = [UIFont fontWithName:@"Arial" size:16.0];
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
        _noticeView = [[UITextView alloc] initWithFrame:CGRectMake((SCREEN_WIDTH - 280)/2, _registerButton.bottom + 15, 280, 15)];
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
        
        NSString *noticeStr = @"使用WeGoal,就表示您同意WeGoal的 使用条款 和 隐私政策";
        NSMutableAttributedString *textAtt = [[NSMutableAttributedString alloc] initWithString:noticeStr];
        [textAtt addAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:10.f], NSForegroundColorAttributeName:kTitleTextColor} range:NSMakeRange(0, noticeStr.length)];
        [textAtt addAttributes:@{NSLinkAttributeName:@"provision", NSForegroundColorAttributeName:kNavTitleColor, NSUnderlineStyleAttributeName:@(NSUnderlineStyleSingle)} range:NSMakeRange(noticeStr.length - 11, 4)];
        [textAtt addAttributes:@{NSLinkAttributeName:@"policy", NSForegroundColorAttributeName:kNavTitleColor, NSUnderlineStyleAttributeName:@(NSUnderlineStyleSingle)} range:NSMakeRange(noticeStr.length - 4, 4)];
        _noticeView.attributedText = textAtt;
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

- (void)gotoLogin
{
    [self endEdit];
    for (UIViewController *vc in self.navigationController.viewControllers) {
        if ([vc isKindOfClass:[TQLoginViewController class]]) {
            [self.navigationController popToViewController:vc animated:YES];
            return;
        }
    }
    
    TQLoginViewController *loginVC = [[TQLoginViewController alloc] init];
    [self.navigationController pushViewController:loginVC animated:YES];
}

//- (void)editPhone
//{
//    [_phoneTextField becomeFirstResponder];
//}
//
//- (void)editPassword
//{
//    [_passwordTextField becomeFirstResponder];
//}
//
//- (void)clearPhone
//{
//    _phoneTextField.text = @"";
//    _phoneLabel.textColor = kTitleTextColor;
//    _phoneLabel.text = @"手机";
//    _phoneDeleteButton.hidden = YES;
//    [self updateRegisterButtonStatus];
//}
//
//- (void)clearPassword
//{
//    _passwordTextField.text = @"";
//    _passwordLabel.textColor = kTitleTextColor;
//    _passwordLabel.text = @"密码";
//    _passwordDeleteButton.hidden = YES;
//    [self updateRegisterButtonStatus];
//}

- (void)doRegister
{
    [self endEdit];
    
    TQRegisterConfirmViewController *registerConfirmVC = [[TQRegisterConfirmViewController alloc] init];
    registerConfirmVC.phoneNumber = _phoneTextField.text;
    registerConfirmVC.password = _passwordTextField.text;
    registerConfirmVC.originVC = _originVC;
    [self.navigationController pushViewController:registerConfirmVC animated:YES];
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
        
    }
    
    //更新注册按钮状态
    [self updateRegisterButtonStatus];
}

- (void)updateRegisterButtonStatus
{
    if (_phoneTextField.text.length == 11 && _passwordTextField.text.length > 0) {
        _registerButton.backgroundColor = kSubjectBackColor;
        _registerButton.enabled = YES;
    } else {
        _registerButton.backgroundColor = kSubTextColor;
        _registerButton.enabled = NO;
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


#pragma mark - UITextView Delegate

- (BOOL)textView:(UITextView *)textView shouldInteractWithURL:(NSURL *)URL inRange:(NSRange)characterRange
{
    if ([URL.absoluteString isEqualToString:@"provision"]) {
        NSLog(@"使用条款");
        [self endEdit];
        
    } else if ([URL.absoluteString isEqualToString:@"policy"]) {
        NSLog(@"隐私政策");
        [self endEdit];
        
    }
    return YES;
}



@end
