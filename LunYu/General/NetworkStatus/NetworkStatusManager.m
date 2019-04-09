//
//  NetworkStatusManager.m
//  App
//
//  Created by m on 16/3/17.
//  Copyright © 2016年 上海宝云网络. All rights reserved.
//

#import "NetworkStatusManager.h"
#import <AFNetworking/AFNetworkReachabilityManager.h>
#import <CoreTelephony/CTTelephonyNetworkInfo.h>
#include <ifaddrs.h>
#include <arpa/inet.h>
#import <netinet/in.h>
#import <sys/sysctl.h>
#import "route.h"

NSString * const kNetworkStatusChangedNotification = @"kNetworkStatusChangedNotification";

@interface NetworkStatusManager ()

@property(nonatomic) AFNetworkReachabilityManager *reachabilityManager;
@property(nonatomic) AFNetworkReachabilityStatus  currentStatus;

@property(nonatomic) NSString *localIp;
@property(nonatomic) NSString *gatewayIp;

@end

@implementation NetworkStatusManager

+ (instancetype)sharedInstance {
    static id instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[self alloc] init];
    });
    return instance;
}

- (instancetype)init {
    self = [super init];
    self.reachabilityManager = [AFNetworkReachabilityManager sharedManager];
    return self;
}

- (void)startMonitoring {
    [self.reachabilityManager startMonitoring];
    SWWeak(self);
    [self.reachabilityManager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        SWStrong(self);
        if (self.currentStatus != status) {
            self.currentStatus = status;
            [self onNetworkStatusChanged:status];
        }
    }];
}

- (void)stopMonitoring {
    [self.reachabilityManager stopMonitoring];
}

- (void)onNetworkStatusChanged:(AFNetworkReachabilityStatus)status {
    AppLog(@"网络状态变化：%@", AFStringFromNetworkReachabilityStatus(status));
//    [NotificationHelper pushNotfication:kNetworkStatusChangedNotification userInfo:@{@"status":@(status)}];
    [[NSNotificationCenter defaultCenter] postNotificationName:kNetworkStatusChangedNotification object:nil userInfo:@{@"status":@(status)}];
    self.localIp = [self fetchLocalIp];
    self.gatewayIp = [self fetchGatewayIP];
}

- (NetworkStatus)networkStatus {
    switch (self.reachabilityManager.networkReachabilityStatus) {
        case AFNetworkReachabilityStatusNotReachable: {
            return NetworkStatusNotReachable;
        }
        case AFNetworkReachabilityStatusReachableViaWWAN: {
            NSArray *typeStrings2G = @[CTRadioAccessTechnologyEdge,
                                      CTRadioAccessTechnologyGPRS,
                                      CTRadioAccessTechnologyCDMA1x];
            
            NSArray *typeStrings3G = @[CTRadioAccessTechnologyHSDPA,
                                       CTRadioAccessTechnologyWCDMA,
                                       CTRadioAccessTechnologyHSUPA,
                                       CTRadioAccessTechnologyCDMAEVDORev0,
                                       CTRadioAccessTechnologyCDMAEVDORevA,
                                       CTRadioAccessTechnologyCDMAEVDORevB,
                                       CTRadioAccessTechnologyeHRPD];
            
            NSArray *typeStrings4G = @[CTRadioAccessTechnologyLTE];
            NetworkStatus returnValue;
            if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0) {
                CTTelephonyNetworkInfo *teleInfo= [[CTTelephonyNetworkInfo alloc] init];
                NSString *accessString = teleInfo.currentRadioAccessTechnology;
                if ([typeStrings4G containsObject:accessString]) {
                    returnValue = NetworkStatusReachableViaWWAN4G;
                } else if ([typeStrings3G containsObject:accessString]) {
                    returnValue = NetworkStatusReachableViaWWAN3G;
                } else if ([typeStrings2G containsObject:accessString]) {
                    returnValue = NetworkStatusReachableViaWWAN2G;
                } else {
                    returnValue = NetworkStatusReachableViaWWANUnknow;
                }
            } else {
                returnValue = NetworkStatusReachableViaWWANUnknow;
            }

            return returnValue;
        }
        case AFNetworkReachabilityStatusReachableViaWiFi: {
            return NetworkStatusReachableViaWiFi;
        }
        default:
            return NetworkStatusUnknow;
    }
}

- (BOOL)canJudgeNetworkStatus {
    return self.networkStatus != NetworkStatusUnknow;
}

- (BOOL)reachable {
    return [self.reachabilityManager isReachable];
}

- (BOOL)isViaWWAN {
    return [self.reachabilityManager isReachableViaWWAN];
}

- (BOOL)isViaWiFi {
    return [self.reachabilityManager isReachableViaWiFi];
}

- (NSString *)fetchLocalIp {
    NSString *address = nil;
    struct ifaddrs *interfaces = NULL;
    struct ifaddrs *temp_addr = NULL;
    int success = 0;
    
    success = getifaddrs(&interfaces);
    
    if (success == 0) { // 0 表示获取成功
        
        temp_addr = interfaces;
        while (temp_addr != NULL) {
            if( temp_addr->ifa_addr->sa_family == AF_INET) {
                // Check if interface is en0 which is the wifi connection on the iPhone
                if ([[NSString stringWithUTF8String:temp_addr->ifa_name] isEqualToString:@"en0"]) {
                    // Get NSString from C String
                    address = [NSString stringWithUTF8String:inet_ntoa(((struct sockaddr_in  *)temp_addr->ifa_addr)->sin_addr)];
                }
            }
            
            temp_addr = temp_addr->ifa_next;
        }
    }
    
    freeifaddrs(interfaces);
    
    AppLog(@"局域网IP是：%@", address);
    
    return address;
}

#define ROUNDUP(a) \
((a) > 0 ? (1 + (((a) - 1) | (sizeof(long) - 1))) : sizeof(long))

- (NSString *)fetchGatewayIP {
    
    NSString *address = nil;
    
    /* net.route.0.inet.flags.gateway */
    int mib[] = {CTL_NET, PF_ROUTE, 0, AF_INET,
        NET_RT_FLAGS, RTF_GATEWAY};
    size_t l;
    char * buf, * p;
    struct rt_msghdr * rt;
    struct sockaddr * sa;
    struct sockaddr * sa_tab[RTAX_MAX];
    int i;
    int r = -1;
    
    if(sysctl(mib, sizeof(mib)/sizeof(int), 0, &l, 0, 0) < 0) {
//        address = @"192.168.0.1";
    }
    
    if (l <= 0) {
        return address;
    }
    
    buf = malloc(l);
    if(sysctl(mib, sizeof(mib)/sizeof(int), buf, &l, 0, 0) < 0) {
//        address = @"192.168.0.1";
    }
    
    for(p=buf; p<buf+l; p+=rt->rtm_msglen) {
        rt = (struct rt_msghdr *)p;
        sa = (struct sockaddr *)(rt + 1);
        for(i=0; i<RTAX_MAX; i++)
        {
            if(rt->rtm_addrs & (1 << i)) {
                sa_tab[i] = sa;
                sa = (struct sockaddr *)((char *)sa + ROUNDUP(sa->sa_len));
            } else {
                sa_tab[i] = NULL;
            }
        }
        
        if( ((rt->rtm_addrs & (RTA_DST|RTA_GATEWAY)) == (RTA_DST|RTA_GATEWAY))
           && sa_tab[RTAX_DST]->sa_family == AF_INET
           && sa_tab[RTAX_GATEWAY]->sa_family == AF_INET) {
            unsigned char octet[4]  = {0,0,0,0};
            int i;
            for (i=0; i<4; i++){
                octet[i] = ( ((struct sockaddr_in *)(sa_tab[RTAX_GATEWAY]))->sin_addr.s_addr >> (i*8) ) & 0xFF;
            }
            if(((struct sockaddr_in *)sa_tab[RTAX_DST])->sin_addr.s_addr == 0) {
                in_addr_t addr = ((struct sockaddr_in *)(sa_tab[RTAX_GATEWAY]))->sin_addr.s_addr;
                r = 0;
                address = [NSString stringWithFormat:@"%s", inet_ntoa(*((struct in_addr*)&addr))];
                AppLog(@"\ngateway ip address : %@",address);
                break;
            }
        }
    }
    free(buf);
    return address;
}

@end
