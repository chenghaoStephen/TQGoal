//
//  TQWeightBackView.m
//  wegoal
//
//  Created by joker on 2017/2/14.
//  Copyright © 2017年 xdkj. All rights reserved.
//

#import "TQWeightBackView.h"

@implementation TQWeightBackView

- (void)drawRect:(CGRect)rect
{
    CGRect rectTmp = CGRectMake(rect.origin.x + .5, rect.origin.y + .5, rect.size.width - 1, rect.size.height - 1);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetStrokeColorWithColor(context, kBackLineColor.CGColor);
    CGContextSetLineWidth(context, 1.f);
    CGContextAddEllipseInRect(context, rectTmp);
    CGContextDrawPath(context, kCGPathStroke);
}


@end
