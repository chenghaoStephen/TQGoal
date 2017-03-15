//
//  TQMatchStatusView.m
//  wegoal
//
//  Created by joker on 2016/12/26.
//  Copyright © 2016年 xdkj. All rights reserved.
//

#import "TQMatchStatusView.h"
#import "TQMatchCell.h"
#import "TQMatchDetailViewController.h"
#define kShareButtonTag     32001
#define kShareButtonWidth   27.f

@interface TQMatchStatusView()
{
    CGFloat viewWidth;
    CGFloat viewHeight;
}

@property (strong, nonatomic) UILabel *titleLabel;
@property (strong, nonatomic) UIButton *moreButton;
@property (strong, nonatomic) UIView *signView;
@property (strong, nonatomic) TQMatchCell *matchCell;
@property (strong, nonatomic) UIButton *actionButton;
@property (strong, nonatomic) UIView *shareView;
@property (strong, nonatomic) UIButton *cancelButton;

@end

@implementation TQMatchStatusView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        viewWidth = frame.size.width;
        viewHeight = frame.size.height;
        [self addSubview:self.titleLabel];
        [self addSubview:self.moreButton];
        [self addSubview:self.signView];
        [self addSubview:self.matchCell];
        [self addSubview:self.actionButton];
        [self addSubview:self.shareView];
        [self addSubview:self.cancelButton];
    }
    return self;
}

- (UILabel *)titleLabel
{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(8, 7, viewWidth - 16, 20)];
        _titleLabel.font = [UIFont systemFontOfSize:12.f];
        _titleLabel.textColor = kTitleTextColor;
        _titleLabel.text = @"我的约战";
        _titleLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _titleLabel;
}

- (UIButton *)moreButton
{
    if (!_moreButton) {
        _moreButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_moreButton setFrame:CGRectMake(viewWidth - 35, 2, 30, 30)];
        [_moreButton setImage:[UIImage imageNamed:@"more_share_drop"] forState:UIControlStateNormal];
        [_moreButton setImage:[UIImage imageNamed:@"more_share_packup"] forState:UIControlStateSelected];
        [_moreButton addTarget:self action:@selector(showMore) forControlEvents:UIControlEventTouchUpInside];
    }
    return _moreButton;
}

- (UIView *)signView
{
    if (!_signView) {
        _signView = [[UIView alloc] initWithFrame:CGRectMake((viewWidth - 18)/2, CGRectGetMaxY(_titleLabel.frame) + 8, 18, 4)];
        _signView.backgroundColor = kTitleTextColor;
    }
    return _signView;
}

- (TQMatchCell *)matchCell
{
    if (!_matchCell) {
        _matchCell = [[[NSBundle mainBundle] loadNibNamed:@"TQMatchCell" owner:nil options:nil] firstObject];
        [_matchCell setFrame:CGRectMake((viewWidth - SCREEN_WIDTH)/2, CGRectGetMaxY(_signView.frame) + 8, SCREEN_WIDTH, 121)];
    }
    return _matchCell;
}

- (UIButton *)actionButton
{
    if (!_actionButton) {
        _actionButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_actionButton setFrame:CGRectMake((viewWidth - 150)/2, viewHeight - 15, 150, 30)];
        [_actionButton setBackgroundColor:kSubjectBackColor];
        [_actionButton setTitle:@"即刻支付" forState:UIControlStateNormal];
        [_actionButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _actionButton.titleLabel.font = [UIFont systemFontOfSize:12.f];
        [_actionButton addTarget:self action:@selector(doAction) forControlEvents:UIControlEventTouchUpInside];
        
        _actionButton.layer.masksToBounds = YES;
        _actionButton.layer.cornerRadius = CGRectGetHeight(_actionButton.frame)/2;
    }
    return _actionButton;
}

- (UIView *)shareView
{
    if (!_shareView) {
        _shareView = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(_signView.frame) + 8, viewWidth, 121)];
        _shareView.backgroundColor = [UIColor whiteColor];
        
        //添加分享按钮
        CGFloat interValX = (viewWidth - kShareButtonWidth*6 - 20)/7;
        CGFloat offsetX = 10 + interValX;
        for (NSInteger i = 0; i < 6; i++) {
            UIButton *shareBtn = [UIButton buttonWithType:UIButtonTypeCustom];
            shareBtn.tag = kShareButtonTag + i;
            shareBtn.frame = CGRectMake(offsetX, 40, kShareButtonWidth, kShareButtonWidth);
            [shareBtn addTarget:self action:@selector(shareAction:) forControlEvents:UIControlEventTouchUpInside];
            switch (i) {
                case 0:
                    [shareBtn setImage:[UIImage imageNamed:@"umsocial_wechat"] forState:UIControlStateNormal];
                    break;
                case 1:
                    [shareBtn setImage:[UIImage imageNamed:@"umsocial_wechat_timeline"] forState:UIControlStateNormal];
                    break;
                case 2:
                    [shareBtn setImage:[UIImage imageNamed:@"umsocial_sina"] forState:UIControlStateNormal];
                    break;
                case 3:
                    [shareBtn setImage:[UIImage imageNamed:@"umsocial_qq"] forState:UIControlStateNormal];
                    break;
                case 4:
                    [shareBtn setImage:[UIImage imageNamed:@"umsocial_qzone"] forState:UIControlStateNormal];
                    break;
                case 5:
                    [shareBtn setImage:[UIImage imageNamed:@"umsocial_tencentWB"] forState:UIControlStateNormal];
                    break;
                    
                default:
                    break;
            }
            [_shareView addSubview:shareBtn];
            offsetX += interValX + kShareButtonWidth;
        }
        _shareView.hidden = YES;
    }
    return _shareView;
}

- (UIButton *)cancelButton
{
    if (!_cancelButton) {
        _cancelButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_cancelButton setFrame:CGRectMake((viewWidth - 150)/2, viewHeight - 15, 150, 30)];
        [_cancelButton setBackgroundColor:kNavTitleColor];
        [_cancelButton setTitle:@"取消约战" forState:UIControlStateNormal];
        [_cancelButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _cancelButton.titleLabel.font = [UIFont systemFontOfSize:12.f];
        [_cancelButton addTarget:self action:@selector(cancelAction) forControlEvents:UIControlEventTouchUpInside];
        
        _cancelButton.layer.masksToBounds = YES;
        _cancelButton.layer.cornerRadius = CGRectGetHeight(_cancelButton.frame)/2;
        _cancelButton.hidden = YES;
    }
    return _cancelButton;
}


#pragma mark - event

- (void)setMatchData:(TQMatchModel *)matchData
{
    _matchData = matchData;
    switch ([matchData.status integerValue]) {
        case MatchStatusSearching:
            [_actionButton setBackgroundColor:kTitleTextColor];
            [_actionButton setTitle:@"等待中" forState:UIControlStateNormal];
            _actionButton.enabled = NO;
            break;
        case MatchStatusConfirm:
            [_actionButton setBackgroundColor:kSubjectBackColor];
            [_actionButton setTitle:@"确认对手" forState:UIControlStateNormal];
            _actionButton.enabled = YES;
            break;
        case MatchStatusPay:
            [_actionButton setBackgroundColor:kSubjectBackColor];
            [_actionButton setTitle:@"即刻支付" forState:UIControlStateNormal];
            _actionButton.enabled = YES;
            break;
        case MatchStatusWaiting:
            [_actionButton setBackgroundColor:kTitleTextColor];
            [_actionButton setTitle:@"等待中" forState:UIControlStateNormal];
            _actionButton.enabled = NO;
            break;
        case MatchStatusProcessing:
            [_actionButton setBackgroundColor:kRedBackColor];
            [_actionButton setTitle:@"赛况直播" forState:UIControlStateNormal];
            _actionButton.enabled = YES;
            break;
        case MatchStatusEnd:
            [_actionButton setBackgroundColor:kSubjectBackColor];
            [_actionButton setTitle:@"查看全部赛程" forState:UIControlStateNormal];
            _actionButton.enabled = YES;
            break;
            
        default:
            break;
    }
    _matchCell.matchData = matchData;
    _matchCell.isMine = YES;
}

- (void)showMore
{
    //切换视图
    _moreButton.selected = !_moreButton.selected;
    if (_moreButton.selected) {
        //分享和取消
        _titleLabel.text = @"分享并呼叫队友";
        _shareView.hidden = NO;
        _cancelButton.hidden = NO;
        _matchCell.hidden = YES;
        _actionButton.hidden = YES;
    } else {
        //约战
        _titleLabel.text = @"我的约战";
        _shareView.hidden = YES;
        _cancelButton.hidden = YES;
        _matchCell.hidden = NO;
        _actionButton.hidden = NO;
    }
    
}

- (void)doAction
{
    NSLog(@"do action.");
    TQMatchDetailViewController *matchDetailVC = [[TQMatchDetailViewController alloc] init];
    matchDetailVC.matchModel = _matchData;
    [((TQBaseViewController *)self.viewController) pushViewController:matchDetailVC];
}

- (void)cancelAction
{
    NSLog(@"cancel.");
}

- (void)shareAction:(UIButton *)shareBtn
{
    switch (shareBtn.tag - kShareButtonTag) {
        case 0:
            NSLog(@"share to wechat");
            break;
        case 1:
            NSLog(@"share to wechat timeline");
            break;
        case 2:
            NSLog(@"share to sina");
            break;
        case 3:
            NSLog(@"share to qq");
            break;
        case 4:
            NSLog(@"share to qq zone");
            break;
        case 5:
            NSLog(@"share to tecent");
            break;
            
        default:
            break;
    }
}

@end
