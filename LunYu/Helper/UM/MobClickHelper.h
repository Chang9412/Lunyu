//
//  MobClick.h
//  iWhy
//
//  Created by zhengqiang zhang on 2018/12/3.
//  Copyright © 2018 上海宝云网络. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MobClickHelper : NSObject

+ (void)start;

+ (void)event:(NSString *)eventID;
+ (void)event:(NSString *)eventID attributes:(NSDictionary *)attributes;

@end
