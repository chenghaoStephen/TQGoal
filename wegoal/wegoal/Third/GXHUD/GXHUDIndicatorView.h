//
//  GXHUDIndicatorView.h
//  GXHUDIndicatorView
//
//  Created by zhengdongming on 16/3/9.
//  Copyright © 2016年 MING.Z. All rights reserved.
//

#import <UIKit/UIKit.h>
#define animationTime   0.5
#define hiddenHudAnimationTime  0.5
#define defaultArcColor   UIColor.redColor()
#define viewCornerRadius 4.0
@interface GXHUDIndicatorView : UIView
+ (void)showInView:(UIView*)superView;
+ (void)showInView:(UIView*)superView withEnable:(BOOL)enable;
+ (void)hiddenInView:(UIView *)superView;
@end
