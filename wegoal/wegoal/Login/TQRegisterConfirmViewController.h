//
//  TQRegisterConfirmViewController.h
//  wegoal
//
//  Created by joker on 2017/3/31.
//  Copyright © 2017年 xdkj. All rights reserved.
//

#import "TQBaseViewController.h"

@interface TQRegisterConfirmViewController : TQBaseViewController

@property (nonatomic, strong) NSString *phoneNumber;
@property (nonatomic, strong) NSString *password;
@property (nonatomic, weak) UIViewController *originVC;

@end
