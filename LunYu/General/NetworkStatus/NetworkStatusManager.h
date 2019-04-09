//
//  NetworkStatusManager.h
//  App
//
//  Created by m on 16/3/17.
//  Copyright © 2016年 上海宝云网络. All rights reserved.
//

#import <Foundation/Foundation.h>

extern NSString * const kNetworkStatusChangedNotification;

typedef NS_ENUM(NSInteger, NetworkStatus) {
    NetworkStatusUnknow = -1,
    NetworkStatusNotReachable,
    NetworkStatusReachableViaWWANUnknow,
    NetworkStatusReachableViaWWAN2G,
    NetworkStatusReachableViaWWAN3G,
    NetworkStatusReachableViaWWAN4G,
    NetworkStatusReachableViaWiFi
};

@interface NetworkStatusManager : NSObject

+ (instancetype)sharedInstance;

- (void)startMonitoring;
- (void)stopMonitoring;

- (NetworkStatus)networkStatus;

- (BOOL)canJudgeNetworkStatus;

- (BOOL)reachable;
- (BOOL)isViaWWAN;
- (BOOL)isViaWiFi;

- (NSString *)localIp;
- (NSString *)gatewayIp;

@end
