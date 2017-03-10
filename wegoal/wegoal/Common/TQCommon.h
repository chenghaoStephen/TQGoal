//
//  TQCommon.h
//  wegoal
//
//  Created by joker on 2016/12/20.
//  Copyright © 2016年 xdkj. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface TQCommon : NSObject

+ (UIImage*) imageWithColor:(UIColor*)color;

+ (BOOL)isBlankString:(NSString *)string;

+ (CGFloat)heightForString:(NSString *)value fontSize:(UIFont*)font andWidth:(CGFloat)width;

+ (CGFloat)widthForString:(NSString *)value fontSize:(UIFont*)font andHeight:(CGFloat)Height;

@end
