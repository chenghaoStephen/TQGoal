//
//  JOSelectMenuView.m
//  JOExample3
//
//  Created by joker on 2016/12/14.
//  Copyright © 2016年 joker. All rights reserved.
//

#import "JOSelectMenuView.h"

#define kMenuButtonWidth     ceil((SCREEN_WIDTH - 40.f)/7.f)
#define kMenuButtonBaseTag   1000

@interface JOSelectMenuView()
{
    NSMutableArray *stylesArray;
}

@end

@implementation JOSelectMenuView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
    }
    return self;
}

- (void)setMenuList:(NSArray *)menuList
{
    _menuList = menuList;
    stylesArray = [NSMutableArray arrayWithCapacity:menuList.count];
    for (NSInteger i = 0; i < menuList.count; i++) {
        //最多显示7个选项
        if (i >= 7) return;
        NSDictionary *data = menuList[i];
        UIButton *menuButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [menuButton setFrame:CGRectMake(10 + i*kMenuButtonWidth, 5, kMenuButtonWidth, 20)];
        [menuButton setTitle:data[@"string"] forState:UIControlStateNormal];
        menuButton.titleLabel.font = [UIFont systemFontOfSize:10.f];
        menuButton.tag = kMenuButtonBaseTag + i;
        [menuButton addTarget:self action:@selector(menuButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        menuButton.layer.masksToBounds = YES;
        [self addSubview:menuButton];
        [stylesArray addObject:@(MenuButtonStyleNone)];
    }
}

//清空选项
- (void)clearMenu
{
    for (NSInteger i = 0; i < _menuList.count; i++) {
        UIButton *menuButton = [self viewWithTag:(kMenuButtonBaseTag + i)];
        if (menuButton) {
            [self menuButton:menuButton setStyle:MenuButtonStyleNone];
            menuButton.selected = NO;
            menuButton.backgroundColor = [UIColor clearColor];
            [menuButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        }
    }
}


#pragma mark - 界面操作

- (void)menuButtonClick:(UIButton *)menuButton
{
    menuButton.selected = !menuButton.selected;
    NSInteger index = menuButton.tag - kMenuButtonBaseTag;
    UIButton *leftBtn;
    UIButton *rightBtn;
    if (index > 0) {
        leftBtn = (UIButton *)[self viewWithTag:(kMenuButtonBaseTag + index - 1)];
    }
    if (index < _menuList.count - 1) {
        rightBtn = (UIButton *)[self viewWithTag:(kMenuButtonBaseTag + index + 1)];
    }
    
    if (menuButton.selected) {
        menuButton.backgroundColor = [UIColor whiteColor];
        [menuButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        //根据左右item的选中状态，设置样式
        if (!leftBtn && rightBtn) {
            if (rightBtn.selected) {
                [self menuButton:menuButton setStyle:MenuButtonStyleRight];
                [self addLeftConnect:rightBtn];
            } else {
                [self menuButton:menuButton setStyle:MenuButtonStyleNone];
            }
        } else if (leftBtn && !rightBtn) {
            if (leftBtn.selected) {
                [self menuButton:menuButton setStyle:MenuButtonStyleLeft];
                [self addRightConnect:leftBtn];
            } else {
                [self menuButton:menuButton setStyle:MenuButtonStyleNone];
            }
        } else if (leftBtn && rightBtn) {
            if (leftBtn.selected && rightBtn.selected) {
                [self menuButton:menuButton setStyle:MenuButtonStyleAll];
                [self addRightConnect:leftBtn];
                [self addLeftConnect:rightBtn];
            } else if (!leftBtn.selected && rightBtn.selected) {
                [self menuButton:menuButton setStyle:MenuButtonStyleRight];
                [self addLeftConnect:rightBtn];
            } else if (leftBtn.selected && !rightBtn.selected) {
                [self menuButton:menuButton setStyle:MenuButtonStyleLeft];
                [self addRightConnect:leftBtn];
            } else {
                [self menuButton:menuButton setStyle:MenuButtonStyleNone];
            }
        } else {
            [self menuButton:menuButton setStyle:MenuButtonStyleNone];
        }
    } else {
        menuButton.backgroundColor = [UIColor clearColor];
        [menuButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        //根据左右item的选中状态，设置样式
        if (!leftBtn && rightBtn) {
            if (rightBtn.selected) {
                [self removeLeftConnect:rightBtn];
            }
        } else if (leftBtn && !rightBtn) {
            if (leftBtn.selected) {
                [self removeRightConnect:leftBtn];
            }
        } else if (leftBtn && rightBtn) {
            if (leftBtn.selected && rightBtn.selected) {
                [self removeRightConnect:leftBtn];
                [self removeLeftConnect:rightBtn];
            } else if (!leftBtn.selected && rightBtn.selected) {
                [self removeLeftConnect:rightBtn];
            } else if (leftBtn.selected && !rightBtn.selected) {
                [self removeRightConnect:leftBtn];
            }
        }
    }
    [self setMenuOptions];
}

- (void)setMenuOptions
{
    NSMutableArray *options = [NSMutableArray array];
    for (NSInteger i = 0; i < _menuList.count; i++) {
        UIButton *menuButton = [self viewWithTag:(kMenuButtonBaseTag + i)];
        if (menuButton && menuButton.selected) {
            [options addObject:_menuList[i][@"key"]];
        }
    }
    if (_delegate && [_delegate respondsToSelector:@selector(JOSelectMenuView:setOptions:)]) {
        [_delegate JOSelectMenuView:self setOptions:options];
    }
}

- (void)addLeftConnect:(UIButton *)menuButton
{
    NSInteger index = menuButton.tag - kMenuButtonBaseTag;
    MenuButtonStyle style = [stylesArray[index] integerValue];
    
    if (style == MenuButtonStyleNone) {
        [self menuButton:menuButton setStyle:MenuButtonStyleLeft];
    } else if (style == MenuButtonStyleRight) {
        [self menuButton:menuButton setStyle:MenuButtonStyleAll];
    }
}

- (void)addRightConnect:(UIButton *)menuButton
{
    NSInteger index = menuButton.tag - kMenuButtonBaseTag;
    MenuButtonStyle style = [stylesArray[index] integerValue];
    
    if (style == MenuButtonStyleNone) {
        [self menuButton:menuButton setStyle:MenuButtonStyleRight];
    } else if (style == MenuButtonStyleLeft) {
        [self menuButton:menuButton setStyle:MenuButtonStyleAll];
    }
}

- (void)removeLeftConnect:(UIButton *)menuButton
{
    NSInteger index = menuButton.tag - kMenuButtonBaseTag;
    MenuButtonStyle style = [stylesArray[index] integerValue];
    
    if (style == MenuButtonStyleLeft) {
        [self menuButton:menuButton setStyle:MenuButtonStyleNone];
    } else if (style == MenuButtonStyleAll) {
        [self menuButton:menuButton setStyle:MenuButtonStyleRight];
    }
}

- (void)removeRightConnect:(UIButton *)menuButton
{
    NSInteger index = menuButton.tag - kMenuButtonBaseTag;
    MenuButtonStyle style = [stylesArray[index] integerValue];
    
    if (style == MenuButtonStyleRight) {
        [self menuButton:menuButton setStyle:MenuButtonStyleNone];
    } else if (style == MenuButtonStyleAll) {
        [self menuButton:menuButton setStyle:MenuButtonStyleLeft];
    }
}

- (void)menuButton:(UIButton *)menuButton setStyle:(MenuButtonStyle)style
{
    //设置圆角
    switch (style) {
        case MenuButtonStyleNone:
            [menuButton addRoundedCorners:UIRectCornerAllCorners withRadii:CGSizeMake(10, 10)];
            break;
        case MenuButtonStyleLeft:
            [menuButton addRoundedCorners:UIRectCornerBottomRight | UIRectCornerTopRight withRadii:CGSizeMake(10, 10)];
            break;
        case MenuButtonStyleRight:
            [menuButton addRoundedCorners:UIRectCornerBottomLeft | UIRectCornerTopLeft withRadii:CGSizeMake(10, 10)];
            break;
        case MenuButtonStyleAll:
            [menuButton addRoundedCorners:UIRectCornerAllCorners withRadii:CGSizeZero];
            break;
            
        default:
            break;
    }
    //本地存储
    NSInteger index = menuButton.tag - kMenuButtonBaseTag;
    stylesArray[index] = @(style);
}


@end
