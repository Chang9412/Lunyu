//
//  TimingClosure.h
//  iWhy
//
//  Created by zhengqiang zhang on 2018/12/28.
//  Copyright © 2018 上海宝云网络. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TimingClosure : NSObject

@property(nonatomic, assign) NSInteger limit;
@property(nonatomic, strong) NSDate *startDate;
@property(nonatomic, assign) NSInteger remainTime;
@property(nonatomic, assign) BOOL timing;

@property(nonatomic, copy) void (^timingDidChange)(NSInteger remainTime);
@property(nonatomic, copy) void (^timingDidEnd)(void);

+ (instancetype)shareInstance;

@end
