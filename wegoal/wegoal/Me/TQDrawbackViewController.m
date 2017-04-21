//
//  TQDrawbackViewController.m
//  wegoal
//
//  Created by joker on 2017/4/21.
//  Copyright © 2017年 xdkj. All rights reserved.
//

#import "TQDrawbackViewController.h"
#import "TQTeamInfoEditViewController.h"

@interface TQDrawbackViewController ()<UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *amountInputTextField;
@property (weak, nonatomic) IBOutlet UILabel *alipayAccountLbl;
@property (weak, nonatomic) IBOutlet UILabel *drawbackUserLbl;
@property (weak, nonatomic) IBOutlet UIButton *submitButton;
@property (weak, nonatomic) IBOutlet UIView *alipayView;


@end

@implementation TQDrawbackViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"申请提现";
    //点击填写支付账号
    _alipayView.userInteractionEnabled = YES;
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(inputAlipayAccount)];
    [_alipayView addGestureRecognizer:tapGesture];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(textFieldDidChanged)
                                                 name:UITextFieldTextDidChangeNotification
                                               object:nil];
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}

#pragma mark - events

- (void)inputAlipayAccount
{
    [self.view endEditing:YES];
    TQTeamInfoEditViewController *editVC = [[TQTeamInfoEditViewController alloc] init];
    editVC.titleName = @"支付宝账号";
    editVC.type = TeamEditTypeOther;
    __weak typeof(self) weakSelf = self;
    editVC.submitBlock = ^(NSString *account){
        weakSelf.alipayAccountLbl.text = account;
        [weakSelf updateSubmitButtonStatus];
    };
    [self.navigationController pushViewController:editVC animated:YES];
}

- (void)updateSubmitButtonStatus
{
    if (_amountInputTextField.text.length > 0 && _alipayAccountLbl.text.length > 0) {
        _submitButton.enabled = YES;
        _submitButton.backgroundColor = kSubjectBackColor;
    } else {
        _submitButton.enabled = NO;
        _submitButton.backgroundColor = kSubTextColor;
    }
}

- (IBAction)submitAction:(id)sender {
    [self.view endEditing:YES];
    
}


#pragma mark - UITextField Delegate

- (void)textFieldDidChanged
{
    [self updateSubmitButtonStatus];
}




@end
