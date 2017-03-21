//
//  AppDelegate.m
//  wegoal
//
//  Created by joker on 2016/11/23.
//  Copyright © 2016年 xdkj. All rights reserved.
//

#import "AppDelegate.h"
#import<ShareSDK/ShareSDK.h>
#import<WXApi.h>
#import<ShareSDKConnector/ShareSDKConnector.h>
#import<TencentOpenAPI/QQApiInterface.h>
#import<TencentOpenAPI/TencentOAuth.h>

@interface AppDelegate ()<WXApiDelegate>

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.tabBarController = [[TQTabBarController alloc] init];
    self.window.rootViewController = self.tabBarController;
    [self.window makeKeyAndVisible];
    
    [self registerShareSdk];
    return YES;
    
}

- (void)registerShareSdk
{
    [ShareSDK registerApp:kShareSdkAppId
          activePlatforms:@[@(SSDKPlatformSubTypeWechatSession),
                            @(SSDKPlatformSubTypeWechatTimeline),
                            @(SSDKPlatformTypeQQ)
                            ]
                 onImport:^(SSDKPlatformType platformType) {
                     switch (platformType) {
                         case SSDKPlatformTypeWechat: {
                             [ShareSDKConnector connectWeChat:[WXApi class]];
                         }
                             break;
                             
                         case SSDKPlatformTypeQQ: {
                             [ShareSDKConnector connectQQ:[QQApiInterface class] tencentOAuthClass:[TencentOAuth class]];
                         }
                             break;
                             
                         default:
                             break;
                     }
                 }
          onConfiguration:^(SSDKPlatformType platformType, NSMutableDictionary *appInfo) {
              switch (platformType) {
                      
                  case SSDKPlatformTypeWechat: {
                      [appInfo SSDKSetupWeChatByAppId:kWechatAppId appSecret:kWechatAppSecret];
                  }
                      break;
                      
                  case SSDKPlatformTypeQQ: {
                      [appInfo SSDKSetupQQByAppId:kQQAppId appKey:kQQAppKey authType:SSDKAuthTypeSSO];
                  }
                      break;
                      
                  default:
                      break;
                      
              }
          }
     ];
    
}

- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url {
    [WXApi handleOpenURL:url delegate:self];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
