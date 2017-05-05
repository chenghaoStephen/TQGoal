//
//  TQRegisterConfirmViewController.m
//  wegoal
//
//  Created by joker on 2017/3/31.
//  Copyright © 2017年 xdkj. All rights reserved.
//

#import "TQRegisterConfirmViewController.h"
#import "TQLoginViewController.h"
#import "JOCodeView.h"
#import "JOIndicatorView.h"

@interface TQRegisterConfirmViewController ()
{
    BOOL hasSend;
    
    NSTimer *timeToRefreshTimer;
    NSInteger nowTime;
}

@property (nonatomic, strong) UILabel *noticeLabel;
@property (nonatomic, strong) UILabel *phoneLabel;
@property (nonatomic, strong) JOCodeView *codeView;
@property (nonatomic, strong) UIButton *sendButton;
@property (nonatomic, strong) UIButton *registerButton;

@property (nonatomic, strong) NSString *codeStr;

@end

@implementation TQRegisterConfirmViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    hasSend = NO;
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.noticeLabel];
    [self.view addSubview:self.phoneLabel];
    [self.view addSubview:self.codeView];
    [self.view addSubview:self.sendButton];
    [self.view addSubview:self.registerButton];
    
    [self registerNotifications];
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

- (void)registerNotifications
{
    //增加监听，当键盘出现或改变时收出消息
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillShow:)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];
    
    //增加监听，当键退出时收出消息
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillHide:)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
}

//当键盘出现或改变时调用
- (void)keyboardWillShow:(NSNotification *)aNotification
{
    //获取键盘的高度
    NSDictionary *userInfo = [aNotification userInfo];
    NSValue *aValue = [userInfo objectForKey:UIKeyboardFrameEndUserInfoKey];
    CGRect keyboardRect = [aValue CGRectValue];
    NSInteger keyboardHeight = keyboardRect.size.height;
    
    self.registerButton.top = VIEW_HEIGHT - 64 - keyboardHeight;
}

//当键退出时调用
- (void)keyboardWillHide:(NSNotification *)aNotification
{
    self.registerButton.top = VIEW_HEIGHT - 64;
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}


#pragma mark - subViews

- (UILabel *)noticeLabel
{
    if (!_noticeLabel) {
        _noticeLabel = [[UILabel alloc] initWithFrame:CGRectMake(8, 25, SCREEN_WIDTH - 16, 15)];
        _noticeLabel.textColor = kTitleTextColor;
        _noticeLabel.textAlignment = NSTextAlignmentCenter;
        _noticeLabel.font = [UIFont systemFontOfSize:16];
        _noticeLabel.text = @"我们将发送一个验证码到您的手机";
    }
    return _noticeLabel;
}

- (UILabel *)phoneLabel
{
    if (!_phoneLabel) {
        _phoneLabel = [[UILabel alloc] initWithFrame:CGRectMake(8, _noticeLabel.bottom + 16, SCREEN_WIDTH - 16, 20)];
        _phoneLabel.textColor = kNavTitleColor;
        _phoneLabel.textAlignment = NSTextAlignmentCenter;
        _phoneLabel.font = [UIFont fontWithName:@"Arial" size:25.0];
        _phoneLabel.text = _phoneNumber;
    }
    return _phoneLabel;
}

- (JOCodeView *)codeView
{
    if (!_codeView) {
        _codeView = [[JOCodeView alloc] initWithFrame:CGRectMake(30, _phoneLabel.bottom + 20, SCREEN_WIDTH - 60, 47)
                                               number:6
                                            lineColor:kTitleTextColor
                                            textColor:kNavTitleColor
                                                 font:[UIFont fontWithName:@"Arial" size:37.0]];
        __weak typeof(self) weakSelf = self;
        _codeView.EditBlock = ^(NSString *text){
            weakSelf.codeStr = text;
            [weakSelf updateRegisterStatus];
        };
    }
    return _codeView;
}

- (UIButton *)sendButton
{
    if (!_sendButton) {
        _sendButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _sendButton.frame = CGRectMake((SCREEN_WIDTH - 244)/2, _codeView.bottom + 23, 244, 48);
        [_sendButton setTitle:@"发送验证码" forState:UIControlStateNormal];
        [_sendButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _sendButton.backgroundColor = kSubjectBackColor;
        _sendButton.titleLabel.font = [UIFont systemFontOfSize:16.f];
        _sendButton.layer.masksToBounds = YES;
        _sendButton.layer.cornerRadius = 24;
        _sendButton.enabled = YES;
        [_sendButton addTarget:self action:@selector(sendCode) forControlEvents:UIControlEventTouchUpInside];
    }
    return _sendButton;
}

- (UIButton *)registerButton
{
    if (!_registerButton) {
        _registerButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _registerButton.frame = CGRectMake(0, VIEW_HEIGHT - 64, SCREEN_WIDTH, 64);
        _registerButton.backgroundColor = kSubTextColor;
        [_registerButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_registerButton setTitle:@"注册完成" forState:UIControlStateNormal];
        _registerButton.titleLabel.font = [UIFont systemFontOfSize:16.f];
        _registerButton.enabled = NO;
        [_registerButton addTarget:self action:@selector(registerComplete) forControlEvents:UIControlEventTouchUpInside];
    }
    return _registerButton;
}

#pragma mark - events

- (void)gotoLogin
{
    for (UIViewController *vc in self.navigationController.viewControllers) {
        if ([vc isKindOfClass:[TQLoginViewController class]]) {
            [self.navigationController popToViewController:vc animated:YES];
            return;
        }
    }
    
    TQLoginViewController *loginVC = [[TQLoginViewController alloc] init];
    [self.navigationController pushViewController:loginVC animated:YES];
}

- (void)sendCode
{
    __weak typeof(self) weakSelf = self;
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"mobile"] = _phoneNumber;
    [JOIndicatorView showInView:self.view];
    [[AFServer sharedInstance]GET:URL(kTQDomainURL, kAccountSendCode) parameters:params finishBlock:^(id result) {
        [JOIndicatorView hiddenInView:weakSelf.view];
        
        if (result[@"status"] != nil && [result[@"status"] integerValue] == 1) {
            dispatch_async(dispatch_get_main_queue(), ^{
                
                [weakSelf startTimer];
                
            });
            
        } else {
            dispatch_async(dispatch_get_main_queue(), ^{
                [JOToast showWithText:result[@"msg"]];
            });
        }
        
    } failedBlock:^(NSError *error) {
        [JOIndicatorView hiddenInView:weakSelf.view];
        dispatch_async(dispatch_get_main_queue(), ^{
            [JOToast showWithText:@"网络连接失败，请稍后再试！"];
        });
    }];
    
}

- (void)startTimer
{
    hasSend = YES;
    nowTime = 60;
    if (timeToRefreshTimer == nil) {
        timeToRefreshTimer = [TimerWeakTarget scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(timerFireMethod:) userInfo:nil repeats:YES];
    }
    self.sendButton.enabled = NO;
    self.sendButton.backgroundColor = kSubTextColor;
    [self.sendButton setTitle:[NSString stringWithFormat:@"%lds 重新发送", nowTime] forState:UIControlStateNormal];
}

- (void)timerFireMethod:(NSTimer*)_timer{
    nowTime --;
    if (nowTime > 0) {
        self.sendButton.enabled = NO;
        self.sendButton.backgroundColor = kSubTextColor;
        [self.sendButton setTitle:[NSString stringWithFormat:@"%lds 重新发送", nowTime] forState:UIControlStateNormal];
        
    }else{
        if (timeToRefreshTimer.isValid) {
            [timeToRefreshTimer invalidate];
            timeToRefreshTimer = nil;
        }
        self.sendButton.enabled = YES;
        self.sendButton.backgroundColor = kSubjectBackColor;
        [self.sendButton setTitle:@"发送验证码" forState:UIControlStateNormal];
    }
}

//更新注册按钮状态
- (void)updateRegisterStatus
{
    if (_codeStr.length == 6 && hasSend) {
        _registerButton.backgroundColor = kSubjectBackColor;
        _registerButton.enabled = YES;
    } else {
        _registerButton.backgroundColor = kSubTextColor;
        _registerButton.enabled = NO;
    }
}

//验证验证码是否正确，如果正确，注册成功
- (void)registerComplete
{
    __weak typeof(self) weakSelf = self;
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"mobile"] = _phoneNumber;
    params[@"code"] = _codeStr;
    [JOIndicatorView showInView:self.view];
    [[AFServer sharedInstance]GET:URL(kTQDomainURL, kAccountVerifyCode) parameters:params finishBlock:^(id result) {
        [JOIndicatorView hiddenInView:weakSelf.view];
        
        if (result[@"status"] != nil && [result[@"status"] integerValue] == 1) {
            dispatch_async(dispatch_get_main_queue(), ^{
                
                //注册
                [weakSelf doRegister];
                
            });
            
        } else {
            dispatch_async(dispatch_get_main_queue(), ^{
                [JOToast showWithText:result[@"msg"]];
            });
        }
        
    } failedBlock:^(NSError *error) {
        [JOIndicatorView hiddenInView:weakSelf.view];
        dispatch_async(dispatch_get_main_queue(), ^{
            [JOToast showWithText:@"网络连接失败，请稍后再试！"];
        });
    }];
}

- (void)doRegister
{
    __weak typeof(self) weakSelf = self;
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"userName"] = _phoneNumber;
    params[@"password"] = _password;
    [JOIndicatorView showInView:self.view];
    [[AFServer sharedInstance]POST:URL(kTQDomainURL, kAccountRegister) parameters:params filePath:nil finishBlock:^(id result) {
        [JOIndicatorView hiddenInView:weakSelf.view];
        
        if (result[@"status"] != nil && [result[@"status"] integerValue] == 1) {
            dispatch_async(dispatch_get_main_queue(), ^{
                
                //注册成功
                NSLog(@"注册成功!");
                //自动登录
                [weakSelf autoLogin];
            });
            
        } else {
            dispatch_async(dispatch_get_main_queue(), ^{
                [JOToast showWithText:result[@"msg"]];
            });
        }
        
    } failedBlock:^(NSError *error) {
        [JOIndicatorView hiddenInView:weakSelf.view];
        dispatch_async(dispatch_get_main_queue(), ^{
            [JOToast showWithText:@"网络连接失败，请稍后再试！"];
        });
    }];
}

- (void)autoLogin
{
    __weak typeof(self) weakSelf = self;
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"userName"] = _phoneNumber;
    params[@"password"] = _password;
    [JOIndicatorView showInView:self.view];
    [[AFServer sharedInstance]GET:URL(kTQDomainURL, kAccountLogin) parameters:params finishBlock:^(id result) {
        [JOIndicatorView hiddenInView:weakSelf.view];
        
        if (result[@"status"] != nil && [result[@"status"] integerValue] == 1) {
            dispatch_async(dispatch_get_main_queue(), ^{
                //登录成功
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    [JOToast showWithText:@"登录成功"];
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
                [JOToast showWithText:result[@"msg"]];
            });
        }
        
        
    } failedBlock:^(NSError *error) {
        [JOIndicatorView hiddenInView:weakSelf.view];
        dispatch_async(dispatch_get_main_queue(), ^{
            [JOToast showWithText:@"网络连接失败，请稍后再试！"];
        });
    }];
}


@end
