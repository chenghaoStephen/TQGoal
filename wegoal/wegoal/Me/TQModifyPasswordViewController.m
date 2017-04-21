//
//  TQModifyPasswordViewController.m
//  wegoal
//
//  Created by joker on 2017/4/21.
//  Copyright © 2017年 xdkj. All rights reserved.
//

#import "TQModifyPasswordViewController.h"

@interface TQModifyPasswordViewController ()

@end

@implementation TQModifyPasswordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"修改密码";
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}

- (IBAction)submitAction:(id)sender {
    
}

@end
