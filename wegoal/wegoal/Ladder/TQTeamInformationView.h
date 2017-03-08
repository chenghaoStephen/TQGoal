//
//  TQTeamInformationView.h
//  wegoal
//
//  Created by joker on 2017/3/7.
//  Copyright © 2017年 xdkj. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TQMatchModel.h"

typedef NS_ENUM(NSInteger, TeamTopViewMode){
    TeamTopViewModeLadder = 0,
    TeamTopViewModeTeam,
};

@interface TQTeamInformationView : UIView

@property (nonatomic, assign) TeamTopViewMode viewMode;
@property (nonatomic, strong) TQMatchModel *teamInfo;

@end
