//
//  UIDevice+Utils.m
//  App
//
//  Created by m on 16/3/17.
//  Copyright © 2016年 上海宝云网络. All rights reserved.
//

#import "UIDevice+Utils.h"
#import <CoreTelephony/CTTelephonyNetworkInfo.h>
#import <sys/utsname.h>

@implementation UIDevice (Utils)

+ (void)load {
    [UIDevice currentDevice].batteryMonitoringEnabled = YES;  
}

+ (BOOL)isIOS7OrLater {
    return [[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0;
}

+ (BOOL)isIOS8OrLater {
    return [[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0;
}

+ (BOOL)isIOS9OrLater {
    return [[[UIDevice currentDevice] systemVersion] floatValue] >= 9.0;
}

+ (BOOL)isIOS10OrLater {
    return [[[UIDevice currentDevice] systemVersion] floatValue] >= 10.0;
}

+ (BOOL)isIPad {
    return [[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad;
}

+ (CTCarrier *)carrier {
    static CTCarrier *carrier;
    if (!carrier) {
        CTTelephonyNetworkInfo *networkInfo = [[CTTelephonyNetworkInfo alloc] init];
        carrier = [networkInfo subscriberCellularProvider];
    }
    return carrier;
}

+ (NSString *)deviceName {
    struct utsname systemInfo;
    uname(&systemInfo);
    
    NSString *iOSDeviceModelsPath = [[NSBundle mainBundle] pathForResource:@"deviceModel" ofType:@"plist"];
    NSDictionary *iOSDevices = [NSDictionary dictionaryWithContentsOfFile:iOSDeviceModelsPath];
    
    NSString *deviceModel = [NSString stringWithCString:systemInfo.machine
                                               encoding:NSUTF8StringEncoding];
    NSString *deviceName = [iOSDevices valueForKey:deviceModel];
    if (!deviceName) {
        //当在表里找不到对应设备时
        if ([deviceModel rangeOfString:@"iPod"].location != NSNotFound) {
            deviceName = @"iPod Touch Unknown";
        }
        else if([deviceModel rangeOfString:@"iPad"].location != NSNotFound) {
            deviceName = @"iPad Unknown";
        }
        else if([deviceModel rangeOfString:@"iPhone"].location != NSNotFound){
            deviceName = @"iPhone Unknown";
        }
        else {
            deviceName = @"iOS Device Unknown";
        }
    }
    return deviceName;
}

+ (NSString *)systemVersion {
    return [UIDevice currentDevice].systemVersion;
}



+ (NSInteger)batteryLevel {
    float deviceLevel = [UIDevice currentDevice].batteryLevel;
    if (deviceLevel < 0) {
        deviceLevel = 0;
    }
    return (NSInteger)(deviceLevel * 100);
}

- (NSString *)deviceString {
    struct utsname systemInfo;
    uname(&systemInfo);
    NSString *platform = [NSString stringWithCString:systemInfo.machine encoding:NSUTF8StringEncoding];
    return platform;
}


+ (BOOL)isiPhoneX {
    // 先判断当前设备是否为 iPhone 或 iPod touch
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
        // 获取屏幕的宽度和高度，取较大一方判断是否为 812.0 或 896.0
        CGFloat screenWidth = [UIScreen mainScreen].bounds.size.width;
        CGFloat screenHeight = [UIScreen mainScreen].bounds.size.height;
        CGFloat maxLength = screenWidth > screenHeight ? screenWidth : screenHeight;
        if (maxLength == 812.0f || maxLength == 896.0f) {
            return YES;
        }
    }
    return NO;
}


@end
