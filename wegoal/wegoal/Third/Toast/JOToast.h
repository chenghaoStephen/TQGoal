//
//  JOToast.h
//  wegoal
//
//  Created by joker on 2017/5/5.
//  Copyright © 2017年 xdkj. All rights reserved.
//

#import <UIKit/UIKit.h>
#define DEFAULT_DISPLAY_DURATION 2.0f
@interface JOToastButton:UIButton{
    
}
@end
@interface JOToast : NSObject {
    NSString *text;
    UIButton *contentView;
    CGFloat  duration;
}

+ (void)showWithText:(NSString *) text_;
+ (void)showWithText:(NSString *) text_
            duration:(CGFloat)duration_;

+ (void)showWithText:(NSString *) text_
           topOffset:(CGFloat) topOffset_;
+ (void)showWithText:(NSString *) text_
           topOffset:(CGFloat) topOffset
            duration:(CGFloat) duration_;

+ (void)showWithText:(NSString *) text_
        bottomOffset:(CGFloat) bottomOffset_;
+ (void)showWithText:(NSString *) text_
        bottomOffset:(CGFloat) bottomOffset_
            duration:(CGFloat) duration_;
+ (void)showWithText:(NSString *)text_
            duration:(CGFloat)duration_ inView:(UIView*)view;
+ (void)showHorizontalWithText:(NSString *)text_
                      duration:(CGFloat)duration_ inView:(UIView*)view;
@end
