//
//  TQMyMatchCell.h
//  wegoal
//
//  Created by joker on 2017/3/16.
//  Copyright © 2017年 xdkj. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TQMyMatchCell : UITableViewCell

@property (nonatomic, strong) TQMatchModel *matchData;
@property (nonatomic, assign) BOOL isMine;

- (void)clearInformation;

@end
