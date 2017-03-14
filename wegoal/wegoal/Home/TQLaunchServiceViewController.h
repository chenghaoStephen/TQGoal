//
//  TQLaunchServiceViewController.h
//  wegoal
//
//  Created by joker on 2017/3/13.
//  Copyright © 2017年 xdkj. All rights reserved.
//

#import "TQBaseViewController.h"

@interface TQLaunchServiceViewController : TQBaseViewController

@property (nonatomic, strong) TQTeamModel *teamData;
@property (nonatomic, copy) NSDictionary *matchData;
@property (nonatomic, strong) TQServiceModel *refereeData;
@property (nonatomic, assign) BOOL isSelectedReferee;
@property (nonatomic, strong) NSArray *servicesArray;

@end
