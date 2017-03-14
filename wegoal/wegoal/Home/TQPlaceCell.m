//
//  TQPlaceCell.m
//  wegoal
//
//  Created by joker on 2017/3/14.
//  Copyright © 2017年 xdkj. All rights reserved.
//

#import "TQPlaceCell.h"

@interface TQPlaceCell()

@property (weak, nonatomic) IBOutlet UIImageView *avatarImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *phoneLabel;
@property (weak, nonatomic) IBOutlet UIScrollView *matchScrollView;
@property (weak, nonatomic) IBOutlet UILabel *placeLabel;

@end

@implementation TQPlaceCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
}

- (void)setPlaceData:(TQPlaceModel *)placeData
{
    _placeData = placeData;
    [_avatarImageView sd_setImageWithURL:[NSURL URLWithString:URL(kTQDomainURL, placeData.placePic)]
                        placeholderImage:[UIImage imageNamed:@"defaultHeadImage"]];
    _nameLabel.text = placeData.name;
    _phoneLabel.text = [NSString stringWithFormat:@"电话：%@", placeData.phone];
    _placeLabel.text = placeData.place;
    for (UIView *subView in _matchScrollView.subviews) {
        [subView removeFromSuperview];
    }
    CGFloat offsetX = 0;
    for (NSDictionary *matchDic in placeData.gamePlaceVS) {
        UIImageView *team1ImgView = [[UIImageView alloc] initWithFrame:CGRectMake(offsetX, 2, 16, 16)];
        [team1ImgView sd_setImageWithURL:[NSURL URLWithString:URL(kTQDomainURL, matchDic[@"team1Logo"])]
                        placeholderImage:[UIImage imageNamed:@"defaultHeadImage"]];
        team1ImgView.layer.masksToBounds = YES;
        team1ImgView.layer.cornerRadius = 8.f;
        [_matchScrollView addSubview:team1ImgView];
        offsetX += 20;
        UILabel *vcLabel = [[UILabel alloc] initWithFrame:CGRectMake(offsetX, 2, 11, 16)];
        vcLabel.text = @"vs";
        vcLabel.textAlignment = NSTextAlignmentCenter;
        vcLabel.textColor = kNavTitleColor;
        vcLabel.font = [UIFont systemFontOfSize:9.f];
        [_matchScrollView addSubview:vcLabel];
        offsetX += 15;
        UIImageView *team2ImgView = [[UIImageView alloc] initWithFrame:CGRectMake(offsetX, 2, 16, 16)];
        [team2ImgView sd_setImageWithURL:[NSURL URLWithString:URL(kTQDomainURL, matchDic[@"team2Logo"])]
                        placeholderImage:[UIImage imageNamed:@"defaultHeadImage"]];
        team2ImgView.layer.masksToBounds = YES;
        team2ImgView.layer.cornerRadius = 8.f;
        [_matchScrollView addSubview:team2ImgView];
        offsetX += 32;
    }
    _matchScrollView.contentSize = CGSizeMake(MAX(0, offsetX - 15), 20);
}

- (void)clearInfomation
{
    _avatarImageView.image = [UIImage imageNamed:@"defaultHeadImage"];
    _nameLabel.text = @"---";
    _phoneLabel.text = @"---";
    _placeLabel.text = @"---";
    for (UIView *subView in _matchScrollView.subviews) {
        [subView removeFromSuperview];
    }
}

- (IBAction)telAction:(id)sender {
    if (_telBlk && ![TQCommon isBlankString:_placeData.phone]) {
        _telBlk(_placeData.phone);
    }
}

@end
