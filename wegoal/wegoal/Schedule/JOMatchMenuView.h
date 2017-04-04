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
- (void)JOMatchMenuView:(JOMatchMenuView *)matchMenuView getDataWithWeeks:(NSString *)weeks systems:(NSString *)systems types:(NSString *)types;
- (void)JOMatchMenuView:(JOMatchMenuView *)matchMenuView getDataWithStatus:(NSString *)status;
//调整高度
- (void)JOMatchMenuView:(JOMatchMenuView *)matchMenuView updateViewHeight:(CGFloat)height;

@end

@interface JOMatchMenuView : UIView

@property (nonatomic, assign) BOOL isDrop;
@property (nonatomic, copy) NSString *matchType;
@property (nonatomic, weak) id<JOMatchMenuViewDelegate> delegate;

@end
