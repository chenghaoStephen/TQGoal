//
//  TQTabBarController.m
//  wegoal
//
//  Created by joker on 2016/12/3.
//  Copyright © 2016年 xdkj. All rights reserved.
//

#import "TQTabBarController.h"
#import "TQHomeViewController.h"
#import "TQScheduleViewController.h"
#import "TQLadderViewController.h"
#import "TQMeViewController.h"
#import "TQTabBar.h"
#import "TQProtocolViewController.h"

@interface TQTabBarController ()<TQTabBarDelegate>

@property (nonatomic, strong) TQTabBar *myTabBar;

@end

@implementation TQTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNotifications];
    
    //设置子视图
    [self setUpAllChildVc];
    [self configureZYPathButton];
}

- (void)setNotifications
{
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(showPlusButton)
                                                 name:kTabbarNeedShowNoti
                                               object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(hidePlusButton)
                                                 name:kTabbarNeedHideNoti
                                               object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(changeIndexToSchedule)
                                                 name:kShowScheuleTab
                                               object:nil];
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)showPlusButton
{
    [_myTabBar showPlusButton];
}

- (void)hidePlusButton
{
    [_myTabBar hidePlusButton];
}

- (void)configureZYPathButton {
    _myTabBar = [TQTabBar new];
    _myTabBar.tabDelegate = self;
    //约对手
    ZYPathItemButton *matchBtn = [[ZYPathItemButton alloc]initWithImage:[UIImage imageNamed:@"match"] highlightedImage:[UIImage imageNamed:@"match"] backgroundImage:nil backgroundHighlightedImage:nil];
    //约裁判
    ZYPathItemButton *refereeBtn = [[ZYPathItemButton alloc]initWithImage:[UIImage imageNamed:@"referee"] highlightedImage:[UIImage imageNamed:@"referee"] backgroundImage:nil backgroundHighlightedImage:nil];
    //约服务
    ZYPathItemButton *shoppingBtn = [[ZYPathItemButton alloc]initWithImage:[UIImage imageNamed:@"shopping"] highlightedImage:[UIImage imageNamed:@"shopping"] backgroundImage:nil backgroundHighlightedImage:nil];
    _myTabBar.pathButtonArray = @[matchBtn , refereeBtn , shoppingBtn];
    _myTabBar.basicDuration = 0.5;
    _myTabBar.allowSubItemRotation = YES;
    _myTabBar.bloomRadius = 100;
    _myTabBar.allowCenterButtonRotation = NO;
    _myTabBar.allowSubItemRotation = NO;
    _myTabBar.bloomAngel = 100;
    _myTabBar.tintColor = kSubjectBackColor;
    //kvc实质是修改了系统的_tabBar
    [self setValue:_myTabBar forKeyPath:@"tabBar"];
    
}

- (void)setUpAllChildVc {
    //TabbarController添加四个子控制器
    //首页
    TQHomeViewController *HomeVC = [[TQHomeViewController alloc] init];
    [self setUpOneChildVcWithVc:HomeVC Image:@"home" selectedImage:@"home_select" title:@"首页"];
    //赛程
    TQScheduleViewController *scheduleVC = [[TQScheduleViewController alloc] init];
    [self setUpOneChildVcWithVc:scheduleVC Image:@"schedule" selectedImage:@"schedule_select" title:@"约战"];
    //天梯
    TQLadderViewController *ladderVC = [[TQLadderViewController alloc] init];
    [self setUpOneChildVcWithVc:ladderVC Image:@"ladder" selectedImage:@"ladder_select" title:@"天梯"];
    //我
    TQMeViewController *meVC = [[TQMeViewController alloc] init];
    [self setUpOneChildVcWithVc:meVC Image:@"me" selectedImage:@"me_select" title:@"生涯"];
}

- (void)changeIndexToSchedule
{
    self.selectedIndex = 1;
}


#pragma mark - 初始化设置tabBar上面单个按钮的方法

/**
 *  @author li bo, 16/05/10
 *
 *  设置单个tabBarButton
 *
 *  @param Vc            每一个按钮对应的控制器
 *  @param image         每一个按钮对应的普通状态下图片
 *  @param selectedImage 每一个按钮对应的选中状态下的图片
 *  @param title         每一个按钮对应的标题
 */
- (void)setUpOneChildVcWithVc:(UIViewController *)Vc Image:(NSString *)image selectedImage:(NSString *)selectedImage title:(NSString *)title
{
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:Vc];
    
    UIImage *myImage = [UIImage imageNamed:image];
    myImage = [myImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    //tabBarItem，是系统提供模型，专门负责tabbar上按钮的文字以及图片展示
    Vc.tabBarItem.image = myImage;
    UIImage *mySelectedImage = [UIImage imageNamed:selectedImage];
    mySelectedImage = [mySelectedImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    Vc.tabBarItem.selectedImage = mySelectedImage;
    Vc.tabBarItem.title = title;
    Vc.navigationItem.title = title;
    [self addChildViewController:nav];
    
}


#pragma mark - TQTabBarDelegate

- (void)pathButton:(ZYPathButton *)ZYPathButton clickItemButtonAtIndex:(NSUInteger)itemButtonIndex {
    NSLog(@" 点中了第%ld个按钮" , itemButtonIndex);
    TQBaseViewController *selectedVC = ((UINavigationController *)self.selectedViewController).viewControllers.firstObject;
    if (itemButtonIndex == 0) {
        //发起约战
        [selectedVC pushLaunchVC];
    } else if (itemButtonIndex == 1) {
        //约裁判
        [selectedVC pushRefereeVC];
    } else if (itemButtonIndex == 2) {
        //约服务
        [selectedVC pushServicesVC];
    }
}

@end
