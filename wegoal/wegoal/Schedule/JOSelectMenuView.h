//
//  JOSelectMenuView.h
//  JOExample3
//
//  Created by joker on 2016/12/14.
//  Copyright © 2016年 joker. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, MenuButtonStyle){
    MenuButtonStyleNone = 0,  //两侧均不连通
    MenuButtonStyleLeft,      //左侧连通，右侧圆角
    MenuButtonStyleRight,     //右侧连通，左侧圆角
    MenuButtonStyleAll        //两侧均连通
};

@class JOSelectMenuView;
@protocol JOSelectMenuViewDelegate <NSObject>

@required
//设置选项
- (void)JOSelectMenuView:(JOSelectMenuView *)selectMenuView setOptions:(NSArray *)options;

@end

@interface JOSelectMenuView : UIView

@property (nonatomic, copy) NSArray *menuList;

@property (nonatomic, weak) id<JOSelectMenuViewDelegate> delegate;

- (void)clearMenu;

@end
