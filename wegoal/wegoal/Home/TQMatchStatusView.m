//
//  TQMatchStatusView.m
//  wegoal
//
//  Created by joker on 2016/12/26.
//  Copyright © 2016年 xdkj. All rights reserved.
//

#import "TQMatchStatusView.h"
#import "TQMatchCell.h"
#import "ShareSDK.h"

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
//@property (strong, nonatomic) UIButton *actionButton;
@property (strong, nonatomic) UIView *shareView;
//@property (strong, nonatomic) UIButton *cancelButton;

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
//        [self addSubview:self.actionButton];
        [self addSubview:self.shareView];
//        [self addSubview:self.cancelButton];
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
        _matchCell.userInteractionEnabled = YES;
    }
    return _matchCell;
}

//- (UIButton *)actionButton
//{
//    if (!_actionButton) {
//        _actionButton = [UIButton buttonWithType:UIButtonTypeCustom];
//        [_actionButton setFrame:CGRectMake((viewWidth - 150)/2, viewHeight - 15, 150, 30)];
//        [_actionButton setBackgroundColor:kSubjectBackColor];
//        [_actionButton setTitle:@"即刻支付" forState:UIControlStateNormal];
//        [_actionButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//        _actionButton.titleLabel.font = [UIFont systemFontOfSize:12.f];
//        [_actionButton addTarget:self action:@selector(doAction) forControlEvents:UIControlEventTouchUpInside];
//        
//        _actionButton.layer.masksToBounds = YES;
//        _actionButton.layer.cornerRadius = CGRectGetHeight(_actionButton.frame)/2;
//    }
//    return _actionButton;
//}

- (UIView *)shareView
{
    if (!_shareView) {
        _shareView = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(_signView.frame) + 8, viewWidth, 121)];
        _shareView.backgroundColor = [UIColor whiteColor];
        
        //添加分享按钮
        CGFloat interValX = (viewWidth - kShareButtonWidth*3 - 20)/4;
        CGFloat offsetX = 10 + interValX;
        for (NSInteger i = 0; i < 3; i++) {
            UIButton *shareBtn = [UIButton buttonWithType:UIButtonTypeCustom];
            shareBtn.tag = kShareButtonTag + i;
            shareBtn.frame = CGRectMake(offsetX, 40, kShareButtonWidth, kShareButtonWidth);
            [shareBtn addTarget:self action:@selector(shareAction:) forControlEvents:UIControlEventTouchUpInside];
            switch (i) {
                case 0:
                    [shareBtn setImage:[UIImage imageNamed:@"wechat_share"] forState:UIControlStateNormal];
                    break;
                case 1:
                    [shareBtn setImage:[UIImage imageNamed:@"wechat_timeline"] forState:UIControlStateNormal];
                    break;
                case 2:
                    [shareBtn setImage:[UIImage imageNamed:@"qq_share"] forState:UIControlStateNormal];
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

//- (UIButton *)cancelButton
//{
//    if (!_cancelButton) {
//        _cancelButton = [UIButton buttonWithType:UIButtonTypeCustom];
//        [_cancelButton setFrame:CGRectMake((viewWidth - 150)/2, viewHeight - 15, 150, 30)];
//        [_cancelButton setBackgroundColor:kNavTitleColor];
//        [_cancelButton setTitle:@"取消约战" forState:UIControlStateNormal];
//        [_cancelButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//        _cancelButton.titleLabel.font = [UIFont systemFontOfSize:12.f];
//        [_cancelButton addTarget:self action:@selector(cancelAction) forControlEvents:UIControlEventTouchUpInside];
//        
//        _cancelButton.layer.masksToBounds = YES;
//        _cancelButton.layer.cornerRadius = CGRectGetHeight(_cancelButton.frame)/2;
//        _cancelButton.hidden = YES;
//    }
//    return _cancelButton;
//}


#pragma mark - event

- (void)setMatchData:(TQMatchModel *)matchData
{
    _matchData = matchData;
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
        _matchCell.hidden = YES;
        
    } else {
        //约战
        _titleLabel.text = @"我的约战";
        _shareView.hidden = YES;
        _matchCell.hidden = NO;
        
    }
    if (_clickMoreBlk) {
        _clickMoreBlk(_moreButton.selected);
    }
}


- (void)shareAction:(UIButton *)shareBtn
{
    NSMutableDictionary *shareParams = [NSMutableDictionary dictionary];
    SSDKPlatformType shareType;
    switch (shareBtn.tag - kShareButtonTag) {
        case 0:
        {
            NSLog(@"share to wechat");
            [shareParams SSDKSetupWeChatParamsByText:@""
                                               title:@""
                                                 url:[NSURL URLWithString:@""]
                                          thumbImage:nil
                                               image:[UIImage imageNamed:@""]
                                        musicFileURL:nil
                                             extInfo:nil
                                            fileData:nil
                                        emoticonData:nil
                                                type:SSDKContentTypeAuto
                                  forPlatformSubType:SSDKPlatformSubTypeWechatSession];
            shareType = SSDKPlatformSubTypeWechatSession;
            break;
        }
            
        case 1:
        {
            [shareParams SSDKSetupWeChatParamsByText:@""
                                               title:@""
                                                 url:[NSURL URLWithString:@""]
                                          thumbImage:nil
                                               image:[UIImage imageNamed:@""]
                                        musicFileURL:nil
                                             extInfo:nil
                                            fileData:nil
                                        emoticonData:nil
                                                type:SSDKContentTypeAuto
                                  forPlatformSubType:SSDKPlatformSubTypeWechatTimeline];
            shareType = SSDKPlatformSubTypeWechatTimeline;
            break;
        }

        case 2:
        {
            [shareParams SSDKSetupQQParamsByText:@""
                                           title:@""
                                             url:[NSURL URLWithString:@""]
                                      thumbImage:nil
                                           image:[UIImage imageNamed:@""]
                                            type:SSDKContentTypeAuto
                              forPlatformSubType:SSDKPlatformTypeQQ];
            shareType = SSDKPlatformSubTypeQQFriend;
            break;
        }
            
        default:
            break;
    }
    
    [ShareSDK share:shareType
         parameters:shareParams
     onStateChanged:^(SSDKResponseState state, NSDictionary *userData, SSDKContentEntity *contentEntity, NSError *error) {
         
         switch (state) {
             case SSDKResponseStateBegin:
                 
                 break;
                 
             case SSDKResponseStateSuccess:
                 NSLog(@"分享成功");
                 break;
                 
             case  SSDKResponseStateFail:
                 NSLog(@"分享失败");
                 NSLog(@"失败：%@", error);
                 break;
                 
             default:
                 
                 break;
         }

     }];
}

@end
