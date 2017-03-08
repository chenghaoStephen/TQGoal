//
//  ZDMIndicator.m
//  ZDzhihuIndicator
//
//  Created by MING.Z on 15-4-2.
//  Copyright (c) 2015年 blurryssky. All rights reserved.
//

#import "ZDMIndicatorView.h"
@interface ZDMIndicatorView()
{
    CAShapeLayer*indicatorLayer;
    ZDMIndicatorViewStyle style;

}
@property (nonatomic,strong)CAShapeLayer*indicatorLayer;
@property (nonatomic,assign)ZDMIndicatorViewStyle style;

@end
@implementation ZDMIndicatorView
@synthesize indicatorLayer,style;
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        self.alpha = 0.4;
        CAShapeLayer*layer = [[CAShapeLayer alloc]init];
        layer.bounds = CGRectMake(0, 0, 30, 30);
        layer.position = CGPointMake(frame.size.width/2, frame.size.height/2);
        layer.path = [UIBezierPath bezierPathWithArcCenter:CGPointMake(layer.bounds.size.width/2, layer.bounds.size.height/2) radius:layer.bounds.size.height/2 startAngle:0 endAngle:(CGFloat)2*M_PI clockwise:YES].CGPath;
        layer.lineWidth = 3;
        layer.strokeColor = [UIColor darkGrayColor].CGColor;
        layer.fillColor = [UIColor clearColor].CGColor;
        layer.strokeEnd = 0;
        layer.strokeStart = 0;
        self.indicatorLayer = layer;
    }
    return self;
}
- (instancetype)init{
   
    return self;
}


+ (void)showInView:(UIView*)superView{
    [ZDMIndicatorView showInView:superView animationStyle:ZDMIndicatorStyleGradual];
    
}

+ (void)showInView:(UIView*)superView animationStyle:(ZDMIndicatorViewStyle)style{
//    [ZDMIndicatorView hiddenInView:superView];
    if (![ZDMIndicatorView isShowInView:superView]) {
        ZDMIndicatorView *indicatorView = [[self alloc]initWithFrame:CGRectMake(0, 0, CGRectGetWidth(superView.bounds), CGRectGetHeight(superView.bounds))];
        [indicatorView.layer addSublayer:indicatorView.indicatorLayer];
        indicatorView.style = style;

        [superView addSubview:indicatorView];
        [indicatorView beginAnimation];
    }
    
}
+ (void)showInView:(UIView*)superView canUserEnable:(BOOL)enable{
    if (![ZDMIndicatorView isShowInView:superView]) {
        ZDMIndicatorView *indicatorView = [[self alloc]initWithFrame:CGRectMake(0, 0, CGRectGetWidth(superView.bounds), CGRectGetHeight(superView.bounds))];
        [indicatorView.layer addSublayer:indicatorView.indicatorLayer];
        indicatorView.style = ZDMIndicatorStyleGradual;
        indicatorView.userInteractionEnabled = !enable;
        [superView addSubview:indicatorView];
        [indicatorView beginAnimation];
    }

}
+ (BOOL)isShowInView:(UIView *)superView{
    for (UIView *view in  superView.subviews) {
        if ([view isKindOfClass:[ZDMIndicatorView class]]) {
            return YES;
        }
    }
    return NO;
}
+ (void)hiddenInView:(UIView *)superView{
    for (UIView *view in  superView.subviews) {
        if ([view isKindOfClass:[ZDMIndicatorView class]]) {
            ZDMIndicatorView *indicatorView  = (ZDMIndicatorView*)view;
//            [indicatorView endAnimationWithCompletion:^(BOOL finished) {
                [indicatorView removeFromSuperview];
//            }];
        }
    }
}
- (CABasicAnimation*)strokeEndAnimation{
    CABasicAnimation *end = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    end.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    end.duration = 0.5;
    end.fromValue = 0;
    end.toValue = @0.95;
    end.removedOnCompletion = false;
    end.fillMode = kCAFillModeForwards;
    end.removedOnCompletion = NO;

    return end;
}

- (CABasicAnimation*)strokeStartAnimation{
    CABasicAnimation *start = [CABasicAnimation animationWithKeyPath:@"strokeStart"];
    start.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    start.duration = 0.5;
    start.fromValue = 0;
    start.toValue = @0.95;
    start.beginTime = 0.5;
    start.removedOnCompletion = false;
    start.fillMode = kCAFillModeForwards;
    start.removedOnCompletion = NO;

    return start;
}
- (CAAnimationGroup*)animationGroup{
    CAAnimationGroup* group = [CAAnimationGroup animation];
    group.animations = @[[self strokeEndAnimation],[self strokeStartAnimation]];
    group.repeatCount = HUGE;
    group.duration = 1;
    group.removedOnCompletion = NO;
    return group;
}

- (CABasicAnimation*)rotateZAnimation {
    CABasicAnimation* rotateZ = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    rotateZ.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    rotateZ.duration = 1;
    rotateZ.fromValue = 0;
    rotateZ.toValue = @(2 * M_PI);
    rotateZ.repeatCount = HUGE;
    rotateZ.removedOnCompletion = NO;
    return rotateZ;
}


- (void)beginAnimation {


    [UIView animateWithDuration:0.2 animations:^{
//        self.alpha = 1;

    } completion:^(BOOL finished) {
        switch (style) {
            case ZDMIndicatorStyleGradual:
                [self beginGradulaAnimation];
                break;
                
            default:
                [self beginNormalAnimation];
                break;
        }
    }];
}
- (void)beginGradulaAnimation{
    [self.indicatorLayer addAnimation:[self animationGroup] forKey:@"group"];
    [self.indicatorLayer addAnimation:[self rotateZAnimation] forKey:@"rotationZ"];
}
- (void)beginNormalAnimation{
    CABasicAnimation *end = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    end.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    end.duration = 1;
    end.fromValue = 0;
    end.toValue = @0.95;
    end.removedOnCompletion = true;
    end.fillMode = kCAFillModeForwards;
    CAAnimationGroup* group = [CAAnimationGroup animation];
    group.animations = @[end];
    group.repeatCount = 1;
    group.duration = 2;
    CABasicAnimation* rotateZ = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    rotateZ.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    rotateZ.duration = 1;
    rotateZ.fromValue = 0;
    rotateZ.toValue = @(2 * M_PI);
    rotateZ.repeatCount = HUGE;
    [self.indicatorLayer addAnimation:group forKey:@"group"];
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, 0.95 * NSEC_PER_SEC);
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        // code to be executed on the main queue after delay
        self.indicatorLayer.strokeStart = 0;
        self.indicatorLayer.strokeEnd = 0.95;
        [self.indicatorLayer addAnimation:rotateZ forKey:@"rotationZ"];
        
    });

}
-(void)endAnimationWithCompletion:(void (^)(BOOL finished))completion{
    [UIView animateWithDuration:0.2 animations:^{
//        self.alpha = 0;
    } completion:^(BOOL finished) {
        completion(finished);
    }];
}




@end
