//
//  TQInvitatePopViewController.h
//  wegoal
//
//  Created by joker on 2017/5/5.
//  Copyright © 2017年 xdkj. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, InviteType){
    InviteTypeCancel = 0,
    InviteTypeWechat,
    InviteTypeTimeLine,
    InviteTypeQQ,
    InviteTypeTeam,
};

@interface TQInvitatePopViewController : UIViewController

- (instancetype)initWithFrame:(CGRect)frame;
@property (nonatomic, copy) void(^inviteBlock)(InviteType inviteType);

@end
