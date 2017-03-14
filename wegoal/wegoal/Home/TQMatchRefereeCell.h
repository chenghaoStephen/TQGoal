//
//  TQMatchRefereeCell.h
//  wegoal
//
//  Created by joker on 2017/3/9.
//  Copyright © 2017年 xdkj. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^packupBlock)(BOOL isPackup);
typedef void(^selectBlock)(BOOL);
@interface TQMatchRefereeCell : UITableViewCell

@property (nonatomic, copy) packupBlock block;
@property (nonatomic, copy) selectBlock selectBlk;
@property (nonatomic, assign) BOOL isPackup;
@property (nonatomic, assign) BOOL canSelected;
@property (nonatomic, strong) TQServiceModel *refereeData;

- (void)clearInformation;

@end
