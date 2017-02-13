//
//  TQTabBar.h
//  wegoal
//
//  Created by joker on 2016/11/27.
//  Copyright © 2016年 xdkj. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZYPathButton.h"

@class TQTabBar;
@protocol TQTabBarDelegate <NSObject>
@required
- (void)pathButton:(TQTabBar *)TQTabBar clickItemButtonAtIndex:(NSUInteger)itemButtonIndex;
@end

@interface TQTabBar : UITabBar

/** 点中button代理属性 */
@property (nonatomic , weak) id<TQTabBarDelegate> tabDelegate;

/** 所有的弹出按钮 */
@property (nonatomic , strong)NSArray<ZYPathItemButton *> *pathButtonArray;

/** 弹出动画时间*/
@property (assign, nonatomic) NSTimeInterval basicDuration;

/** 设置弹出时是否旋转   */
@property (assign, nonatomic) BOOL allowSubItemRotation;

/**  设置底部弹出的半径，默认是105 */
@property (assign, nonatomic) CGFloat bloomRadius;

/**  设置散开的角度 */
@property (assign, nonatomic) CGFloat bloomAngel;

/**  设置中间的按钮是否旋转 */
@property (assign, nonatomic) BOOL allowCenterButtonRotation;

/**  显示中间的按钮 */
- (void)showPlusButton;

/**  隐藏中间的按钮 */
- (void)hidePlusButton;

@end
