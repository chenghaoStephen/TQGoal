//
//  TQCommon.m
//  wegoal
//
//  Created by joker on 2016/12/20.
//  Copyright © 2016年 xdkj. All rights reserved.
//

#import "TQCommon.h"

@implementation TQCommon

//根据颜色返回图片
+(UIImage*) imageWithColor:(UIColor*)color
{
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

@end
