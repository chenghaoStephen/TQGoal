//
//  TQInfoEditViewController.h
//  wegoal
//
//  Created by joker on 2017/4/1.
//  Copyright © 2017年 xdkj. All rights reserved.
//

#import "TQBaseViewController.h"

typedef NS_ENUM(NSInteger, EditType){
    EditTypeName = 0,  //昵称
    EditTypeTeam,      //球队
    EditTypeNumber,    //球号
    EditTypePosition,  //位置
    EditTypeAge,       //年龄
    EditTypeHeight,    //身高
    EditTypeWeight,    //体重
};

typedef void(^SubmitBlock)(NSString *text);
@interface TQInfoEditViewController : TQBaseViewController

@property (nonatomic, strong) NSString *titleName;
@property (nonatomic, strong) NSString *filledName;
@property (nonatomic, copy) SubmitBlock submitBlock;

@end
