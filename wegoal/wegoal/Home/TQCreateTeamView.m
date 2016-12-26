//
//  TQCreateTeamView.m
//  wegoal
//
//  Created by joker on 2016/12/26.
//  Copyright © 2016年 xdkj. All rights reserved.
//

#import "TQCreateTeamView.h"

@interface TQCreateTeamView()

@property (weak, nonatomic) IBOutlet UIButton *joinButton;
@property (weak, nonatomic) IBOutlet UIButton *createButton;


@end

@implementation TQCreateTeamView

- (void)layoutSubviews
{
    [super layoutSubviews];
    _joinButton.layer.masksToBounds = YES;
    _joinButton.layer.cornerRadius = CGRectGetHeight(_joinButton.frame)/2;
    
    CAShapeLayer *borderLayer = [CAShapeLayer layer];
    borderLayer.bounds = _createButton.bounds;
    borderLayer.position = CGPointMake(CGRectGetMidX(_createButton.bounds), CGRectGetMidY(_createButton.bounds));
    borderLayer.path = [UIBezierPath bezierPathWithRoundedRect:borderLayer.bounds cornerRadius:CGRectGetWidth(borderLayer.bounds)/2].CGPath;
    borderLayer.lineWidth = 1.5f;
    borderLayer.lineDashPattern = @[@4, @2];
    borderLayer.strokeColor = kTitleTextColor.CGColor;
    borderLayer.fillColor = [UIColor clearColor].CGColor;
    
    [_createButton.layer addSublayer:borderLayer];
}

- (IBAction)joinTeam:(id)sender {
    NSLog(@"join team");
}

- (IBAction)createTeam:(id)sender {
    NSLog(@"create team");
}

@end
