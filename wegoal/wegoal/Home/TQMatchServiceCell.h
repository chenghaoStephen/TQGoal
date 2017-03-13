//
//  TQMatchServiceCell.h
//  wegoal
//
//  Created by joker on 2017/3/13.
//  Copyright © 2017年 xdkj. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^selectBlock)(BOOL);
typedef void(^amountBlock)(NSUInteger);

@interface TQMatchServiceCell : UITableViewCell

@property (nonatomic, copy) selectBlock selectBlk;
@property (nonatomic, copy) amountBlock amountBlk;
@property (nonatomic, assign) BOOL canSelected;

- (void)setSelected:(BOOL)selected andAmount:(NSUInteger)amount;

@end
