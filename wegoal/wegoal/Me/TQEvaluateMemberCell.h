//
//  TQEvaluateMemberCell.h
//  wegoal
//
//  Created by joker on 2017/3/16.
//  Copyright © 2017年 xdkj. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^selectBlock)(BOOL);
typedef void(^amountBlock)(NSUInteger);
@interface TQEvaluateMemberCell : UITableViewCell

@property (nonatomic, copy) selectBlock selectBlk;
@property (nonatomic, copy) amountBlock amountBlk;
@property (nonatomic, strong) TQMemberModel *memberData;
@property (nonatomic, assign) BOOL canEdit;

- (void)clearInformation;
- (void)setSelected:(BOOL)selected andAmount:(NSUInteger)amount;

@end
