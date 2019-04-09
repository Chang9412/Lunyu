//
//  UIDevice+Utils.h
//  App
//
//  Created by m on 16/3/17.
//  Copyright © 2016年 上海宝云网络. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreTelephony/CTCarrier.h>

@interface UIDevice (Utils)

+ (BOOL)isIOS7OrLater;
+ (BOOL)isIOS8OrLater;
+ (BOOL)isIOS9OrLater;
+ (BOOL)isIOS10OrLater;
+ (BOOL)isIPad;
+ (BOOL)isiPhoneX;

+ (CTCarrier *)carrier;
+ (NSString *)deviceName;
// 电量0-100
+ (NSInteger)batteryLevel;

- (NSString *)deviceString;

@end
