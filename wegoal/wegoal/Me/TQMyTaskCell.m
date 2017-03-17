//
//  TQMyTaskCell.m
//  wegoal
//
//  Created by joker on 2017/3/17.
//  Copyright © 2017年 xdkj. All rights reserved.
//

#import "TQMyTaskCell.h"

@interface TQMyTaskCell()

@property (weak, nonatomic) IBOutlet UIImageView *signImageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *task1Label;
@property (weak, nonatomic) IBOutlet UILabel *task2Label;
@property (weak, nonatomic) IBOutlet UILabel *task3Label;
@property (weak, nonatomic) IBOutlet UIButton *actionButton;


@end

@implementation TQMyTaskCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    _actionButton.layer.masksToBounds = YES;
    _actionButton.layer.cornerRadius = _actionButton.height/2;
    
}

- (void)drawRect:(CGRect)rect
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [UIColor whiteColor].CGColor);
    CGContextFillRect(context, rect);
    
    //下方添加一条分隔线
    CGContextSetStrokeColorWithColor(context, kMainBackColor.CGColor);
    CGContextStrokeRect(context, CGRectMake(0, rect.size.height - .5, rect.size.width, .5));
}


@end
