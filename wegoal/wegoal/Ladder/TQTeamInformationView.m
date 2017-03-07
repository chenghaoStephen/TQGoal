//
//  TQTeamInformationView.m
//  wegoal
//
//  Created by joker on 2017/3/7.
//  Copyright © 2017年 xdkj. All rights reserved.
//

#import "TQTeamInformationView.h"

@interface TQTeamInformationView()

@property (strong, nonatomic) UIImageView *logoImageView;
@property (strong, nonatomic) UIImageView *decorationImageView;
@property (strong, nonatomic) UILabel *nameLabel;
@property (strong, nonatomic) UILabel *rankLabel;
@property (strong, nonatomic) UILabel *matchNumlabel;
@property (strong, nonatomic) UILabel *winLabel;
@property (strong, nonatomic) UILabel *loseLabel;
@property (strong, nonatomic) UILabel *tieLabel;
@property (strong, nonatomic) UIImageView *yellowImageView;
@property (strong, nonatomic) UILabel *yellowCountLabel;
@property (strong, nonatomic) UIImageView *redImageView;
@property (strong, nonatomic) UILabel *redCountLabel;
@property (strong, nonatomic) UILabel *heightLabel;
@property (strong, nonatomic) UILabel *weightLabel;
@property (strong, nonatomic) UILabel *ageLabel;

@end

@implementation TQTeamInformationView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.decorationImageView];
        [self addSubview:self.logoImageView];
//        [self addSubview:self.nameLabel];
//        [self addSubview:self.rankLabel];
//        [self addSubview:self.matchNumlabel];
//        [self addSubview:self.winLabel];
//        [self addSubview:self.loseLabel];
//        [self addSubview:self.tieLabel];
//        [self addSubview:self.yellowImageView];
//        [self addSubview:self.yellowCountLabel];
//        [self addSubview:self.redImageView];
//        [self addSubview:self.redCountLabel];
//        [self addSubview:self.heightLabel];
//        [self addSubview:self.weightLabel];
//        [self addSubview:self.ageLabel];
    }
    return self;
}

- (UIImageView *)logoImageView
{
    if (!_logoImageView) {
        _logoImageView = [[UIImageView alloc] init];
    }
    return _logoImageView;
}

- (UIImageView *)decorationImageView
{
    if (!_decorationImageView) {
        _decorationImageView = [[UIImageView alloc] init];
        _decorationImageView.image = [UIImage imageNamed:@"decoration"];
    }
    return _decorationImageView;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    //logo
    [_logoImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).with.offset(35 * SCALE375);
        make.size.mas_equalTo(CGSizeMake(47, 47));
        make.centerY.equalTo(self.mas_centerY);
    }];
    
    //战徽
    [_decorationImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(_logoImageView.mas_centerX);
        make.centerY.equalTo(_logoImageView.mas_centerY).with.offset(13.5);
        make.size.mas_equalTo(CGSizeMake(67, 42));
    }];
}


@end
