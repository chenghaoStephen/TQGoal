//
//  TQEvaluateMemberBottomView.h
//  wegoal
//
//  Created by joker on 2017/3/16.
//  Copyright © 2017年 xdkj. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^nextStepBlock)(void);
@interface TQEvaluateMemberBottomView : UIView

@property (strong, nonatomic) UILabel *averageSignLabel;
@property (strong, nonatomic) UILabel *averageLabel;
@property (strong, nonatomic) UILabel *unitSignLabel;
@property (strong, nonatomic) UIButton *nextStepButton;

@property (nonatomic, copy) nextStepBlock nextStepBlk;

@end
