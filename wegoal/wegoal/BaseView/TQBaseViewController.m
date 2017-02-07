//
//  TQBaseViewController.m
//  wegoal
//
//  Created by joker on 2016/12/20.
//  Copyright © 2016年 xdkj. All rights reserved.
//

#import "TQBaseViewController.h"

@interface TQBaseViewController ()

@end

@implementation TQBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setNavigationBar];
    self.navigationItem.leftBarButtonItem = [self buildLeftNavigationItem];
    self.navigationItem.rightBarButtonItem = [self buildRightNavigationItem];
    self.view.backgroundColor = RGB16(0xf0f6f2);
}

- (UIBarButtonItem*)buildLeftNavigationItem{
    UIBarButtonItem *leftBar = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"back"]
                                                               style:UIBarButtonItemStyleDone
                                                              target:self
                                                              action:@selector(goBack)];
    return leftBar;
}

- (UIBarButtonItem*)buildRightNavigationItem{
    return nil;
}

- (void)goBack{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)setNavigationBar
{
    //背景和标题
    [self.navigationController.navigationBar setBackgroundImage:[TQCommon imageWithColor:RGB16(0x57d67e)]
                                                 forBarPosition:UIBarPositionAny
                                                     barMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
    [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjects:@[[UIColor whiteColor],[UIFont boldSystemFontOfSize:18],] forKeys:@[NSForegroundColorAttributeName,NSFontAttributeName]]];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    
    
}

@end
