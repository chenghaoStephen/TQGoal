//
//  TQAmountSelectView.h
//  wegoal
//
//  Created by joker on 2017/4/21.
//  Copyright © 2017年 xdkj. All rights reserved.
//

#import <UIKit/UIKit.h>

#define kAmountCellHeight   64
#define kAmountInterval     8
@interface TQAmountSelectView : UIView

@property (nonatomic, strong) NSArray *amountsArray;
@property (nonatomic, copy) void(^amountSelectBlock)(NSString *amount);

@end
