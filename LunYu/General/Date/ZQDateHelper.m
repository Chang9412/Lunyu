//
//  HJDateHelper.m
//  HanjuTV
//
//  Created by Fred Gan on 2017/1/15.
//  Copyright © 2017年 上海宝云网络. All rights reserved.
//

#import "ZQDateHelper.h"
#import <NSDate+Additions.h>

@implementation ZQDateHelper

+ (NSString *)timeStringForDate:(NSDate *)date {
    NSDate *currentDate = [NSDate date];
    NSInteger days = [date daysBeforeDate:currentDate];
    if (days > 7) {
        NSDateFormatter *formatter;
        if ([date isThisYear]) {
            formatter = [self mdDateFormatter];
        } else {
            formatter = [self ymdDateFormatter];
        }
        return [formatter stringFromDate:date];
    }
    if (days > 0) {
        return [NSString stringWithFormat:@"%@天前",@(days)];
    } else {
        NSInteger hours = [date hoursBeforeDate:currentDate];
        if (hours > 0) {
            return [NSString stringWithFormat:@"%@小时前",@(hours)];
        } else {
            NSInteger minutes = [date minutesBeforeDate:currentDate];
            if (minutes > 0) {
                return [NSString stringWithFormat:@"%@分钟前",@(minutes)];
            }
            return @"刚刚";
        }
    }
}

+ (NSDateFormatter *)mdDateFormatter {
    static NSDateFormatter *formatter ;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        formatter = [[NSDateFormatter alloc] init];
        formatter.dateFormat = @"MM-dd";
    });
    return formatter;
}

+ (NSDateFormatter *)ymdDateFormatter {
    static NSDateFormatter *formatter ;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        formatter = [[NSDateFormatter alloc] init];
        formatter.dateFormat = @"yy-MM-dd";
    });
    return formatter;
}
@end
