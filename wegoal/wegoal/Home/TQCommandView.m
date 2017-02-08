//
//  TQCommandView.m
//  wegoal
//
//  Created by joker on 2016/12/20.
//  Copyright © 2016年 xdkj. All rights reserved.
//

#import "TQCommandView.h"
#import "TQMatchCell.h"

@interface TQCommandView ()

@property (nonatomic, strong) UIView *topView;
@property (nonatomic, strong) TQMatchCell *matchCell;

@end

@implementation TQCommandView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.topView];
        [self addSubview:self.matchCell];
    }
    return self;
}

- (UIView *)topView
{
    if (!_topView) {
        _topView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 21)];
        _topView.backgroundColor = [UIColor whiteColor];
        
        UIImageView *scheduleImageView = [[UIImageView alloc] initWithFrame:CGRectMake(8, 8, 13, 13)];
        scheduleImageView.image = [UIImage imageNamed:@"schedule_sign"];
        [_topView addSubview:scheduleImageView];
        
        UILabel *scheduleLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(scheduleImageView.frame) + 5, 8, 100, 13)];
        scheduleLabel.font = [UIFont systemFontOfSize:12.f];
        scheduleLabel.textColor = kTitleTextColor;
        scheduleLabel.textAlignment = NSTextAlignmentLeft;
        scheduleLabel.text = @"推荐约战";
        [_topView addSubview:scheduleLabel];
        
        UIButton *moreButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [moreButton setImage:[UIImage imageNamed:@"more_match"] forState:UIControlStateNormal];
        [moreButton setFrame:CGRectMake(SCREEN_WIDTH - 25, 5, 20, 20)];
        [moreButton addTarget:self action:@selector(showMoreMatch) forControlEvents:UIControlEventTouchUpInside];
        [_topView addSubview:moreButton];
    }
    return _topView;
}

- (TQMatchCell *)matchCell
{
    if (!_matchCell) {
        _matchCell = [[[NSBundle mainBundle] loadNibNamed:@"TQMatchCell" owner:nil options:nil] firstObject];
        [_matchCell setFrame:CGRectMake(0, CGRectGetMaxY(_topView.frame), SCREEN_WIDTH, 135)];
    }
    return _matchCell;
}


#pragma mark - events

- (void)showMoreMatch
{
    
}


@end
