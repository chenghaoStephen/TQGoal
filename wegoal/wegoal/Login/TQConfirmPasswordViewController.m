//
//  TQConfirmPasswordViewController.m
//  wegoal
//
//  Created by joker on 2017/3/31.
//  Copyright © 2017年 xdkj. All rights reserved.
//

#import "TQConfirmPasswordViewController.h"

@interface TQConfirmPasswordViewController ()<UITextFieldDelegate>

//@property (nonatomic, strong) UILabel *passwordLabel;           //新密码
//@property (nonatomic, strong) UILabel *confirmLabel;            //确认新密码
//@property (nonatomic, strong) UIButton *passwordDeleteButton;   //新密码清空
//@property (nonatomic, strong) UIButton *confirmDeleteButton;    //确认新密码清空
@property (nonatomic, strong) UITextField *passwordTextField;   //新密码输入
@property (nonatomic, strong) UITextField *confirmTextField;    //确认新密码输入
@property (nonatomic, strong) UIButton *actionButton;           //完成按钮

@end

@implementation TQConfirmPasswordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"确认密码";
    self.view.backgroundColor = [UIColor whiteColor];
//    [self.view addSubview:self.passwordLabel];
//    [self.view addSubview:self.confirmLabel];
//    [self.view addSubview:self.passwordDeleteButton];
//    [self.view addSubview:self.confirmDeleteButton];
    [self.view addSubview:self.passwordTextField];
    [self.view addSubview:self.confirmTextField];
    [self.view addSubview:self.actionButton];

    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(textFieldDidChanged)
                                                 name:UITextFieldTextDidChangeNotification
                                               object:nil];
}


#pragma mark - subViews

//- (UILabel *)passwordLabel
//{
//    if (!_passwordLabel) {
//        _passwordLabel = [[UILabel alloc] initWithFrame:CGRectMake((SCREEN_WIDTH - 244)/2, 36, 244, 48)];
//        _passwordLabel.textAlignment = NSTextAlignmentCenter;
//        _passwordLabel.backgroundColor = kInputBackColor;
//        _passwordLabel.font = [UIFont systemFontOfSize:16.f];
//        _passwordLabel.textColor = kTitleTextColor;
//        _passwordLabel.text = @"新密码";
//        _passwordLabel.layer.masksToBounds = YES;
//        _passwordLabel.layer.cornerRadius = 24;
//        _passwordLabel.userInteractionEnabled = YES;
//        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(editPassword)];
//        [_passwordLabel addGestureRecognizer:tapGesture];
//    }
//    return _passwordLabel;
//}
//
//- (UILabel *)confirmLabel
//{
//    if (!_confirmLabel) {
//        _confirmLabel = [[UILabel alloc] initWithFrame:CGRectMake((SCREEN_WIDTH - 244)/2, _passwordLabel.bottom + 16, 244, 48)];
//        _confirmLabel.textAlignment = NSTextAlignmentCenter;
//        _confirmLabel.backgroundColor = kInputBackColor;
//        _confirmLabel.font = [UIFont systemFontOfSize:16.f];
//        _confirmLabel.textColor = kTitleTextColor;
//        _confirmLabel.text = @"确认新密码";
//        _confirmLabel.layer.masksToBounds = YES;
//        _confirmLabel.layer.cornerRadius = 24;
//        _confirmLabel.userInteractionEnabled = YES;
//        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(editConfirm)];
//        [_confirmLabel addGestureRecognizer:tapGesture];
//    }
//    return _confirmLabel;
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
//
//- (UIButton *)confirmDeleteButton
//{
//    if (!_confirmDeleteButton) {
//        _confirmDeleteButton = [UIButton buttonWithType:UIButtonTypeCustom];
//        _confirmDeleteButton.frame = CGRectMake(_confirmLabel.right - 32, _confirmLabel.top + (_confirmLabel.height - 16)/2, 16, 16);
//        [_confirmDeleteButton setImage:[UIImage imageNamed:@"login_delete"] forState:UIControlStateNormal];
//        [_confirmDeleteButton addTarget:self action:@selector(clearConfirm) forControlEvents:UIControlEventTouchUpInside];
//        _confirmDeleteButton.hidden = YES;
//    }
//    return _confirmDeleteButton;
//}

- (UITextField *)passwordTextField
{
    if (!_passwordTextField) {
        _passwordTextField = [[UITextField alloc] initWithFrame:CGRectMake((SCREEN_WIDTH - 244)/2, 36, 244, 48)];
        _passwordTextField.delegate = self;
        _passwordTextField.borderStyle = UITextBorderStyleNone;
        _passwordTextField.textAlignment = NSTextAlignmentCenter;
        _passwordTextField.backgroundColor = kInputBackColor;
        _passwordTextField.font = [UIFont fontWithName:@"Arial" size:16.0];
        _passwordTextField.textColor = kTitleTextColor;
        _passwordTextField.placeholder = @"新密码";
        _passwordTextField.secureTextEntry = YES;
        _passwordTextField.layer.masksToBounds = YES;
        _passwordTextField.layer.cornerRadius = 24;
        _passwordTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
    }
    return _passwordTextField;
}

- (UITextField *)confirmTextField
{
    if (!_confirmTextField) {
        _confirmTextField = [[UITextField alloc] initWithFrame:CGRectMake((SCREEN_WIDTH - 244)/2, _passwordTextField.bottom + 16, 244, 48)];
        _confirmTextField.delegate = self;
        _confirmTextField.borderStyle = UITextBorderStyleNone;
        _confirmTextField.textAlignment = NSTextAlignmentCenter;
        _confirmTextField.backgroundColor = kInputBackColor;
        _confirmTextField.font = [UIFont fontWithName:@"Arial" size:16.0];
        _confirmTextField.textColor = kTitleTextColor;
        _confirmTextField.placeholder = @"确认新密码";
        _confirmTextField.secureTextEntry = YES;
        _confirmTextField.layer.masksToBounds = YES;
        _confirmTextField.layer.cornerRadius = 24;
        _confirmTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
    }
    return _confirmTextField;
}

- (UIButton *)actionButton
{
    if (!_actionButton) {
        _actionButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _actionButton.frame = CGRectMake((SCREEN_WIDTH - 244)/2, _confirmTextField.bottom + 16, 244, 48);
        _actionButton.backgroundColor = kSubTextColor;
        [_actionButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_actionButton setTitle:@"完成" forState:UIControlStateNormal];
        _actionButton.titleLabel.font = [UIFont systemFontOfSize:16.f];
        _actionButton.layer.masksToBounds = YES;
        _actionButton.layer.cornerRadius = 24;
        _actionButton.enabled = NO;
        [_actionButton addTarget:self action:@selector(doComplete) forControlEvents:UIControlEventTouchUpInside];
    }
    return _actionButton;
}


#pragma mark - events


- (void)editPassword
{
    [_passwordTextField becomeFirstResponder];
}

- (void)editConfirm
{
    [_confirmTextField becomeFirstResponder];
}

//- (void)clearPassword
//{
//    _passwordTextField.text = @"";
//    _passwordLabel.textColor = kTitleTextColor;
//    _passwordLabel.text = @"新密码";
//    _passwordDeleteButton.hidden = YES;
//    [self updateActionButtonStatus];
//}
//
//- (void)clearConfirm
//{
//    _confirmTextField.text = @"";
//    _confirmLabel.textColor = kTitleTextColor;
//    _confirmLabel.text = @"确认新密码";
//    _confirmDeleteButton.hidden = YES;
//    [self updateActionButtonStatus];
//}

- (void)doComplete
{
    [self endEdit];
    
    if (![_passwordTextField.text isEqualToString:_confirmTextField.text]) {
        [ZDMToast showWithText:@"两次输入的密码不一致"];
        return;
    }
    
    
    
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self endEdit];
}

- (void)endEdit
{
    [_passwordTextField resignFirstResponder];
    [_confirmTextField resignFirstResponder];
}

#pragma mark - UITextField Delegate

- (void)textFieldDidChanged
{
    
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
//            _passwordLabel.text = @"新密码";
//            _passwordDeleteButton.hidden = YES;
//        }
        
    }
    
    if ([_confirmTextField isFirstResponder]) {
//        if (_confirmTextField.text.length > 0) {
            if (_confirmTextField.text.length > 16) {
                _confirmTextField.text = [_confirmTextField.text substringToIndex:16];
            }
//            _confirmLabel.text = [self makeSecurityStringBy:_confirmTextField.text];
//            _confirmLabel.textColor = kNavTitleColor;
//            _confirmDeleteButton.hidden = NO;
//        } else {
//            _confirmLabel.textColor = kTitleTextColor;
//            _confirmLabel.text = @"确认新密码";
//            _confirmDeleteButton.hidden = YES;
//        }
        
    }
    
    //更新完成按钮状态
    [self updateActionButtonStatus];
}

- (void)updateActionButtonStatus
{
    if (_passwordTextField.text.length > 0 && _passwordTextField.text.length == _confirmTextField.text.length) {
        _actionButton.backgroundColor = kSubjectBackColor;
        _actionButton.enabled = YES;
    } else {
        _actionButton.backgroundColor = kSubTextColor;
        _actionButton.enabled = NO;
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
