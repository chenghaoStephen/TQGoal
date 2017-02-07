//
//  TQScheduleViewController.m
//  wegoal
//
//  Created by joker on 2016/11/27.
//  Copyright © 2016年 xdkj. All rights reserved.
//

#import "TQScheduleViewController.h"
#import "JOMatchMenuView.h"
#import "TQScheduleHeaderView.h"

@interface TQScheduleViewController ()<UINavigationControllerDelegate, JOMatchMenuViewDelegate>

@property (nonatomic, strong) JOMatchMenuView *menuView;
@property (nonatomic, strong) TQScheduleHeaderView *headerView;
@property (nonatomic, strong) UITableView *tableview;

@end

@implementation TQScheduleViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.menuView];
    [self.view addSubview:self.headerView];
    [self.view addSubview:self.tableview];
    
    self.navigationController.delegate = self;
}

- (JOMatchMenuView *)menuView
{
    if (!_menuView) {
        _menuView = [[JOMatchMenuView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 200)];
        _menuView.backgroundColor = kScheduleBackColor;
        _menuView.delegate = self;
        _menuView.isDrop = NO;
    }
    return _menuView;
}


#pragma mark - UINavigationControllerDelegate

- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if ([viewController isKindOfClass:[TQScheduleViewController class]]) {
        [navigationController setNavigationBarHidden:YES];
    }
}


#pragma mark - JOMatchMenuViewDelegate

- (void)JOMatchMenuView:(JOMatchMenuView *)matchMenuView getDataWithWeeks:(NSArray *)weeks systems:(NSArray *)systems types:(NSArray *)types
{
    
}

@end
