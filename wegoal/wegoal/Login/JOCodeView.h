//
//  JOCodeView.h
//
//  Created by joker on 2017/3/30.
//  Copyright © 2017年 joker. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JOCodeView : UIView

//输入完成的回调
@property (nonatomic, copy) void(^EditBlock)(NSString *text);

- (instancetype)initWithFrame:(CGRect)frame
                       number:(NSUInteger)number
                    lineColor:(UIColor *)lineColor
                    textColor:(UIColor *)textColor
                         font:(UIFont *)font;
- (void)beginEdit;
- (void)endEdit;

@end
