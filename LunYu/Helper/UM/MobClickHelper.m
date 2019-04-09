//
//  MobClick.m
//  iWhy
//
//  Created by zhengqiang zhang on 2018/12/3.
//  Copyright © 2018 上海宝云网络. All rights reserved.
//

#import "MobClickHelper.h"
#import <UMMobClick/MobClick.h>

@implementation MobClickHelper

+ (void)start {
    NSString *appKey = [self appKey];
    [self startWithAppkey:appKey version:nil];
}

+ (void)startWithAppkey:(NSString *)appKey
                version:(NSString *)version {
    if (!version || version.length == 0) {
        version = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleShortVersionString"];
    }
    [MobClick setCrashReportEnabled:NO];
    [MobClick setAppVersion:version];
    UMConfigInstance.appKey = appKey;
    UMConfigInstance.channelId = @"App Store";
    UMConfigInstance.bCrashReportEnabled = NO;
    UMConfigInstance.ePolicy = SEND_INTERVAL;
    [MobClick startWithConfigure:UMConfigInstance];
}

+ (NSString *)appKey {
    return @"5c7260a9b465f56849000013";
}

+ (void)event:(NSString *)eventID {
    [MobClick event:eventID];
}

+ (void)event:(NSString *)eventID attributes:(NSDictionary *)attributes{
    [MobClick event:eventID attributes:attributes];
}
@end
