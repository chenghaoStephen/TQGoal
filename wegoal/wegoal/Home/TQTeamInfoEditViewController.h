//
//  TQTeamInfoEditViewController.h
//  wegoal
//
//  Created by joker on 2017/4/20.
//  Copyright © 2017年 xdkj. All rights reserved.
//

#import "TQBaseViewController.h"
typedef NS_ENUM(NSInteger, TeamEditType){
    TeamEditTypeName = 0,      //球队名
    TeamEditTypeContactName,   //负责人姓名
    TeamEditTypeContactPhone,  //联系人电话
    TeamEditTypeTime,          //成立时间
};

typedef void(^SubmitBlock)(NSString *text);
@interface TQTeamInfoEditViewController : TQBaseViewController

@property (nonatomic, strong) NSString *titleName;
@property (nonatomic, assign) TeamEditType type;
@property (nonatomic, copy) SubmitBlock submitBlock;

@end
