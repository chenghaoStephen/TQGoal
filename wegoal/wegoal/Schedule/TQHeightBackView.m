//
//  TQHeightBackView.m
//  wegoal
//
//  Created by joker on 2017/2/14.
//  Copyright © 2017年 xdkj. All rights reserved.
//

#import "TQHeightBackView.h"

@implementation TQHeightBackView

- (void)drawRect:(CGRect)rect
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetStrokeColorWithColor(context, kBackLineColor.CGColor);
    CGContextSetLineWidth(context, 1.f);
    CGContextMoveToPoint(context, CGRectGetMinX(rect), CGRectGetMinY(rect));
    CGContextAddLineToPoint(context, CGRectGetMaxX(rect), CGRectGetMinY(rect));
    CGContextMoveToPoint(context, CGRectGetWidth(rect)/2 - 0.5, CGRectGetMinY(rect));
    CGContextAddLineToPoint(context, CGRectGetWidth(rect)/2 - 0.5, CGRectGetMaxY(rect));
    CGContextMoveToPoint(context, CGRectGetMinX(rect), CGRectGetMaxY(rect));
    CGContextAddLineToPoint(context, CGRectGetMaxX(rect), CGRectGetMaxY(rect));
    CGContextStrokePath(context);
}

@end
