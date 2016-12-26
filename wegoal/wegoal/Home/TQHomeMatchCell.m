//
//  TQHomeMatchCell.m
//  wegoal
//
//  Created by joker on 2016/12/20.
//  Copyright © 2016年 xdkj. All rights reserved.
//

#import "TQHomeMatchCell.h"
#import "TQCreateTeamView.h"
#import "TQMatchStatusView.h"

@interface TQHomeMatchCell()

@property (nonatomic, strong) TQCreateTeamView *createView;
@property (nonatomic, strong) TQMatchStatusView *matchView;

@end

@implementation TQHomeMatchCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.createView];
        [self addSubview:self.matchView];
    }
    return self;
}

- (void)setStatus:(MatchStatus)status
{
    _status = status;
    if (status == MatchStatusNewJoiner) {
        _createView.hidden = NO;
        _matchView.hidden = YES;
    } else {
        _createView.hidden = YES;
        _matchView.hidden = NO;
        _matchView.status = status;
    }
}

- (TQCreateTeamView *)createView
{
    if (!_createView) {
        _createView = [[TQCreateTeamView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH - 50, 190)];
        _createView.backgroundColor = [UIColor clearColor];
    }
    return _createView;
}

- (TQMatchStatusView *)matchView
{
    if (!_matchView) {
        _matchView = [[TQMatchStatusView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH - 50, 190)];
        _matchView.backgroundColor = [UIColor clearColor];
    }
    return _matchView;
}

@end
