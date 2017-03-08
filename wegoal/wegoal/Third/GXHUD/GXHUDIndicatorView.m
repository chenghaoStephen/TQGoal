//
//  GXHUDIndicatorView.m
//  GXHUDIndicatorView
//
//  Created by zhengdongming on 16/3/9.
//  Copyright © 2016年 MING.Z. All rights reserved.
//

#import "GXHUDIndicatorView.h"

@interface GXHUDIndicatorView()
{
    CAShapeLayer * arcLayer;
}
@property (strong,nonatomic) UIView*bgView;
@property (strong,nonatomic) UIImageView*imageView;
@property (strong,nonatomic) UIView*helpView;

@end
@implementation GXHUDIndicatorView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.bgView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 120, 120)];
//        self.bgView.backgroundColor = [UIColor colorWithWhite:0 alpha:0.3];
        self.bgView.center = CGPointMake(frame.size.width/2, frame.size.height/2);
        [self addSubview:self.bgView];
        
        self.imageView = [[UIImageView alloc]initWithFrame:CGRectMake(48, 48, 64, 64)];
        self.imageView.image = [UIImage imageNamed:@"gx_hud_logo"];
        self.imageView.center = CGPointMake(self.bgView.frame.size.width/2, self.bgView.frame.size.height/2);
        self.imageView.layer.cornerRadius = 32;
        self.imageView.layer.masksToBounds = YES;
        self.imageView.backgroundColor = [UIColor whiteColor];
        [self.bgView addSubview:self.imageView];
        
        self.helpView = [[UIView alloc]initWithFrame:self.imageView.frame];
        self.helpView.backgroundColor = [UIColor clearColor];
        self.helpView.layer.borderWidth = 2;
        self.helpView.layer.borderColor = [UIColor colorWithWhite:0 alpha:0.2].CGColor;
        self.helpView.layer.cornerRadius = self.imageView.frame.size.width/2;
        self.helpView.center = self.imageView.center;
        [self.bgView addSubview:self.helpView];
        
        self.bgView.layer.cornerRadius = viewCornerRadius;
        self.bgView.layer.masksToBounds = YES;
        
        //创建logo上的圆弧
        arcLayer = [CAShapeLayer layer];
        UIBezierPath * arcPatch = [UIBezierPath bezierPathWithArcCenter:CGPointMake(self.helpView.frame.size.width/2, self.helpView.frame.size.height/2) radius:self.helpView.frame.size.width / 2 - 1 startAngle:0 endAngle: M_PI * 2 clockwise:YES];
        arcLayer.path = arcPatch.CGPath;
        arcLayer.lineWidth = 2;
        arcLayer.strokeStart = 11 / 16.0;
        arcLayer.strokeEnd = 13 / 16.0;
        arcLayer.fillColor = [UIColor clearColor].CGColor;
        arcLayer.strokeColor = [UIColor redColor].CGColor;
        
        [self.helpView.layer addSublayer:arcLayer];
        
    }
    return self;
}
+ (void)showInView:(UIView*)superView {
    [GXHUDIndicatorView showInView:superView withEnable:NO];
}
+ (void)showInView:(UIView*)superView withEnable:(BOOL)enable{
    if (![GXHUDIndicatorView isShowInView:superView]) {
        GXHUDIndicatorView *indicatorView = [[self alloc]initWithFrame:CGRectMake(0, 0, superView.frame.size.width, superView.frame.size.height)];
        [superView addSubview:indicatorView];
        indicatorView.userInteractionEnabled = !enable;

        [indicatorView beginAnimation];
    }
    
}

+ (BOOL)isShowInView:(UIView *)superView{
    for (UIView *view in  superView.subviews) {
        if ([view isKindOfClass:[GXHUDIndicatorView class]]) {
            return YES;
        }
    }
    return NO;
}

+ (void)hiddenInView:(UIView *)superView{
    for (UIView *view in  superView.subviews) {
        if ([view isKindOfClass:[GXHUDIndicatorView class]]) {
            GXHUDIndicatorView *indicatorView  = (GXHUDIndicatorView*)view;
            [indicatorView endAnimation];
        }
    }
}

//MARK: 开始动画
-(void) beginAnimation
{

    CABasicAnimation * rotaionAnimation = [CABasicAnimation animationWithKeyPath:@"transform"];
    rotaionAnimation.toValue = [NSValue valueWithCATransform3D:CATransform3DMakeRotation(M_PI-1, 0, 0, 1)];
    rotaionAnimation.duration = animationTime;
    rotaionAnimation.repeatCount = MAXFLOAT;
    rotaionAnimation.cumulative = YES;
    [self.helpView.layer addAnimation:rotaionAnimation forKey:@"rotationZ"];
}

//MARK: 终止动画 并销毁hud
-(void) endAnimation
{
    [UIView animateWithDuration:hiddenHudAnimationTime animations:^{
        self.alpha = 0.0;
    } completion:^(BOOL finished) {
        if (finished == YES)
        {
            [self.bgView.layer removeAnimationForKey:@"rotationZ"];
            [self removeFromSuperview ];
            
        }
    }];
    
}


@end
