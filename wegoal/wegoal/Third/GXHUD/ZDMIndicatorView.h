//
//  ZDMIndicator.h
//  ZDzhihuIndicator
//
//  Created by MING.Z on 15-4-2.
//  Copyright (c) 2015年 blurryssky. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef enum {
    
    ZDMIndicatorStyleNormal,// 类似系统一直循环
    ZDMIndicatorStyleGradual// 渐变循环
}ZDMIndicatorViewStyle;

@interface ZDMIndicatorView : UIView
+ (void)showInView:(UIView*)superView;
+ (void)showInView:(UIView*)superView animationStyle:(ZDMIndicatorViewStyle)style;
+ (void)hiddenInView:(UIView *)superView;
// ebale = YES,等待过程能交互，NO等待过程不能交互，默认NO
+ (void)showInView:(UIView*)superView canUserEnable:(BOOL)enable;

@end
