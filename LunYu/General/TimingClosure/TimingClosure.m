
//
//  TimingClosure.m
//  iWhy
//
//  Created by zhengqiang zhang on 2018/12/28.
//  Copyright © 2018 上海宝云网络. All rights reserved.
//

#import "TimingClosure.h"

@interface TimingClosure ()

@property(nonatomic, strong) NSTimer *timer;

@end


@implementation TimingClosure

+ (instancetype)shareInstance {
    static TimingClosure *instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[TimingClosure alloc] init];
    });
    return instance;
}

- (instancetype)init {
    if (self = [super init]) {
        _limit = -1;
    }
    return self;
}

- (void)setLimit:(NSInteger)limit {
    _limit = limit;
    _remainTime = limit;
}

- (void)setStartDate:(NSDate *)startDate {
    _startDate = startDate;
    if (_timer) {
        [_timer invalidate];
        _timer = nil;
    }
    self.timer.fireDate = [NSDate date];
    self.timing = YES;
}

- (void)onTimerCallback {
    if (self.timingDidChange) {
        self.timingDidChange(self.remainTime);
    }
    self.remainTime = self.limit - [[NSDate date] timeIntervalSinceDate:self.startDate];
    if (self.remainTime < 0) {
        [self.timer invalidate];
        self.timer = nil;
        self.limit = -1;
        self.timing = NO;
        _startDate = nil;
        if (self.timingDidEnd) {
            self.timingDidEnd();
        }
    }
}

- (NSTimer *)timer {
    if (_timer == nil) {
        _timer = [NSTimer timerWithTimeInterval:1 target:self selector:@selector(onTimerCallback) userInfo:nil repeats:YES];
        [[NSRunLoop mainRunLoop] addTimer:_timer forMode:NSRunLoopCommonModes];
        _timer.fireDate = [NSDate distantFuture];
    }
    return _timer;
}

@end
