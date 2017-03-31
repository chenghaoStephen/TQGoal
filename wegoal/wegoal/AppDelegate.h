//
//  AppDelegate.h
//  wegoal
//
//  Created by joker on 2016/11/23.
//  Copyright © 2016年 xdkj. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TQTabBarController.h"
#import "TQWelcomeViewController.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>

//
@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) TQTabBarController *tabBarController;
@property (strong, nonatomic) TQWelcomeViewController *welcomeVC;

@end
