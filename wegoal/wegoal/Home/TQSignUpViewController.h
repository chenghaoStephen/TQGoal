//
//  TQSignUpViewController.h
//  wegoal
//
//  Created by joker on 2017/4/3.
//  Copyright © 2017年 xdkj. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TQSignUpViewController : UIViewController

- (instancetype)initWithFrame:(CGRect)frame;
@property (nonatomic, strong) NSString *gameName;
@property (nonatomic, copy) void(^signUpSuccessBlock)();

@end
