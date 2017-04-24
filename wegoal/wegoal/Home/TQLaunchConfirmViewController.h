//
//  TQLaunchConfirmViewController.h
//  wegoal
//
//  Created by joker on 2017/3/13.
//  Copyright © 2017年 xdkj. All rights reserved.
//

#import "TQBaseViewController.h"

@interface TQLaunchConfirmViewController : TQBaseViewController

@property (nonatomic, strong) TQTeamModel *teamData;        //球队信息
@property (nonatomic, copy) NSDictionary *matchData;        //比赛信息
@property (nonatomic, strong) TQServiceModel *refereeData;  //裁判服务
@property (nonatomic, strong) NSArray *servicesArray;       //其他服务

//- (void)reloadData;

@end
