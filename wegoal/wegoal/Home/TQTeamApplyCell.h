//
//  TQTeamApplyCell.h
//  wegoal
//
//  Created by joker on 2017/4/20.
//  Copyright © 2017年 xdkj. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TQTeamApplyCell : UITableViewCell

@property (nonatomic, strong) TQTeamModel *teamData;
@property (nonatomic, copy) void(^applyBlock)();

@end
