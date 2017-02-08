//
//  TQLadderTeamCell.h
//  wegoal
//
//  Created by joker on 2017/2/8.
//  Copyright © 2017年 xdkj. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TQTeamModel.h"

@interface TQLadderTeamCell : UITableViewCell

@property (nonatomic, strong) TQTeamModel *teamInfo;
@property (nonatomic, assign) NSInteger ladderNo;

@end
