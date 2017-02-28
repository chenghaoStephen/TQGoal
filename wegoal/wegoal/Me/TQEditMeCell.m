//
//  TQEditMeCell.m
//  wegoal
//
//  Created by joker on 2017/2/20.
//  Copyright © 2017年 xdkj. All rights reserved.
//

#import "TQEditMeCell.h"

@implementation TQEditMeCell

-(void)drawRect:(CGRect)rect
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [UIColor whiteColor].CGColor);
    CGContextFillRect(context, rect);
    
    //下方添加一条分隔线
    CGContextSetStrokeColorWithColor(context, kMainBackColor.CGColor);
    CGContextStrokeRect(context, CGRectMake(0, rect.size.height - .5, rect.size.width, .5));
}

@end
