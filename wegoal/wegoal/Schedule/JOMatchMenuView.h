//
//  JOMatchMenuView.h
//  JOExample3
//
//  Created by joker on 2016/12/14.
//  Copyright © 2016年 joker. All rights reserved.
//

#import <UIKit/UIKit.h>

@class JOMatchMenuView;
@protocol JOMatchMenuViewDelegate <NSObject>
//刷新数据
- (void)JOMatchMenuView:(JOMatchMenuView *)matchMenuView getDataWithWeeks:(NSArray *)weeks systems:(NSArray *)systems types:(NSArray *)types;

@end

@interface JOMatchMenuView : UIView

@property (nonatomic, assign) BOOL isDrop;
@property (nonatomic, weak) id<JOMatchMenuViewDelegate> delegate;

@end
