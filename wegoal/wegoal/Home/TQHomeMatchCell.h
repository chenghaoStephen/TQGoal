//
//  TQHomeMatchCell.h
//  wegoal
//
//  Created by joker on 2016/12/20.
//  Copyright © 2016年 xdkj. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TQHomeMatchCell : UICollectionViewCell

//约战状态
@property (nonatomic, assign) TQMatchModel *matchData;
@property (nonatomic, copy) void(^ClickBlock)(void);

@end
