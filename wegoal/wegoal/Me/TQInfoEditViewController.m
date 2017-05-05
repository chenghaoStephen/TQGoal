//
//  TQInfoEditViewController.m
//  wegoal
//
//  Created by joker on 2017/4/1.
//  Copyright © 2017年 xdkj. All rights reserved.
//

#import "TQInfoEditViewController.h"

#define kLeftSpace 0
#define kMaxLength 20

@interface TQInfoEditViewController ()<UITextFieldDelegate>

@property (nonatomic, strong) UITextField *textField;

@end

@implementation TQInfoEditViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = _titleName;
    
    [self.view addSubview:self.textField];
    /*
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(textFiledEditChanged:)
                                                 name:@"UITextFieldTextDidChangeNotification"
                                               object:_textField];
     */
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


/*
- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
*/

/*
-(void)buildView{
    _previousLabel = [[UILabel alloc]initWithFrame:CGRectMake(kLeftSpace, 45, SCREEN_WIDTH-kLeftSpace, 20)];
    [self.view addSubview:_previousLabel];
    _previousLabel.textColor = kNavTitleColor;
    _previousLabel.text = [NSString stringWithFormat:@"您当前%@名称为: %@",_titleName,_filledName];
    
    _textField = [[UITextField alloc]initWithFrame:CGRectMake(kLeftSpace, 50+20, SCREEN_WIDTH-2*kLeftSpace, 49)];
    _textField.borderStyle = UITextBorderStyleRoundedRect;
    _textField.backgroundColor = [UIColor whiteColor];
    _textField.placeholder = [NSString stringWithFormat:@"输入新的%@名称", _titleName];
    [self.view addSubview:_textField];
    
    _numLabel = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH-kLeftSpace-21, 50+20+49+5, 25, 20)];
    [self.view addSubview:_numLabel];
    _numLabel.text = [NSString stringWithFormat:@"%d",kMaxLength];
    _numLabel.textColor = RGB16(0x767676);
    
    UIButton *submitBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    submitBtn.frame = CGRectMake(kLeftSpace,50+20+49+20+10 , SCREEN_WIDTH-2*kLeftSpace, 49);
    submitBtn.backgroundColor = [UIColor redColor];
    [submitBtn setTitle:@"完成" forState:UIControlStateNormal];
    [submitBtn addTarget:self action:@selector(submit) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:submitBtn];
}
*/

- (void)saveModify{
    [_textField endEditing:YES];
    if (_textField.text == nil || _textField.text.length == 0) {
        [JOToast showWithText:[NSString stringWithFormat:@"请输入%@", _titleName]];
        return;
    }
    
    //调用接口更新个人信息
    __block TQMemberModel *userData = [UserDataManager getUserData];
    __weak typeof(self) weakSelf = self;
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"userName"] = userData.userName;
    switch (_type) {
        case EditTypeName:
            params[@"memberName"] = _textField.text;
            break;
            
        case EditTypeTeam:
            params[@"temName"] = _textField.text;
            break;
            
        case EditTypeNumber:
            params[@"memberNumber"] = _textField.text;
            break;
            
        case EditTypeAge:
            params[@"memberAge"] = _textField.text;
            break;
            
        case EditTypeHeight:
            params[@"memberHeight"] = _textField.text;
            break;
            
        case EditTypeWeight:
            params[@"memberWeight"] = _textField.text;
            break;
            
        default:
            break;
    }
    [JOIndicatorView showInView:self.view];
    [[AFServer sharedInstance]POST:URL(kTQDomainURL, kSetMember) parameters:params filePath:nil finishBlock:^(id result) {
        [JOIndicatorView hiddenInView:weakSelf.view];
        
        if (result[@"status"] != nil && [result[@"status"] integerValue] == 1) {
            dispatch_async(dispatch_get_main_queue(), ^{
                //保存成功
                [JOToast showWithText:@"保存成功"];
                //存储个人信息
                NSMutableDictionary *userDict = [NSMutableDictionary dictionaryWithDictionary:[UserDataManager getUserDataDict]];
                switch (weakSelf.type) {
                    case EditTypeName:
                        userDict[@"memberName"] = weakSelf.textField.text;
                        break;
                        
                    case EditTypeTeam:
                        userDict[@"temName"] = weakSelf.textField.text;
                        break;
                        
                    case EditTypeNumber:
                        userDict[@"memberNumber"] = weakSelf.textField.text;
                        break;
                        
                    case EditTypeAge:
                        userDict[@"memberAge"] = weakSelf.textField.text;
                        break;
                        
                    case EditTypeHeight:
                        userDict[@"memberHeight"] = weakSelf.textField.text;
                        break;
                        
                    case EditTypeWeight:
                        userDict[@"memberWeight"] = weakSelf.textField.text;
                        break;
                        
                    default:
                        break;
                }
                [UserDataManager setUserData:userDict];
                //返回
                if (weakSelf.submitBlock) {
                    weakSelf.submitBlock(weakSelf.textField.text);
                }
                [self.navigationController popViewControllerAnimated:YES];
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

/*
-(void)textFiledEditChanged:(NSNotification *)obj{
    UITextField *textField = (UITextField *)obj.object;
    NSString *toBeString = textField.text;
    NSString *lang = [[UITextInputMode currentInputMode] primaryLanguage]; // 键盘输入模式
    if ([lang isEqualToString:@"zh-Hans"]) { // 简体中文输入
        UITextRange *selectedRange = [_textField markedTextRange];       //获取高亮部分
        UITextPosition *position = [_textField positionFromPosition:selectedRange.start offset:0];
        // 没有高亮选择的字，则对已输入的文字进行字数统计和限制
        if (!position) {
            
            if (toBeString.length > kMaxLength) {
                textField.text = [toBeString substringToIndex:kMaxLength];
            }
            NSInteger num = (kMaxLength-textField.text.length)>0?kMaxLength-textField.text.length:0;
            _numLabel.text = [NSString stringWithFormat:@"%lu",num];
        }       // 有高亮选择的字符串，则暂不对文字进行统计和限制
        else{
        }
    }else{  // 中文输入法以外的直接对其统计限制即可，不考虑其他语种情况
        if (toBeString.length > kMaxLength) {
            _textField.text = [toBeString substringToIndex:kMaxLength];
        }
        NSInteger num = (kMaxLength-textField.text.length)>0?kMaxLength-textField.text.length:0;
        _numLabel.text = [NSString stringWithFormat:@"%lu",num];
    }
}
*/




@end
