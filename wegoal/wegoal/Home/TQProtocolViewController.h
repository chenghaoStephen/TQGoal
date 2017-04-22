//
//  TQProtocolViewController.h
//  wegoal
//
//  Created by joker on 2017/3/9.
//  Copyright © 2017年 xdkj. All rights reserved.
//

#import "TQBaseViewController.h"

@interface TQProtocolViewController : TQBaseViewController

//是否是应战
@property (nonatomic, assign) BOOL isAccept;
//应战时，接收数据
@property (nonatomic, strong) TQMatchModel *matchData;

@end
