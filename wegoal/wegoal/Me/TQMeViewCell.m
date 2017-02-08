//
//  TQMeViewCell.m
//  wegoal
//
//  Created by joker on 2017/2/8.
//  Copyright © 2017年 xdkj. All rights reserved.
//

#import "TQMeViewCell.h"

@interface TQMeViewCell()
@property (weak, nonatomic) IBOutlet UIImageView *signImageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@end

@implementation TQMeViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
}

-(void)drawRect:(CGRect)rect
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [UIColor whiteColor].CGColor);
    CGContextFillRect(context, rect);
    
    //下方添加一条分隔线
    CGContextSetStrokeColorWithColor(context, kMainBackColor.CGColor);
    CGContextStrokeRect(context, CGRectMake(0, rect.size.height - .5, rect.size.width, .5));
}

- (void)setSignName:(NSString *)signName
{
    _signName = signName;
    _signImageView.image = [UIImage imageNamed:signName];
}

- (void)setTitleName:(NSString *)titleName
{
    _titleName = titleName;
    _titleLabel.text = titleName;
}


@end
