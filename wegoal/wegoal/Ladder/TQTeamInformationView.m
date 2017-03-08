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
@property (strong, nonatomic) UIImageView *yellowImageView;
@property (strong, nonatomic) UILabel *yellowCountLabel;
@property (strong, nonatomic) UIImageView *redImageView;
@property (strong, nonatomic) UILabel *redCountLabel;
@property (strong, nonatomic) UILabel *rankLabel;
@property (strong, nonatomic) UILabel *matchNumlabel;
@property (strong, nonatomic) UILabel *winLabel;
@property (strong, nonatomic) UILabel *loseLabel;
@property (strong, nonatomic) UILabel *tieLabel;
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
        [self addSubview:self.nameLabel];
        [self addSubview:self.yellowImageView];
        [self addSubview:self.yellowCountLabel];
        [self addSubview:self.redImageView];
        [self addSubview:self.redCountLabel];
        [self addSubview:self.rankLabel];
        [self addSubview:self.matchNumlabel];
        [self addSubview:self.winLabel];
        [self addSubview:self.loseLabel];
        [self addSubview:self.tieLabel];
        [self addSubview:self.heightLabel];
        [self addSubview:self.weightLabel];
        [self addSubview:self.ageLabel];
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

- (UILabel *)nameLabel
{
    if (!_nameLabel) {
        _nameLabel = [[UILabel alloc] init];
        _nameLabel.textColor = [UIColor whiteColor];
        _nameLabel.font = [UIFont systemFontOfSize:13.f];
        _nameLabel.text = @"---";
    }
    return _nameLabel;
}

- (UIImageView *)yellowImageView
{
    if (!_yellowImageView) {
        _yellowImageView = [[UIImageView alloc] init];
        _yellowImageView.backgroundColor = RGB16(0xFED030);
        _yellowImageView.layer.masksToBounds = YES;
        _yellowImageView.layer.cornerRadius = 1.5;
    }
    return _yellowImageView;
}

- (UILabel *)yellowCountLabel
{
    if (!_yellowCountLabel) {
        _yellowCountLabel = [[UILabel alloc] init];
        _yellowCountLabel.textColor = [UIColor whiteColor];
        _yellowCountLabel.font = [UIFont systemFontOfSize:12.f];
        _yellowCountLabel.text = @"--";
    }
    return _yellowCountLabel;
}

- (UIImageView *)redImageView
{
    if (!_redImageView) {
        _redImageView = [[UIImageView alloc] init];
        _redImageView.backgroundColor = RGB16(0xF65A61);
        _redImageView.layer.masksToBounds = YES;
        _redImageView.layer.cornerRadius = 1.5;
    }
    return _redImageView;
}

- (UILabel *)redCountLabel
{
    if (!_redCountLabel) {
        _redCountLabel = [[UILabel alloc] init];
        _redCountLabel.textColor = [UIColor whiteColor];
        _redCountLabel.font = [UIFont systemFontOfSize:12.f];
        _redCountLabel.text = @"--";
    }
    return _redCountLabel;
}

- (UILabel *)rankLabel
{
    if (!_rankLabel) {
        _rankLabel = [[UILabel alloc] init];
        _rankLabel.textColor = [UIColor whiteColor];
        _rankLabel.font = [UIFont fontWithName:@"System-Semibold" size:19.f];
        _rankLabel.text = @"---";
    }
    return _rankLabel;
}

- (UILabel *)matchNumlabel
{
    if (!_matchNumlabel) {
        _matchNumlabel = [[UILabel alloc] init];
        _matchNumlabel.textColor = [UIColor whiteColor];
        _matchNumlabel.font = [UIFont systemFontOfSize:12.f];
        _matchNumlabel.text = @"--";
    }
    return _matchNumlabel;
}

- (UILabel *)winLabel
{
    if (!_winLabel) {
        _winLabel = [[UILabel alloc] init];
        _winLabel.textColor = [UIColor whiteColor];
        _winLabel.font = [UIFont systemFontOfSize:12.f];
        _winLabel.text = @"--";
    }
    return _winLabel;
}

- (UILabel *)loseLabel
{
    if (!_loseLabel) {
        _loseLabel = [[UILabel alloc] init];
        _loseLabel.textColor = [UIColor whiteColor];
        _loseLabel.font = [UIFont systemFontOfSize:12.f];
        _loseLabel.text = @"--";
    }
    return _loseLabel;
}

- (UILabel *)tieLabel
{
    if (!_tieLabel) {
        _tieLabel = [[UILabel alloc] init];
        _tieLabel.textColor = [UIColor whiteColor];
        _tieLabel.font = [UIFont systemFontOfSize:12.f];
        _tieLabel.text = @"--";
    }
    return _tieLabel;
}

- (UILabel *)heightLabel
{
    if (!_heightLabel) {
        _heightLabel = [[UILabel alloc] init];
        _heightLabel.textColor = [UIColor whiteColor];
        _heightLabel.font = [UIFont systemFontOfSize:12.f];
        _heightLabel.text = @"--";
    }
    return _heightLabel;
}

- (UILabel *)weightLabel
{
    if (!_weightLabel) {
        _weightLabel = [[UILabel alloc] init];
        _weightLabel.textColor = [UIColor whiteColor];
        _weightLabel.font = [UIFont systemFontOfSize:12.f];
        _weightLabel.text = @"--";
    }
    return _weightLabel;
}

- (UILabel *)ageLabel
{
    if (!_ageLabel) {
        _ageLabel = [[UILabel alloc] init];
        _ageLabel.textColor = [UIColor whiteColor];
        _ageLabel.font = [UIFont systemFontOfSize:12.f];
        _ageLabel.text = @"--";
    }
    return _ageLabel;
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
    
    //队名
    [_nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_logoImageView.mas_top).with.offset(-3);
        make.left.equalTo(_logoImageView.mas_right).with.offset(26 * SCALE375);
        make.height.mas_equalTo(16);
    }];
    
    //黄牌标识
    [_yellowImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_nameLabel.mas_right).with.offset(10);
        make.size.mas_equalTo(CGSizeMake(10, 12));
        make.centerY.equalTo(_nameLabel.mas_centerY);
    }];
    
    //黄牌
    [_yellowCountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_yellowImageView.mas_right).with.offset(5);
        make.height.mas_equalTo(16);
        make.centerY.equalTo(_nameLabel.mas_centerY);
    }];
    
    //红牌标识
    [_redImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_yellowCountLabel.mas_right).with.offset(10);
        make.size.mas_equalTo(CGSizeMake(10, 12));
        make.centerY.equalTo(_nameLabel.mas_centerY);
    }];
    
    //红牌
    [_redCountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_redImageView.mas_right).with.offset(5);
        make.height.mas_equalTo(16);
        make.centerY.equalTo(_nameLabel.mas_centerY);
    }];
    
    //等级
    [_rankLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_nameLabel.mas_bottom).with.offset(5);
        make.height.mas_equalTo(20);
        make.left.equalTo(_nameLabel.mas_left);
    }];
    
    //比赛
    [_matchNumlabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_rankLabel.mas_bottom).with.offset(5);
        make.height.mas_equalTo(16);
        make.left.equalTo(_nameLabel.mas_left);
    }];
    
    //胜
    [_winLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_matchNumlabel.mas_top);
        make.bottom.equalTo(_matchNumlabel.mas_bottom);
        make.left.equalTo(_matchNumlabel.mas_right).with.offset(8);
        make.width.equalTo(_matchNumlabel.mas_width);
    }];
    
    //负
    [_loseLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_matchNumlabel.mas_top);
        make.bottom.equalTo(_matchNumlabel.mas_bottom);
        make.left.equalTo(_winLabel.mas_right).with.offset(8);
        make.width.equalTo(_matchNumlabel.mas_width);
    }];
    
    //平
    [_tieLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_matchNumlabel.mas_top);
        make.bottom.equalTo(_matchNumlabel.mas_bottom);
        make.left.equalTo(_loseLabel.mas_right).with.offset(8);
        make.width.equalTo(_matchNumlabel.mas_width);
        make.right.equalTo(self.mas_right).with.offset(-12);
    }];
    
    //身高
    [_heightLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_matchNumlabel.mas_bottom).with.offset(5);
        make.height.mas_equalTo(16);
        make.left.equalTo(_nameLabel.mas_left);
    }];
    
    //体重
    [_weightLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_heightLabel.mas_top);
        make.bottom.equalTo(_heightLabel.mas_bottom);
        make.left.equalTo(_heightLabel.mas_right).with.offset(5);
        make.width.equalTo(_heightLabel.mas_width);
    }];
    
    //年龄
    [_ageLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_heightLabel.mas_top);
        make.bottom.equalTo(_heightLabel.mas_bottom);
        make.left.equalTo(_weightLabel.mas_right).with.offset(5);
        make.width.equalTo(_heightLabel.mas_width);
        make.right.equalTo(self.mas_right).with.offset(-12);
    }];
    
}

- (void)setViewMode:(TeamTopViewMode)viewMode
{
    _viewMode = viewMode;
    if (viewMode == TeamTopViewModeLadder) {
        _decorationImageView.hidden = NO;
        _yellowImageView.hidden = YES;
        _yellowCountLabel.hidden = YES;
        _redImageView.hidden = YES;
        _redCountLabel.hidden = YES;
        _heightLabel.hidden = YES;
        _weightLabel.hidden = YES;
        _ageLabel.hidden = YES;
    } else {
        _decorationImageView.hidden = YES;
        _yellowImageView.hidden = NO;
        _yellowCountLabel.hidden = NO;
        _redImageView.hidden = NO;
        _redCountLabel.hidden = NO;
        _heightLabel.hidden = NO;
        _weightLabel.hidden = NO;
        _ageLabel.hidden = NO;
    }
}

- (void)setTeamInfo:(TQMatchModel *)teamInfo
{
    _teamInfo = teamInfo;
}


#pragma mark - events


@end











