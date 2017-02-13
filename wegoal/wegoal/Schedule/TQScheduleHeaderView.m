//
//  TQScheduleHeaderView.m
//  wegoal
//
//  Created by joker on 2017/2/7.
//  Copyright © 2017年 xdkj. All rights reserved.
//

#import "TQScheduleHeaderView.h"

#define kSegmentTag      24000
#define kUnderLineTag    24100

@interface TQScheduleHeaderView()
{
    NSInteger selectIndex;
}

@end

@implementation TQScheduleHeaderView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
    }
    return self;
}

- (void)setSegments:(NSArray *)segments
{
    _segments = segments;
    for (UIView *subview in self.subviews) {
        [subview removeFromSuperview];
    }
    //添加子视图
    CGFloat btnWidth = SCREEN_WIDTH/segments.count;
    CGFloat underLineWidth = btnWidth - 10;
    for (NSInteger index = 0; index < segments.count; index++) {
        UIButton *segmentBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [segmentBtn setFrame:CGRectMake(btnWidth*index, 0, btnWidth, self.height)];
        [segmentBtn setTitleColor:_unselectedColor forState:UIControlStateNormal];
        [segmentBtn setTitleColor:_selectedColor forState:UIControlStateSelected];
        segmentBtn.titleLabel.font = [UIFont systemFontOfSize:12.f];
        [segmentBtn setTitle:segments[index] forState:UIControlStateNormal];
        segmentBtn.tag = kSegmentTag + index;
        [segmentBtn addTarget:self action:@selector(selectSegment:) forControlEvents:UIControlEventTouchUpInside];
        //默认选中第一个
        if (index == 0) {
            segmentBtn.selected = YES;
            selectIndex = 0;
            underLineWidth = [segments[index] boundingRectWithSize:CGSizeMake(CGFLOAT_MAX, segmentBtn.height)
                                                           options:NSStringDrawingUsesLineFragmentOrigin
                                                        attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:12.f]}
                                                           context:nil].size.width;
        }
        [self addSubview:segmentBtn];
    }
    UIImageView *underLine = [[UIImageView alloc] initWithFrame:CGRectMake((btnWidth - underLineWidth)/2, self.height - 4, underLineWidth, 4)];
    underLine.backgroundColor = kSubjectBackColor;
    underLine.tag = kUnderLineTag;
    [self addSubview:underLine];
}


#pragma mark - events

- (void)selectSegment:(UIButton *)sender
{
    if (sender.selected) return;
    
    for (NSInteger index = 0; index < _segments.count; index++) {
        UIButton *btn = [self viewWithTag:(kSegmentTag + index)];
        btn.selected = NO;
    }
    sender.selected = YES;
    selectIndex = sender.tag - kSegmentTag;
    //下划线处理
    CGFloat underLineWidth = [_segments[selectIndex] boundingRectWithSize:CGSizeMake(CGFLOAT_MAX, sender.height)
                                                                  options:NSStringDrawingUsesLineFragmentOrigin
                                                               attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:12.f]}
                                                                  context:nil].size.width;
    UIImageView *underLine = [self viewWithTag:kUnderLineTag];
    CGFloat btnWidth = SCREEN_WIDTH/_segments.count;
    [UIView animateWithDuration:.3f animations:^{
        [underLine setFrame:CGRectMake(sender.x + (btnWidth - underLineWidth)/2, self.height - 4, underLineWidth, 4)];
    } completion:nil];
    //数据更新
    if (_delegate && [_delegate respondsToSelector:@selector(TQScheduleHeaderView:selectSegment:)]) {
        [_delegate TQScheduleHeaderView:self selectSegment:selectIndex];
    }
}



@end
