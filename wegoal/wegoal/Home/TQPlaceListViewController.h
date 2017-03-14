//
//  TQPlaceListViewController.h
//  wegoal
//
//  Created by joker on 2017/3/14.
//  Copyright © 2017年 xdkj. All rights reserved.
//

#import "TQBaseViewController.h"

typedef void(^selectPlaceBlock)(TQPlaceModel *);
@interface TQPlaceListViewController : TQBaseViewController

@property (nonatomic, copy) selectPlaceBlock selectPlaceBlk;

@end
