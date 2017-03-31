//
//  TQWelcomeViewController.m
//  wegoal
//
//  Created by joker on 2017/3/31.
//  Copyright © 2017年 xdkj. All rights reserved.
//

#import "TQWelcomeViewController.h"
#import "TQLoginRegisterView.h"

@interface TQWelcomeViewController ()<UIScrollViewDelegate, UINavigationControllerDelegate>

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIPageControl *pageControl;

@property (nonatomic, strong) TQLoginRegisterView *loginRegisterView;

@end

@implementation TQWelcomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationController.delegate = self;
    _scrollView.pagingEnabled = YES;
    _scrollView.scrollEnabled = YES;
    _scrollView.directionalLockEnabled = YES;
    _scrollView.showsHorizontalScrollIndicator = NO;
    _scrollView.showsVerticalScrollIndicator = NO;
    _scrollView.alwaysBounceHorizontal = YES;
    _scrollView.delegate = self;
    _scrollView.scrollsToTop = NO;
    _scrollView.contentSize = CGSizeMake(3*SCREEN_WIDTH, 0);
    
    [self addSubViews];
    
//    [[NSUserDefaults standardUserDefaults] setBool:YES forKey:kGuideViewShow];
}

- (void)addSubViews
{
    UIView *view1 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT + 20)];
    view1.backgroundColor = [UIColor whiteColor];
    UILabel *welcome1Lbl = [[UILabel alloc] initWithFrame:CGRectMake(0, 200, SCREEN_WIDTH, 60)];
    welcome1Lbl.textAlignment = NSTextAlignmentCenter;
    welcome1Lbl.font = [UIFont systemFontOfSize:32.f];
    welcome1Lbl.text = @"Welcome Page 1";
    [view1 addSubview:welcome1Lbl];
    [_scrollView addSubview:view1];
    
    UIView *view2 = [[UIView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH, 0, SCREEN_WIDTH, SCREEN_HEIGHT + 20)];
    view2.backgroundColor = [UIColor whiteColor];
    UILabel *welcome2Lbl = [[UILabel alloc] initWithFrame:CGRectMake(0, 200, SCREEN_WIDTH, 60)];
    welcome2Lbl.textAlignment = NSTextAlignmentCenter;
    welcome2Lbl.font = [UIFont systemFontOfSize:32.f];
    welcome2Lbl.text = @"Welcome Page 2";
    [view2 addSubview:welcome2Lbl];
    [_scrollView addSubview:view2];
    
    _loginRegisterView = [[TQLoginRegisterView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH*2, 0, SCREEN_WIDTH, SCREEN_HEIGHT + 20)];
    _loginRegisterView.backgroundColor = [UIColor whiteColor];
    [_scrollView addSubview:_loginRegisterView];
}


#pragma mark - UINavigationControllerDelegate

- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if ([viewController isKindOfClass:[TQWelcomeViewController class]]) {
        [navigationController setNavigationBarHidden:YES];
    } else {
        [navigationController setNavigationBarHidden:NO];
    }
}

#pragma mark - UIScrollView Delegate

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    [_pageControl setCurrentPage:(scrollView.contentOffset.x/scrollView.frame.size.width)];
    
}


@end
