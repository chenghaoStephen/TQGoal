//
//  DownLoadModel.h
//  SanbanNews
//
//  Created by zhengdongming on 15/9/29.
//  Copyright (c) 2015年 GuoXinHuiJin. All rights reserved.
//

#import <Foundation/Foundation.h>
// 方便存储录音 filePath 默认路径 TMP_PATH; messageId 必传 fileType
@interface DownLoadModel : NSObject
@property (nonatomic,strong) NSString*messageId;
@property (nonatomic,strong) NSString*fileType;
@property (nonatomic,strong) NSString*filePath;
@property (nonatomic,strong) NSString*fileName;

@end
