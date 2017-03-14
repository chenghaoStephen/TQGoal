//
//  TQBaseViewController.h
//  wegoal
//
//  Created by joker on 2016/12/20.
//  Copyright © 2016年 xdkj. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TQBaseViewController : UIViewController

- (void)setTabBarBtnShow;
- (void)setTabbarBtnHide;

- (void)pushLaunchVC;

- (void)pushViewController:(UIViewController *)viewController;

@end
