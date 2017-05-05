//
//  TQSignUpViewController.m
//  wegoal
//
//  Created by joker on 2017/4/3.
//  Copyright © 2017年 xdkj. All rights reserved.
//

#import "TQSignUpViewController.h"

@interface TQSignUpViewController ()<UITextFieldDelegate>
{
    CGRect viewFrame;
}

@property (strong, nonatomic) UILabel *titleLabel;
@property (strong, nonatomic) UIView *signView;
//@property (nonatomic, strong) UILabel *nameLabel;                 //姓名
//@property (nonatomic, strong) UILabel *phoneLabel;                //手机号
//@property (nonatomic, strong) UIButton *nameDeleteButton;         //姓名清空
//@property (nonatomic, strong) UIButton *phoneDeleteButton;        //手机号清空
@property (nonatomic, strong) UITextField *nameTextField;         //姓名输入
@property (nonatomic, strong) UITextField *phoneTextField;        //手机号输入
@property (nonatomic, strong) UIButton *confirmButton;            //确认报名按钮
@property (nonatomic, strong) UIButton *closeButton;              //关闭按钮

@end

@implementation TQSignUpViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(textFieldDidChanged)
                                                 name:UITextFieldTextDidChangeNotification
                                               object:nil];
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super init];
    if (self) {
        viewFrame = frame;
        self.view.frame = frame;
        
        [self.view addSubview:self.titleLabel];
        [self.view addSubview:self.signView];
//        [self.view addSubview:self.nameLabel];
//        [self.view addSubview:self.phoneLabel];
//        [self.view addSubview:self.nameDeleteButton];
//        [self.view addSubview:self.phoneDeleteButton];
        [self.view addSubview:self.nameTextField];
        [self.view addSubview:self.phoneTextField];
        [self.view addSubview:self.confirmButton];
        [self.view addSubview:self.closeButton];
    }
    return self;
}

- (UILabel *)titleLabel
{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(8, 24, viewFrame.size.width - 16, 12)];
        _titleLabel.font = [UIFont systemFontOfSize:12.f];
        _titleLabel.textColor = kTitleTextColor;
        _titleLabel.text = @"请输入报名信息";
        _titleLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _titleLabel;
}

- (UIView *)signView
{
    if (!_signView) {
        _signView = [[UIView alloc] initWithFrame:CGRectMake((viewFrame.size.width - 18)/2, CGRectGetMaxY(_titleLabel.frame) + 12, 18, 4)];
        _signView.backgroundColor = kTitleTextColor;
    }
    return _signView;
}

//- (UILabel *)nameLabel
//{
//    if (!_nameLabel) {
//        _nameLabel = [[UILabel alloc] initWithFrame:CGRectMake((viewFrame.size.width - 185)/2, _signView.bottom + 64, 185, 32)];
//        _nameLabel.textAlignment = NSTextAlignmentCenter;
//        _nameLabel.backgroundColor = kInputBackColor;
//        _nameLabel.font = [UIFont systemFontOfSize:16.f];
//        _nameLabel.textColor = kTitleTextColor;
//        _nameLabel.text = @"姓名";
//        _nameLabel.layer.masksToBounds = YES;
//        _nameLabel.layer.cornerRadius = 16;
//        _nameLabel.userInteractionEnabled = YES;
//        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(editName)];
//        [_nameLabel addGestureRecognizer:tapGesture];
//    }
//    return _nameLabel;
//}
//
//- (UILabel *)phoneLabel
//{
//    if (!_phoneLabel) {
//        _phoneLabel = [[UILabel alloc] initWithFrame:CGRectMake((viewFrame.size.width - 185)/2, _nameLabel.bottom + 12, 185, 32)];
//        _phoneLabel.textAlignment = NSTextAlignmentCenter;
//        _phoneLabel.backgroundColor = kInputBackColor;
//        _phoneLabel.font = [UIFont systemFontOfSize:16.f];
//        _phoneLabel.textColor = kTitleTextColor;
//        _phoneLabel.text = @"电话号码";
//        _phoneLabel.layer.masksToBounds = YES;
//        _phoneLabel.layer.cornerRadius = 16;
//        _phoneLabel.userInteractionEnabled = YES;
//        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(editPhone)];
//        [_phoneLabel addGestureRecognizer:tapGesture];
//    }
//    return _phoneLabel;
//}
//
//- (UIButton *)nameDeleteButton
//{
//    if (!_nameDeleteButton) {
//        _nameDeleteButton = [UIButton buttonWithType:UIButtonTypeCustom];
//        _nameDeleteButton.frame = CGRectMake(_nameLabel.right - 32, _nameLabel.top + (_nameLabel.height - 16)/2, 16, 16);
//        [_nameDeleteButton setImage:[UIImage imageNamed:@"login_delete"] forState:UIControlStateNormal];
//        [_nameDeleteButton addTarget:self action:@selector(clearName) forControlEvents:UIControlEventTouchUpInside];
//        _nameDeleteButton.hidden = YES;
//    }
//    return _nameDeleteButton;
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

- (UITextField *)nameTextField
{
    if (!_nameTextField) {
        _nameTextField = [[UITextField alloc] initWithFrame:CGRectMake((viewFrame.size.width - 185)/2, _signView.bottom + 64, 185, 32)];
        _nameTextField.delegate = self;
//        _nameTextField.keyboardType = UIKeyboardTypeNumberPad;
        _nameTextField.borderStyle = UITextBorderStyleNone;
        _nameTextField.textAlignment = NSTextAlignmentCenter;
        _nameTextField.backgroundColor = kInputBackColor;
        _nameTextField.font = [UIFont fontWithName:@"Arial" size:16.0];
        _nameTextField.textColor = kTitleTextColor;
        _nameTextField.placeholder = @"姓名";
        _nameTextField.layer.masksToBounds = YES;
        _nameTextField.layer.cornerRadius = 16;
        _nameTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
    }
    return _nameTextField;
}

- (UITextField *)phoneTextField
{
    if (!_phoneTextField) {
        _phoneTextField = [[UITextField alloc] initWithFrame:CGRectMake((viewFrame.size.width - 185)/2, _nameTextField.bottom + 12, 185, 32)];
        _phoneTextField.delegate = self;
        _phoneTextField.keyboardType = UIKeyboardTypeNumberPad;
        _phoneTextField.borderStyle = UITextBorderStyleNone;
        _phoneTextField.textAlignment = NSTextAlignmentCenter;
        _phoneTextField.backgroundColor = kInputBackColor;
        _phoneTextField.font = [UIFont fontWithName:@"Arial" size:16.0];
        _phoneTextField.textColor = kTitleTextColor;
        _phoneTextField.placeholder = @"电话号码";
        _phoneTextField.layer.masksToBounds = YES;
        _phoneTextField.layer.cornerRadius = 16;
        _phoneTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
    }
    return _phoneTextField;
}



- (UIButton *)confirmButton
{
    if (!_confirmButton) {
        _confirmButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _confirmButton.frame = CGRectMake((viewFrame.size.width - 185)/2, viewFrame.size.height - 64, 185, 32);
        _confirmButton.backgroundColor = kSubTextColor;
        [_confirmButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_confirmButton setTitle:@"确认报名" forState:UIControlStateNormal];
        _confirmButton.titleLabel.font = [UIFont systemFontOfSize:16.f];
        _confirmButton.layer.masksToBounds = YES;
        _confirmButton.layer.cornerRadius = 16;
        _confirmButton.enabled = NO;
        [_confirmButton addTarget:self action:@selector(doConfirm) forControlEvents:UIControlEventTouchUpInside];
    }
    return _confirmButton;
}

- (UIButton *)closeButton
{
    if (!_closeButton) {
        _closeButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_closeButton setImage:[UIImage imageNamed:@"dialog_close"] forState:UIControlStateNormal];
        [_closeButton setFrame:CGRectMake(viewFrame.size.width, -20, 20, 20)];
    }
    return _closeButton;
}


#pragma mark - events

//- (void)editName
//{
//    [_nameTextField becomeFirstResponder];
//}
//
//- (void)editPhone
//{
//    [_phoneTextField becomeFirstResponder];
//}

//- (void)clearName
//{
//    _nameTextField.text = @"";
//    _nameLabel.textColor = kTitleTextColor;
//    _nameLabel.text = @"姓名";
//    _nameDeleteButton.hidden = YES;
//    [self updateConfirmButtonStatus];
//}
//
//- (void)clearPhone
//{
//    _phoneTextField.text = @"";
//    _phoneLabel.textColor = kTitleTextColor;
//    _phoneLabel.text = @"电话号码";
//    _phoneDeleteButton.hidden = YES;
//    [self updateConfirmButtonStatus];
//}


- (void)doConfirm
{
    [self endEdit];
    
    NSLog(@"confirm");
    TQMemberModel *userData = [UserDataManager getUserData];
    __weak typeof(self) weakSelf = self;
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"memberId"] = userData.memberId;
    params[@"gameName"] = _gameName;
    params[@"name"] = _nameTextField.text;
    params[@"phone"] = _phoneTextField.text;
    [ZDMIndicatorView showInView:self.view];
    [[AFServer sharedInstance]POST:URL(kTQDomainURL, kUserSignUp) parameters:params filePath:nil finishBlock:^(id result) {
        [ZDMIndicatorView hiddenInView:weakSelf.view];
        
        if (result[@"status"] != nil && [result[@"status"] integerValue] == 1) {
            dispatch_async(dispatch_get_main_queue(), ^{
                //申请成功
                [ZDMToast showWithText:@"报名成功"];
                //隐藏视图
                if (weakSelf.signUpSuccessBlock) {
                    weakSelf.signUpSuccessBlock();
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

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self endEdit];
}

- (void)endEdit
{
    [_nameTextField resignFirstResponder];
    [_phoneTextField resignFirstResponder];
}

#pragma mark - UITextField Delegate

- (void)textFieldDidChanged
{
    if ([_nameTextField isFirstResponder]) {
//        if (_nameTextField.text.length > 0) {
//            _nameLabel.text = _nameTextField.text;
//            _nameLabel.textColor = kNavTitleColor;
//            _nameDeleteButton.hidden = NO;
//        } else {
//            _nameLabel.textColor = kTitleTextColor;
//            _nameLabel.text = @"姓名";
//            _nameDeleteButton.hidden = YES;
//        }
        
    }
    
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
//            _phoneLabel.text = @"电话号码";
//            _phoneDeleteButton.hidden = YES;
//        }
        
    }
    
    //更新注册按钮状态
    [self updateConfirmButtonStatus];
}

- (void)updateConfirmButtonStatus
{
    if (_nameTextField.text.length > 0 && _phoneTextField.text.length == 11) {
        _confirmButton.backgroundColor = kSubjectBackColor;
        _confirmButton.enabled = YES;
    } else {
        _confirmButton.backgroundColor = kSubTextColor;
        _confirmButton.enabled = NO;
    }
}






@end
