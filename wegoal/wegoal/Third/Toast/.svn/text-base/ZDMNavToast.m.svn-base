//
//  ZDMNavToast.m
//  ChinaFinance
//
//  Created by zhengdongming on 2016/12/8.
//  Copyright © 2016年 GuoXinHuiJin. All rights reserved.
//

#import "ZDMNavToast.h"
#import <QuartzCore/QuartzCore.h>
@implementation ZDMNavToastButton
@end
@interface ZDMNavToast (private)

- (id)initWithText:(NSString *)text_;
- (void)setDuration:(CGFloat) duration_;
- (void)setTopOffSet:(CGFloat)topOff_;
- (void)dismisToast;
- (void)toastTaped:(UIButton *)sender_;

- (void)showAnimation;
- (void)hideAnimation;

@end


@implementation ZDMNavToast


- (id)initWithText:(NSString *)text_{
    if (self = [super init]) {
        
        text = [text_ copy];
        
        UIFont *font = [UIFont systemFontOfSize:15];

        UILabel *textLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 50)];
        textLabel.backgroundColor = [UIColor clearColor];
        textLabel.textColor = [UIColor whiteColor];
        textLabel.textAlignment = NSTextAlignmentCenter;
        textLabel.numberOfLines = 2;
        textLabel.minimumScaleFactor = 0.5;
        textLabel.adjustsFontSizeToFitWidth = YES;
        textLabel.font = font;
        textLabel.text = text;
        textLabel.numberOfLines = 0;
        
        contentView = [[ZDMToastButton alloc] initWithFrame:CGRectMake(0, 0, textLabel.frame.size.width, textLabel.frame.size.height)];
//        contentView.layer.cornerRadius = 5.0f;
//        contentView.layer.borderWidth = 1.0f;
//        contentView.layer.borderColor = [[UIColor grayColor] colorWithAlphaComponent:0.5].CGColor;
        contentView.backgroundColor = [UIColor colorWithRed:0.0f
                                                      green:0.0f
                                                       blue:0.0f
                                                      alpha:0.75f];
        [contentView addSubview:textLabel];
        contentView.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        [contentView addTarget:self
                        action:@selector(toastTaped:)
              forControlEvents:UIControlEventTouchDown];
        contentView.alpha = 0.0f;
        
        duration = DEFAULT_DISPLAY_DURATION;
        
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(deviceOrientationDidChanged:)
                                                     name:UIDeviceOrientationDidChangeNotification
                                                   object:[UIDevice currentDevice]];
    }
    return self;
}

- (void)deviceOrientationDidChanged:(NSNotification *)notify_{
    [self hideAnimation];
}

-(void)dismissToast{
    [contentView removeFromSuperview];
    [[NSNotificationCenter defaultCenter]removeObserver:self name:UIDeviceOrientationDidChangeNotification object:[UIDevice currentDevice]];
}

-(void)toastTaped:(UIButton *)sender_{
    [self hideAnimation];
}

- (void)setDuration:(CGFloat) duration_{
    duration = duration_;
}
- (void)setTopOffSet:(CGFloat)topOff_{
    
}
-(void)showAnimation{
    [UIView beginAnimations:@"show" context:NULL];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseIn];
    [UIView setAnimationDuration:0.3];
    contentView.alpha = 1.0f;
    [UIView commitAnimations];
}

-(void)hideAnimation{
    [UIView beginAnimations:@"hide" context:NULL];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseOut];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDidStopSelector:@selector(dismissToast)];
    [UIView setAnimationDuration:0.3];
    contentView.alpha = 0.0f;
    [UIView commitAnimations];
}


+ (void)showWithText:(NSString *)text_ inView:(UIView*)view{
    [ZDMNavToast showWithText:text_ topOffset:0 duration:DEFAULT_DISPLAY_DURATION inView:view];
}

+ (void)showWithText:(NSString *)text_
            duration:(CGFloat)duration_ inView:(UIView*)view{
    [ZDMNavToast showWithText:text_ topOffset:0 duration:duration_ inView:view];

}


+ (void)showWithText:(NSString *)text_
           topOffset:(CGFloat)topOffset_
            duration:(CGFloat)duration_ inView:(UIView*)view{
    ZDMNavToast *toast = [[ZDMNavToast alloc] initWithText:text_];
    [toast setDuration:duration_];
    [toast setTopOffSet:topOffset_];
    [toast showInView:view];
}

- (void)showInView:(UIView*)view{
    contentView.top = topOff;
    for (UIView *view in [view subviews]) {
        if ([view isKindOfClass:[ZDMNavToastButton class]]) {
            ((ZDMNavToastButton*)view).hidden = YES;
        }
    }
    [view  addSubview:contentView];
    [self showAnimation];
    [self performSelector:@selector(hideAnimation) withObject:nil afterDelay:duration];
    
}

@end
