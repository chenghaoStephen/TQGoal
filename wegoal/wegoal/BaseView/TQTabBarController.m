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

@interface TQTabBarController ()<TQTabBarDelegate>

@end

@implementation TQTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    //设置子视图
    [self setUpAllChildVc];
    [self configureZYPathButton];
}

- (void)configureZYPathButton {
    TQTabBar *tabBar = [TQTabBar new];
    tabBar.tabDelegate = self;
    //约对手
    ZYPathItemButton *matchBtn = [[ZYPathItemButton alloc]initWithImage:[UIImage imageNamed:@"match"] highlightedImage:[UIImage imageNamed:@"match"] backgroundImage:nil backgroundHighlightedImage:nil];
    //约裁判
    ZYPathItemButton *refereeBtn = [[ZYPathItemButton alloc]initWithImage:[UIImage imageNamed:@"referee"] highlightedImage:[UIImage imageNamed:@"referee"] backgroundImage:nil backgroundHighlightedImage:nil];
    //约服务
    ZYPathItemButton *shoppingBtn = [[ZYPathItemButton alloc]initWithImage:[UIImage imageNamed:@"shopping"] highlightedImage:[UIImage imageNamed:@"shopping"] backgroundImage:nil backgroundHighlightedImage:nil];
    tabBar.pathButtonArray = @[matchBtn , refereeBtn , shoppingBtn];
    tabBar.basicDuration = 0.5;
    tabBar.allowSubItemRotation = YES;
    tabBar.bloomRadius = 100;
    tabBar.allowCenterButtonRotation = NO;
    tabBar.allowSubItemRotation = NO;
    tabBar.bloomAngel = 100;
    //kvc实质是修改了系统的_tabBar
    [self setValue:tabBar forKeyPath:@"tabBar"];
    
}

- (void)setUpAllChildVc {
    //TabbarController添加四个子控制器
    //首页
    TQHomeViewController *HomeVC = [[TQHomeViewController alloc] init];
    [self setUpOneChildVcWithVc:HomeVC Image:@"home" selectedImage:@"home" title:@"首页"];
    //赛程
    TQScheduleViewController *scheduleVC = [[TQScheduleViewController alloc] init];
    [self setUpOneChildVcWithVc:scheduleVC Image:@"schedule" selectedImage:@"schedule" title:@"赛程"];
    //天梯
    TQLadderViewController *ladderVC = [[TQLadderViewController alloc] init];
    [self setUpOneChildVcWithVc:ladderVC Image:@"ladder" selectedImage:@"ladder" title:@"天梯"];
    //我
    TQMeViewController *meVC = [[TQMeViewController alloc] init];
    [self setUpOneChildVcWithVc:meVC Image:@"me" selectedImage:@"me" title:@"我"];
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
    
    Vc.view.backgroundColor = RGB16(0xf0f6f2);
    
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
}

@end
