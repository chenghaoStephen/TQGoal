//
//  TQAcceptConfirmViewController.h
//  wegoal
//
//  Created by joker on 2017/4/22.
//  Copyright © 2017年 xdkj. All rights reserved.
//

#import "TQBaseViewController.h"

@interface TQAcceptConfirmViewController : TQBaseViewController

@property (nonatomic, strong) TQMatchModel *matchData;
@property (nonatomic, strong) TQServiceModel *refereeData;  //裁判服务
@property (nonatomic, strong) NSArray *servicesArray;       //其他服务

- (void)reloadData;

@end
