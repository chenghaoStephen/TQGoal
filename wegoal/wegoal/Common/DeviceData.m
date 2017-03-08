//
//  DeviceData.m
//  SanbanNews
//
//  Created by zhengdongming on 15/6/15.
//  Copyright (c) 2015年 GuoXinHuiJin. All rights reserved.
//

#import "DeviceData.h"
#include <sys/types.h>
#include <sys/sysctl.h>
#import"KeychainItemWrapper.h"
@implementation DeviceData
@synthesize deviceName,deviceVersion;
@synthesize appVersion,appName;
@synthesize uuid;
+ (DeviceData*)shareManager{
    static DeviceData *sharedManagerInstance = nil;
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        sharedManagerInstance = [[self alloc] init];
        [sharedManagerInstance getDeviceData];
    });
    return sharedManagerInstance;
}
- (void)getDeviceData{
    
    self.deviceName = [self getCurrentDeviceName];
    self.deviceVersion = [self getCurrentDeviceVersion];
    self.uuid = [self getUUID];
//    self.appName = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleName"];
    self.appName = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleDisplayName"];
    self.appVersion = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
    if ([[NSUserDefaults standardUserDefaults]valueForKey:@"DEVICETOKEN"]) {
        self.deviceToken = [[NSUserDefaults standardUserDefaults]valueForKey:@"DEVICETOKEN"];
    }else{
        self.deviceToken = @"";
    }
    if ([[NSUserDefaults standardUserDefaults]integerForKey:@"NEWSFONTSIZE"]) {
        self.newsFont = (int)[[NSUserDefaults standardUserDefaults]integerForKey:@"NEWSFONTSIZE"];

    }else{
        self.newsFont = FONT_NORMAL;
    }
    if ([[NSUserDefaults standardUserDefaults]valueForKey:@"NEWS_PUSH"]) {
        self.newsPush = [[[NSUserDefaults standardUserDefaults]valueForKey:@"NEWS_PUSH"]isEqualToString:@"enabled"]?YES:NO;
        
    }else{
        self.newsPush = YES;
    }
    if ([[NSUserDefaults standardUserDefaults]valueForKey:@"PUSH_SOUND"]) {
        self.pushSound = [[[NSUserDefaults standardUserDefaults]valueForKey:@"PUSH_SOUND"]isEqualToString:@"enabled"]?YES:NO;
        
    }else{
        self.pushSound = YES;
    }
    if ([[NSUserDefaults standardUserDefaults]integerForKey:@"REFREQUENCY"]) {
        self.reFrequency = (int)[[NSUserDefaults standardUserDefaults]integerForKey:@"REFREQUENCY"];
        
    }else{
        self.reFrequency = 5;
    }
    if ([[NSUserDefaults standardUserDefaults]valueForKey:@"NEWAPPVERSION"]) {
        self.oldAppVersion = [[NSUserDefaults standardUserDefaults]valueForKey:@"NEWAPPVERSION"];
        if ([self.oldAppVersion compare:self.appVersion] == NSOrderedAscending) {
            self.oldAppVersion = self.appVersion;
            self.fristOpen = YES;
            [[NSUserDefaults standardUserDefaults]setValue:_oldAppVersion forKey:@"NEWAPPVERSION"];
            [[NSUserDefaults standardUserDefaults]synchronize];
        }

    }else{
        self.oldAppVersion = self.appVersion;
        self.fristOpen = YES;
        [[NSUserDefaults standardUserDefaults]setValue:_oldAppVersion forKey:@"NEWAPPVERSION"];
        [[NSUserDefaults standardUserDefaults]synchronize];
    }
}

// 系统版本
- (NSString*)getCurrentDeviceVersion{
    
    return [NSString stringWithFormat:@"%@-%@",[[UIDevice currentDevice] systemName],[[UIDevice currentDevice] systemVersion]];
}
//获得设备型号
- (NSString *)getCurrentDeviceName
{
    int mib[2];
    size_t len;
    char *machine;
    
    mib[0] = CTL_HW;
    mib[1] = HW_MACHINE;
    sysctl(mib, 2, NULL, &len, NULL, 0);
    machine = malloc(len);
    sysctl(mib, 2, machine, &len, NULL, 0);
    
    NSString *platform = [NSString stringWithCString:machine encoding:NSASCIIStringEncoding];
    free(machine);
    
    if ([platform isEqualToString:@"iPhone1,1"]) return @"iPhone 2G (A1203)";
    if ([platform isEqualToString:@"iPhone1,2"]) return @"iPhone 3G (A1241/A1324)";
    if ([platform isEqualToString:@"iPhone2,1"]) return @"iPhone 3GS (A1303/A1325)";
    if ([platform isEqualToString:@"iPhone3,1"]) return @"iPhone 4 (A1332)";
    if ([platform isEqualToString:@"iPhone3,2"]) return @"iPhone 4 (A1332)";
    if ([platform isEqualToString:@"iPhone3,3"]) return @"iPhone 4 (A1349)";
    if ([platform isEqualToString:@"iPhone4,1"]) return @"iPhone 4S (A1387/A1431)";
    if ([platform isEqualToString:@"iPhone5,1"]) return @"iPhone 5 (A1428)";
    if ([platform isEqualToString:@"iPhone5,2"]) return @"iPhone 5 (A1429/A1442)";
    if ([platform isEqualToString:@"iPhone5,3"]) return @"iPhone 5c (A1456/A1532)";
    if ([platform isEqualToString:@"iPhone5,4"]) return @"iPhone 5c (A1507/A1516/A1526/A1529)";
    if ([platform isEqualToString:@"iPhone6,1"]) return @"iPhone 5s (A1453/A1533)";
    if ([platform isEqualToString:@"iPhone6,2"]) return @"iPhone 5s (A1457/A1518/A1528/A1530)";
    if ([platform isEqualToString:@"iPhone7,1"]) return @"iPhone 6 Plus (A1522/A1524)";
    if ([platform isEqualToString:@"iPhone7,2"]) return @"iPhone 6 (A1549/A1586)";
    if ([platform isEqualToString:@"iPhone8,1"]) return @"iPhone 6s ()";
    if ([platform isEqualToString:@"iPhone8,2"]) return @"iPhone 6s Plus()";
    if ([platform isEqualToString:@"iPhone8,4"]) return @"iPhone SE";
    if ([platform isEqualToString:@"iPhone9,1"]) return @"iPhone 7 ()";
    if ([platform isEqualToString:@"iPhone9,2"]) return @"iPhone 7 Plus()";
    
    if ([platform isEqualToString:@"iPod1,1"])   return @"iPod Touch 1G (A1213)";
    if ([platform isEqualToString:@"iPod2,1"])   return @"iPod Touch 2G (A1288)";
    if ([platform isEqualToString:@"iPod3,1"])   return @"iPod Touch 3G (A1318)";
    if ([platform isEqualToString:@"iPod4,1"])   return @"iPod Touch 4G (A1367)";
    if ([platform isEqualToString:@"iPod5,1"])   return @"iPod Touch 5G (A1421/A1509)";
    
    if ([platform isEqualToString:@"iPad1,1"])   return @"iPad 1G (A1219/A1337)";
    if ([platform isEqualToString:@"iPad2,1"])   return @"iPad 2 (A1395)";
    if ([platform isEqualToString:@"iPad2,2"])   return @"iPad 2 (A1396)";
    if ([platform isEqualToString:@"iPad2,3"])   return @"iPad 2 (A1397)";
    if ([platform isEqualToString:@"iPad2,4"])   return @"iPad 2 (A1395+New Chip)";
    if ([platform isEqualToString:@"iPad2,5"])   return @"iPad Mini 1G (A1432)";
    if ([platform isEqualToString:@"iPad2,6"])   return @"iPad Mini 1G (A1454)";
    if ([platform isEqualToString:@"iPad2,7"])   return @"iPad Mini 1G (A1455)";
    
    if ([platform isEqualToString:@"iPad3,1"])   return @"iPad 3 (A1416)";
    if ([platform isEqualToString:@"iPad3,2"])   return @"iPad 3 (A1403)";
    if ([platform isEqualToString:@"iPad3,3"])   return @"iPad 3 (A1430)";
    if ([platform isEqualToString:@"iPad3,4"])   return @"iPad 4 (A1458)";
    if ([platform isEqualToString:@"iPad3,5"])   return @"iPad 4 (A1459)";
    if ([platform isEqualToString:@"iPad3,6"])   return @"iPad 4 (A1460)";
    
    if ([platform isEqualToString:@"iPad4,1"])   return @"iPad Air (A1474)";
    if ([platform isEqualToString:@"iPad4,2"])   return @"iPad Air (A1475)";
    if ([platform isEqualToString:@"iPad4,3"])   return @"iPad Air (A1476)";
    if ([platform isEqualToString:@"iPad4,4"])   return @"iPad Mini 2G (A1489)";
    if ([platform isEqualToString:@"iPad4,5"])   return @"iPad Mini 2G (A1490)";
    if ([platform isEqualToString:@"iPad4,6"])   return @"iPad Mini 2G (A1491)";
    
    if ([platform isEqualToString:@"i386"])      return @"iPhone Simulator";
    if ([platform isEqualToString:@"x86_64"])    return @"iPhone Simulator";
    return platform;
}

- (NSString*)getUUID{
    NSString *gen_uuid =nil;
    KeychainItemWrapper *keychainItem = [[KeychainItemWrapper alloc] initWithIdentifier:@"UUID" accessGroup:[NSString stringWithFormat:@"%@.com.gxfin.cnfin" ,[self bundleSeedID]]];
    
    NSString *uuidStr = [keychainItem objectForKey:(__bridge id)kSecValueData];
    if (uuidStr.length == 0) {
        NSString *myUUIDStr = [[[UIDevice currentDevice] identifierForVendor] UUIDString];
        [keychainItem setObject:myUUIDStr forKey:(__bridge id)kSecValueData];
        gen_uuid = myUUIDStr;
    }else{
        gen_uuid = [keychainItem objectForKey:(__bridge id)kSecValueData];
    }
    NSLog(@"udid======%@",gen_uuid);
    return gen_uuid;
    
}

- (NSString *)bundleSeedID {
    NSDictionary *query = [NSDictionary dictionaryWithObjectsAndKeys:
                           (__bridge id)(kSecClassGenericPassword), kSecClass,
                           @"bundleSeedID", kSecAttrAccount,
                           @"", kSecAttrService,
                           (id)kCFBooleanTrue, kSecReturnAttributes,
                           nil];
    CFDictionaryRef result = nil;
    OSStatus status = SecItemCopyMatching((__bridge CFDictionaryRef)query, (CFTypeRef *)&result);
    if (status == errSecItemNotFound)
        status = SecItemAdd((__bridge CFDictionaryRef)query, (CFTypeRef *)&result);
    if (status != errSecSuccess)
        return nil;
    NSString *accessGroup = [(__bridge NSDictionary *)result objectForKey:(__bridge id)(kSecAttrAccessGroup)];
    NSArray *components = [accessGroup componentsSeparatedByString:@"."];
    NSString *bundleSeedID = [[components objectEnumerator] nextObject];
    CFRelease(result);
    return bundleSeedID;
}

- (void)setNewsFont:(NEWS_FONT_SIZE)newsFont{
    _newsFont = newsFont;
    
    switch (_newsFont) {
        case 1:
            self.newsFontValue = @"16";
            break;
        case 2:
            self.newsFontValue = @"18";
            break;
        case 3:
            self.newsFontValue = @"21";
            break;
        case 4:
            self.newsFontValue = @"24";
            break;
        default:
            self.newsFontValue = @"18";
            break;
    }
    [[NSUserDefaults standardUserDefaults]setInteger:_newsFont forKey:@"NEWSFONTSIZE"];
    [[NSUserDefaults standardUserDefaults]synchronize];
}

- (void)setNewsPush:(BOOL)newsPush{
    _newsPush = newsPush;
    [[NSUserDefaults standardUserDefaults]setValue:_newsPush?@"enabled":@"disabled"  forKey:@"NEWS_PUSH"];
    [[NSUserDefaults standardUserDefaults]synchronize];
}

- (void)setPushSound:(BOOL)pushSound{
    _pushSound = pushSound;
    [[NSUserDefaults standardUserDefaults]setValue:_pushSound?@"enabled":@"disabled" forKey:@"PUSH_SOUND"];
    [[NSUserDefaults standardUserDefaults]synchronize];
}

- (void)setReFrequency:(NSInteger)reFrequency{
    _reFrequency = reFrequency;
    [[NSUserDefaults standardUserDefaults]setInteger:_reFrequency forKey:@"REFREQUENCY"];
    [[NSUserDefaults standardUserDefaults]synchronize];
}

- (void)setNewAppVersion:(NSString *)newAppVersion{
    _oldAppVersion = newAppVersion;
    [[NSUserDefaults standardUserDefaults]setValue:_oldAppVersion forKey:@"NEWAPPVERSION"];
    [[NSUserDefaults standardUserDefaults]synchronize];
}
- (void)setDeviceToken:(NSString *)deviceToken{
    _deviceToken = deviceToken;
    [[NSUserDefaults standardUserDefaults]setValue:_deviceToken forKey:@"DEVICETOKEN"];
    [[NSUserDefaults standardUserDefaults]synchronize];
}

@end
