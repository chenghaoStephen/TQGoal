//
//  TQPlayBackTableView.m
//  wegoal
//
//  Created by joker on 2017/3/17.
//  Copyright © 2017年 xdkj. All rights reserved.
//

#import "TQPlayBackTableView.h"
#import "TQPlayTextCell.h"
#import "TQPlayImageCell.h"

#define kTQPlayTextCellIdentifier     @"TQPlayTextCell"
#define kTQPlayImageCellIdentifier     @"TQPlayImageCell"
@interface TQPlayBackTableView()<UITableViewDataSource, UITableViewDelegate>

@end

@implementation TQPlayBackTableView

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style
{
    self = [super initWithFrame:frame style:style];
    if (self) {
        self.separatorStyle = UITableViewCellSeparatorStyleNone;
        self.dataSource = self;
        self.delegate = self;
        [self registerNib:[UINib nibWithNibName:@"TQPlayTextCell" bundle:nil] forCellReuseIdentifier:kTQPlayTextCellIdentifier];
        [self registerNib:[UINib nibWithNibName:@"TQPlayImageCell" bundle:nil] forCellReuseIdentifier:kTQPlayImageCellIdentifier];
        [self setTestData];
    }
    return self;
}

- (void)setTestData
{
    NSMutableArray *arrayTmp = [NSMutableArray array];
    //发起
    TQPlayModel *playData1 = [TQPlayModel new];
    playData1.type = PlayTypeLaunchImage;
    [arrayTmp addObject:playData1];
    TQPlayModel *playData2 = [TQPlayModel new];
    playData2.type = PlayTypeLaunchText;
    [arrayTmp addObject:playData2];
    //约战已满
    TQPlayModel *playData3 = [TQPlayModel new];
    playData3.type = PlayTypeScheduleImage;
    [arrayTmp addObject:playData3];
    TQPlayModel *playData4 = [TQPlayModel new];
    playData4.type = PlayTypeScheduleText;
    [arrayTmp addObject:playData4];
    //比赛开始
    TQPlayModel *playData5 = [TQPlayModel new];
    playData5.type = PlayTypeGameStartImage;
    [arrayTmp addObject:playData5];
    TQPlayModel *playData6 = [TQPlayModel new];
    playData6.type = PlayTypeGameStartText;
    [arrayTmp addObject:playData6];
    //进球
    TQPlayModel *playData7 = [TQPlayModel new];
    playData7.type = PlayTypeGoal;
    playData7.time = @"12'";
    playData7.content = @"10号前锋，里奥梅西进球";
    playData7.isTeam1 = NO;
    [arrayTmp addObject:playData7];
    //黄牌
    TQPlayModel *playData8 = [TQPlayModel new];
    playData8.type = PlayTypeYellow;
    playData8.time = @"42'";
    playData8.content = @"22号后卫，牛魔王黄牌";
    playData8.isTeam1 = YES;
    [arrayTmp addObject:playData8];
    //红牌
    TQPlayModel *playData9 = [TQPlayModel new];
    playData9.type = PlayTypeRed;
    playData9.time = @"78'";
    playData9.content = @"22号后卫，牛魔王红牌";
    playData9.isTeam1 = YES;
    [arrayTmp addObject:playData9];
    
    _dataArray = arrayTmp;
}


#pragma mark - UITableViewDatasource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    TQPlayModel *playData = _dataArray[indexPath.row];
    if (playData.type == PlayTypeLaunchText ||
        playData.type == PlayTypeScheduleText ||
        playData.type == PlayTypeGameStartText) {
        
        TQPlayTextCell *cell = [tableView dequeueReusableCellWithIdentifier:kTQPlayTextCellIdentifier];
        if (!cell) {
            cell = [[NSBundle mainBundle] loadNibNamed:@"TQPlayTextCell" owner:nil options:nil].firstObject;
        }
        cell.leftInfoLabel.hidden = YES;
        cell.leftImageView.hidden = YES;
        cell.rightInfoLabel.hidden = YES;
        cell.rightImageView.hidden = YES;
        switch (playData.type) {
            case PlayTypeLaunchText:
                cell.infoLabel.text = @"发起约战";
                cell.leftInfoLabel.hidden = NO;
                cell.leftImageView.hidden = NO;
                cell.rightInfoLabel.hidden = NO;
                cell.rightImageView.hidden = NO;
                break;
                
            case PlayTypeScheduleText:
                cell.infoLabel.text = @"约战已满";
                break;
                
            case PlayTypeGameStartText:
                cell.infoLabel.text = @"比赛开始";

                break;
                
            default:
                break;
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
        
    } else {
        
        TQPlayImageCell *cell = [tableView dequeueReusableCellWithIdentifier:kTQPlayImageCellIdentifier];
        if (!cell) {
            cell = [[NSBundle mainBundle] loadNibNamed:@"TQPlayImageCell" owner:nil options:nil].firstObject;
        }
        cell.leftInfoLabel.text = @"";
        cell.leftTimeLabel.text = @"";
        cell.rightInfoLabel.text = @"";
        cell.rightTimeLabel.text = @"";
        switch (playData.type) {
            case PlayTypeLaunchImage:
                cell.mainImageView.image = [UIImage imageNamed:@"match_startup"];
                break;
                
            case PlayTypeScheduleImage:
                cell.mainImageView.image = [UIImage imageNamed:@"full"];
                break;
                
            case PlayTypeGameStartImage:
                cell.mainImageView.image = [UIImage imageNamed:@"match_start"];
                break;
                
            case PlayTypeGoal:
                cell.mainImageView.image = [UIImage imageNamed:@"live"];
                break;
                
            case PlayTypeYellow:
                cell.mainImageView.image = [UIImage imageNamed:@"card-yellow"];
                break;
                
            case PlayTypeRed:
                cell.mainImageView.image = [UIImage imageNamed:@"card-red"];
                break;
                
            default:
                break;
        }
        
        if (playData.type == PlayTypeGoal   ||
            playData.type == PlayTypeYellow ||
            playData.type == PlayTypeRed) {
            if (playData.isTeam1) {
                cell.leftInfoLabel.text = playData.content;
                cell.leftTimeLabel.text = playData.time;
            } else {
                cell.rightInfoLabel.text = playData.content;
                cell.rightTimeLabel.text = playData.time;
            }
            
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
        
    }
}


#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50.f;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

@end
