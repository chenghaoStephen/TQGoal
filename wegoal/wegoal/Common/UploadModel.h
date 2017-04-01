//
//  UploadModel.h
//  WeGoal
//
//  Created by joker on 15/9/9.
//  Copyright (c) 2015年 WeGoal. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UploadModel : NSObject
@property (nonatomic,strong) NSString*key;
@property (nonatomic,strong) NSString*fileName;
@property (nonatomic,strong) NSData*data;

@end
