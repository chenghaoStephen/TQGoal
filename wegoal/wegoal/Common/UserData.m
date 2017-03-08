//
//  UserData.m
//  SanbanNews
//
//  Created by zhengdongming on 15/6/9.
//  Copyright (c) 2015年 GuoXinHuiJin. All rights reserved.


#import "UserData.h"

@implementation UserData
@synthesize userData;
@synthesize userToken;
+ (UserData*)shareManager{
    static UserData *sharedManagerInstance = nil;
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        sharedManagerInstance = [[self alloc] init];
        [sharedManagerInstance readUserData];
    });
    return sharedManagerInstance;
}

// 读取数据
- (void)readUserData{
    self.userData = [NSKeyedUnarchiver unarchiveObjectWithFile: [self getUserDataPath]];
    
    self.userToken = [self.userData valueForKey:@"access_token"]!=[NSNull null]?[self.userData valueForKey:@"access_token"]:nil;
    
}
// 存储路径
- (NSString*)getUserDataPath{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *homeDictionary = [paths objectAtIndex:0];
    NSString *homePath  = [homeDictionary stringByAppendingPathComponent:@"UserDirectory"];//添加储存的文件名

    NSFileManager *filemanager = [NSFileManager defaultManager];
    
    if (![filemanager fileExistsAtPath:homePath]) {
        [filemanager createDirectoryAtPath:homePath withIntermediateDirectories:YES attributes:nil error:nil];
    }
    
    NSString * filename = [homePath stringByAppendingPathComponent:@"user.archiver"];
    
    //不存在文件则创建
    if (![filemanager fileExistsAtPath:filename]) {
        [filemanager  createFileAtPath:filename contents:nil attributes:nil];
    }
    
    return filename;
}
#pragma mark pubilc func

- (BOOL)saveUserData:(NSDictionary*)_userData{
    NSMutableDictionary *data = [NSMutableDictionary dictionaryWithCapacity:1];
    data[@"avatar_img"] = @"";
    for (NSString*key in [_userData allKeys] ) {
        if (_userData[key] != [NSNull null]) {
            data[key]= _userData[key];
        }
    }
    self.userData = data;
    self.userToken = [self.userData valueForKey:@"access_token"];
    
    return [NSKeyedArchiver archiveRootObject:self.userData toFile: [self getUserDataPath]];

}

- (BOOL)saveUserValue:(id)value forKey:(NSString*)key{
    if (self.userData == nil) {
        self.userData = [NSMutableDictionary dictionaryWithCapacity:5];

    }
    
    [self.userData setObject:value forKey:key];
    return [NSKeyedArchiver archiveRootObject:self.userData toFile: [self getUserDataPath]];
    
}
- (BOOL)deleteUserData{
    NSFileManager *fileManager = [[NSFileManager alloc]init];
    self.userToken = nil;
    if ([fileManager fileExistsAtPath:[self getUserDataPath]]) {
        return [fileManager removeItemAtPath:[self getUserDataPath] error:nil];
    }
    return YES;
}
@end
