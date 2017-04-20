//
//  TQTeamInfoEditViewController.m
//  wegoal
//
//  Created by joker on 2017/4/20.
//  Copyright © 2017年 xdkj. All rights reserved.
//

#import "TQTeamInfoEditViewController.h"

#define kLeftSpace 0
#define kMaxLength 20

@interface TQTeamInfoEditViewController ()<UITextFieldDelegate>

@property (nonatomic, strong) UITextField *textField;

@end

@implementation TQTeamInfoEditViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = _titleName;
    
    [self.view addSubview:self.textField];
    
}

- (UITextField *)textField
{
    if (!_textField) {
        _textField = [[UITextField alloc] initWithFrame:CGRectMake(0, 3, SCREEN_WIDTH, 36)];
        _textField.backgroundColor = [UIColor whiteColor];
        _textField.clearButtonMode = UITextFieldViewModeWhileEditing;
        UIView *leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 15, 36)];
        leftView.backgroundColor = [UIColor clearColor];
        _textField.leftView = leftView;
        _textField.leftViewMode = UITextFieldViewModeAlways;
        _textField.textColor = [UIColor blackColor];
        _textField.font = [UIFont systemFontOfSize:12.f];
        _textField.placeholder = [NSString stringWithFormat:@"输入%@", _titleName];
        _textField.delegate = self;
    }
    return _textField;
}

- (UIBarButtonItem*)buildRightNavigationItem{
    UIButton *saveButton = [UIButton buttonWithType:UIButtonTypeCustom];
    saveButton.frame = CGRectMake(0, 0, 44, 44);
    [saveButton addTarget:self action:@selector(saveModify) forControlEvents:UIControlEventTouchUpInside];
    [saveButton setTitle:@"完成" forState:UIControlStateNormal];
    [saveButton setTitleColor:kNavTitleColor forState:UIControlStateNormal];
    saveButton.titleLabel.font = [UIFont systemFontOfSize:12.f];
    UIBarButtonItem *toSaveBarBtn = [[UIBarButtonItem alloc] initWithCustomView:saveButton];
    return toSaveBarBtn;
}


- (void)saveModify{
    [_textField endEditing:YES];
    if (_textField.text == nil || _textField.text.length == 0) {
        [ZDMToast showWithText:[NSString stringWithFormat:@"请输入%@", _titleName]];
        return;
    }
    
    //返回
    if (_submitBlock) {
        _submitBlock(_textField.text);
    }
    [self.navigationController popViewControllerAnimated:YES];
}

@end
