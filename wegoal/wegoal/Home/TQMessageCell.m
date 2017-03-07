//
//  TQMessageCell.m
//  wegoal
//
//  Created by joker on 2017/3/7.
//  Copyright © 2017年 xdkj. All rights reserved.
//

#import "TQMessageCell.h"

@interface TQMessageCell()

@property (weak, nonatomic) IBOutlet UIImageView *messageImageView;
@property (weak, nonatomic) IBOutlet UILabel *messageTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *latestMessageLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;

@end

@implementation TQMessageCell

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
