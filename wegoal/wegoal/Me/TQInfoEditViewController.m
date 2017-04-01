//
//  TQInfoEditViewController.m
//  wegoal
//
//  Created by joker on 2017/4/1.
//  Copyright © 2017年 xdkj. All rights reserved.
//

#import "TQInfoEditViewController.h"

#define kLeftSpace 13
#define kMaxLength 20

@interface TQInfoEditViewController ()<UITextFieldDelegate>

@property(nonatomic)UILabel *previousLabel;
@property(nonatomic,strong)UITextField *textField;
@property(nonatomic,strong)UILabel *numLabel;

@end

@implementation TQInfoEditViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = [NSString stringWithFormat:@"修改%@名称",_titleName];
    [self buildView];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(textFiledEditChanged:)name:@"UITextFieldTextDidChangeNotification" object:_textField];
}
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
-(void)submit{
    if (_textField.text==nil||_textField.text.length==0) {
        return;
    }
    _submitBlock(_textField.text);
    [self.navigationController popViewControllerAnimated:YES];
}
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





@end
