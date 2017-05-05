//
//  JOIndicatorView.h
//  wegoal
//
//  Created by joker on 2017/5/5.
//  Copyright © 2017年 xdkj. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef NS_ENUM(NSInteger, JOIndicatorViewStyle) {
    JOIndicatorStyleNormal,// 类似系统一直循环
    JOIndicatorStyleGradual// 渐变循环
};

@interface JOIndicatorView : UIView
+ (void)showInView:(UIView*)superView;
+ (void)showInView:(UIView*)superView animationStyle:(JOIndicatorViewStyle)style;
+ (void)hiddenInView:(UIView *)superView;
// ebale = YES,等待过程能交互，NO等待过程不能交互，默认NO
+ (void)showInView:(UIView*)superView canUserEnable:(BOOL)enable;

@end
