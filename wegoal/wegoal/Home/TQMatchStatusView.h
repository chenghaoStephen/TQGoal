//
//  TQMatchStatusView.h
//  wegoal
//
//  Created by joker on 2016/12/26.
//  Copyright © 2016年 xdkj. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^clickMoreBlock)(BOOL isMore);
@interface TQMatchStatusView : UIView

//约战状态
@property (nonatomic, assign) TQMatchModel *matchData;
@property (nonatomic, copy) clickMoreBlock clickMoreBlk;

@end
