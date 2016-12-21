//
//  TQHomeMatchCell.m
//  wegoal
//
//  Created by joker on 2016/12/20.
//  Copyright © 2016年 xdkj. All rights reserved.
//

#import "TQHomeMatchCell.h"

@interface TQHomeMatchCell()

@property (nonatomic, strong) UILabel *label;

@end

@implementation TQHomeMatchCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.label];
    }
    return self;
}


- (UILabel *)label
{
    if (!_label) {
        _label = [[UILabel alloc] initWithFrame:CGRectMake(10, 50, SCREEN_WIDTH - 70, 90)];
        _label.font = [UIFont systemFontOfSize:20];
        _label.textAlignment = NSTextAlignmentCenter;
        _label.text = @"";
        _label.layer.masksToBounds = YES;
        _label.layer.cornerRadius = 45;
        CAShapeLayer *borderLayer = [CAShapeLayer layer];
        borderLayer.bounds = _label.bounds;
        borderLayer.position = CGPointMake(CGRectGetMidX(_label.bounds), CGRectGetMidY(_label.bounds));
        borderLayer.path = [UIBezierPath bezierPathWithRoundedRect:borderLayer.bounds cornerRadius:CGRectGetWidth(borderLayer.bounds)/2].CGPath;
        borderLayer.lineWidth = 1.f;
        borderLayer.lineDashPattern = @[@4, @2];
        borderLayer.strokeColor = [UIColor blackColor].CGColor;
        borderLayer.fillColor = [UIColor clearColor].CGColor;
        
        [_label.layer addSublayer:borderLayer];
        
    }
    return _label;
}

@end
