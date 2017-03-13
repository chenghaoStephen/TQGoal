//
//  TQWebPageViewController.m
//  wegoal
//
//  Created by joker on 2017/3/13.
//  Copyright © 2017年 xdkj. All rights reserved.
//

#import "TQWebPageViewController.h"

@interface TQWebPageViewController ()

@property (nonatomic, strong) UIWebView *webView;

@end

@implementation TQWebPageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = kMainBackColor;
    [self.view addSubview:self.webView];
}

- (UIWebView *)webView
{
    if (!_webView) {
        _webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 1, SCREEN_WIDTH, VIEW_HEIGHT - 1)];
        _webView.backgroundColor = kMainBackColor;
    }
    return _webView;
}

- (void)setBannerModel:(TQBannerModel *)bannerModel
{
    _bannerModel = bannerModel;
    self.title = bannerModel.title;
//    NSURLRequest *requestUrl =[NSURLRequest requestWithURL:[NSURL URLWithString:bannerModel.customLink]
//                                               cachePolicy:NSURLRequestReloadRevalidatingCacheData
//                                           timeoutInterval:60];
    NSURLRequest *requestUrl =[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://www.baidu.com"]
                                               cachePolicy:NSURLRequestReloadRevalidatingCacheData
                                           timeoutInterval:60];
    [self.webView loadRequest:requestUrl];
    self.webView.scalesPageToFit = YES;
    
}


@end
