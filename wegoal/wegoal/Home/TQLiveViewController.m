//
//  TQLiveViewController.m
//  wegoal
//
//  Created by joker on 2017/4/2.
//  Copyright © 2017年 xdkj. All rights reserved.
//

#import "TQLiveViewController.h"
#import "TQPlayBackTableView.h"

@interface TQLiveViewController ()

@property (nonatomic, strong) UIView *headerView;
@property (nonatomic, strong) UIButton *backButton;
@property (nonatomic, strong) UIButton *shareButton;
@property (nonatomic, strong) UILabel *team1NameLbl;
@property (nonatomic, strong) UILabel *team2NameLbl;
@property (nonatomic, strong) UILabel *team1ScoreLbl;
@property (nonatomic, strong) UILabel *team2ScoreLbl;
@property (nonatomic, strong) UIView *competeView;
@property (nonatomic, strong) UILabel *timeLbl;
@property (nonatomic, strong) TQPlayBackTableView *liveTableView;

@end

@implementation TQLiveViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.headerView];
    [self.view addSubview:self.liveTableView];
}


- (UIView *)headerView
{
    if (!_headerView) {
        _headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 250)];
        //添加背景
        UIImageView *topBackView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 125)];
        topBackView.backgroundColor = kSubjectBackColor;
        [_headerView addSubview:topBackView];
        UIImageView *bottomBackView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 125, SCREEN_WIDTH, 125)];
        bottomBackView.backgroundColor = kLiveBackColor;
        [_headerView addSubview:bottomBackView];
        //添加子视图
        [_headerView addSubview:self.backButton];
        [_headerView addSubview:self.shareButton];
        [_headerView addSubview:self.competeView];
        [_headerView addSubview:self.team1ScoreLbl];
        [_headerView addSubview:self.team2ScoreLbl];
        [_headerView addSubview:self.team1NameLbl];
        [_headerView addSubview:self.team2NameLbl];
        [_headerView addSubview:self.timeLbl];
    }
    return _headerView;
}

- (UIButton *)backButton
{
    if (!_backButton) {
        _backButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_backButton setFrame:CGRectMake(8, 20, 44, 44)];
        [_backButton setImage:[UIImage imageNamed:@"schedule_back"] forState:UIControlStateNormal];
        [_backButton addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _backButton;
}

- (UIButton *)shareButton
{
    if (!_shareButton) {
        _shareButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_shareButton setFrame:CGRectMake(SCREEN_WIDTH - 52, 20, 44, 44)];
        [_shareButton setImage:[UIImage imageNamed:@"schedule_share"] forState:UIControlStateNormal];
        [_shareButton addTarget:self action:@selector(shareAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _shareButton;
}

- (UIView *)competeView
{
    if (!_competeView) {
        _competeView = [[UIView alloc] initWithFrame:CGRectMake((SCREEN_WIDTH - 25)/2, 122, 25, 6)];
        _competeView.backgroundColor = [UIColor whiteColor];
    }
    return _competeView;
}

- (UILabel *)team1ScoreLbl
{
    if (!_team1ScoreLbl) {
        _team1ScoreLbl = [[UILabel alloc] initWithFrame:CGRectMake(_competeView.left - 105, _competeView.center.y - 50, 100, 100)];
        _team1ScoreLbl.textAlignment = NSTextAlignmentCenter;
        _team1ScoreLbl.textColor = [UIColor whiteColor];
        _team1ScoreLbl.font = [UIFont systemFontOfSize:120];
        _team1ScoreLbl.text = @"0";
    }
    return _team1ScoreLbl;
}

- (UILabel *)team2ScoreLbl
{
    if (!_team2ScoreLbl) {
        _team2ScoreLbl = [[UILabel alloc] initWithFrame:CGRectMake(_competeView.right + 5, _competeView.center.y - 50, 100, 100)];
        _team2ScoreLbl.textAlignment = NSTextAlignmentCenter;
        _team2ScoreLbl.textColor = [UIColor whiteColor];
        _team2ScoreLbl.font = [UIFont systemFontOfSize:120];
        _team2ScoreLbl.text = @"0";
    }
    return _team2ScoreLbl;
}

- (UILabel *)team1NameLbl
{
    if (!_team1NameLbl) {
        _team1NameLbl = [[UILabel alloc] initWithFrame:CGRectMake(_team1ScoreLbl.left, _team1ScoreLbl.bottom + 8, _team1ScoreLbl.width, 15)];
        _team1NameLbl.textAlignment = NSTextAlignmentCenter;
        _team1NameLbl.textColor = [UIColor whiteColor];
        _team1NameLbl.font = [UIFont systemFontOfSize:12];
        if (_matchData) {
            _team1NameLbl.text = _matchData.team1Name;
        }
    }
    return _team1NameLbl;
}

- (UILabel *)team2NameLbl
{
    if (!_team2NameLbl) {
        _team2NameLbl = [[UILabel alloc] initWithFrame:CGRectMake(_team2ScoreLbl.left, _team2ScoreLbl.bottom + 8, _team2ScoreLbl.width, 15)];
        _team2NameLbl.textAlignment = NSTextAlignmentCenter;
        _team2NameLbl.textColor = [UIColor whiteColor];
        _team2NameLbl.font = [UIFont systemFontOfSize:12];
        if (_matchData) {
            _team2NameLbl.text = _matchData.team2Name;
        }
    }
    return _team2NameLbl;
}

- (UILabel *)timeLbl
{
    if (!_timeLbl) {
        _timeLbl = [[UILabel alloc] initWithFrame:CGRectMake((SCREEN_WIDTH - 100)/2, 218, 100, 20)];
        _timeLbl.textAlignment = NSTextAlignmentCenter;
        _timeLbl.textColor = [UIColor whiteColor];
        _timeLbl.font = [UIFont systemFontOfSize:18];
        _timeLbl.text = @"00:00";
    }
    return _timeLbl;
}

- (TQPlayBackTableView *)liveTableView
{
    if (!_liveTableView) {
        _liveTableView = [[TQPlayBackTableView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(_headerView.frame), SCREEN_WIDTH, SCREEN_HEIGHT + 20 - CGRectGetMaxY(_headerView.frame)) style:UITableViewStylePlain];
        _liveTableView.backgroundColor = [UIColor whiteColor];
    }
    return _liveTableView;
}


#pragma mark - events

- (void)backAction
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)shareAction
{
    
}



@end
