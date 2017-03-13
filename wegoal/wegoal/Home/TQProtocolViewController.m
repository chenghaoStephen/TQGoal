//
//  TQProtocolViewController.m
//  wegoal
//
//  Created by joker on 2017/3/9.
//  Copyright © 2017年 xdkj. All rights reserved.
//

#import "TQProtocolViewController.h"
#import "TQLaunchRefereeViewController.h"

@interface TQProtocolViewController ()

@property (strong, nonatomic) UIScrollView *detailScrollView;
@property (strong, nonatomic) UILabel *detailLabel;
@property (strong, nonatomic) UIButton *agreeButton;

@end

@implementation TQProtocolViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"约战协议";
    self.view.backgroundColor = [UIColor whiteColor];
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 1)];
    lineView.backgroundColor = kMainBackColor;
    [self.view addSubview:lineView];
    [self.view addSubview:self.detailScrollView];
    [self.view addSubview:self.agreeButton];
}

- (UIScrollView *)detailScrollView
{
    if (!_detailScrollView) {
        _detailScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 1, SCREEN_WIDTH, VIEW_HEIGHT - 81)];
        _detailScrollView.showsVerticalScrollIndicator = YES;
        _detailScrollView.showsHorizontalScrollIndicator = NO;
        _detailScrollView.scrollsToTop = YES;
        [_detailScrollView addSubview:self.detailLabel];
    }
    return _detailScrollView;
}

- (UILabel *)detailLabel
{
    if (!_detailLabel) {
        _detailLabel = [[UILabel alloc] initWithFrame:CGRectMake(6, 12, SCREEN_WIDTH - 12, 0)];
        _detailLabel.textColor = kNavTitleColor;
        _detailLabel.font = [UIFont systemFontOfSize:12.f];
        _detailLabel.numberOfLines = 0;
    }
    return _detailLabel;
}

- (UIButton *)agreeButton
{
    if (!_agreeButton) {
        _agreeButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _agreeButton.frame = CGRectMake((SCREEN_WIDTH - 150)/2, CGRectGetMaxY(_detailScrollView.frame) + 13, 150, 32);
        _agreeButton.layer.masksToBounds = YES;
        _agreeButton.layer.cornerRadius = 16;
        _agreeButton.backgroundColor = kSubjectBackColor;
        [_agreeButton setTitle:@"已阅读，并同意" forState:UIControlStateNormal];
        _agreeButton.titleLabel.font = [UIFont systemFontOfSize:12.f];
        [_agreeButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_agreeButton addTarget:self action:@selector(agreeAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _agreeButton;
}


#pragma mark - events

- (void)agreeAction
{
    TQLaunchRefereeViewController *launchRefereeVC = [[TQLaunchRefereeViewController alloc] init];
    [self.navigationController pushViewController:launchRefereeVC animated:YES];
}

- (void)setProtocolDetail:(NSString *)detailStr
{
    _detailLabel.text = detailStr;
    _detailLabel.height = [TQCommon heightForString:detailStr fontSize:[UIFont systemFontOfSize:12.f] andWidth:(SCREEN_WIDTH - 12)];
    [_detailScrollView setContentSize:CGSizeMake(CGRectGetWidth(_detailScrollView.frame), _detailLabel.height + 24)];
}


@end






