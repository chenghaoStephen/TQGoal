//
//  UserData.m
//  WeGoal
//
//  Created by joker on 15/6/9.
//  Copyright (c) 2015年 WeGoal. All rights reserved.


#import "UserData.h"

#define kUserDataIdentifier     @"UserDataIdentifier"
@implementation UserData

+ (UserData*)shareManager{
    static UserData *sharedManagerInstance = nil;
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        sharedManagerInstance = [[self alloc] init];
    });
    return sharedManagerInstance;
}

#pragma mark pubilc func

- (void)setUserData:(NSDictionary *)userData
{
    if (userData) {
        [[NSUserDefaults standardUserDefaults] setObject:userData forKey:kUserDataIdentifier];
    }
}

- (TQMemberModel *)getUserData
{
    NSDictionary *dict =  [[NSUserDefaults standardUserDefaults] objectForKey:kUserDataIdentifier];
    if (dict != nil) {
        TQMemberModel *result = [TQMemberModel mj_objectWithKeyValues:dict];
        return result;
    }
    return nil;
}

- (NSDictionary *)getUserDataDict
{
    return [[NSUserDefaults standardUserDefaults] objectForKey:kUserDataIdentifier];
}

- (void)clearUserData
{
    [[NSUserDefaults standardUserDefaults] setObject:nil forKey:kUserDataIdentifier];
}

@end
