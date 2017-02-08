//
//  TQScheduleHeaderView.h
//  wegoal
//
//  Created by joker on 2017/2/7.
//  Copyright © 2017年 xdkj. All rights reserved.
//

#import <UIKit/UIKit.h>

@class TQScheduleHeaderView;
@protocol TQScheduleHeaderViewDelegate <NSObject>

- (void)TQScheduleHeaderView:(TQScheduleHeaderView *)headerView selectSegment:(NSInteger)index;

@end

@interface TQScheduleHeaderView : UIView

@property (nonatomic, copy) NSArray *segments;
@property (nonatomic, weak) id<TQScheduleHeaderViewDelegate> delegate;

@end
