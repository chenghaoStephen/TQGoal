//
//  TQMatchCell.h
//  wegoal
//
//  Created by joker on 2016/12/26.
//  Copyright © 2016年 xdkj. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TQMatchCell : UITableViewCell

@property (strong, nonatomic) TQMatchModel *matchData;
@property (nonatomic, assign) BOOL isShowLine;      //是否显示分割线

@end
