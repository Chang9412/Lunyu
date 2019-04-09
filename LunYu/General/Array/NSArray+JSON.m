//
//  NSArray+JSON.m
//  iWhy
//
//  Created by zhengqiang zhang on 2018/12/17.
//  Copyright © 2018 上海宝云网络. All rights reserved.
//

#import "NSArray+JSON.h"

@implementation NSArray (JSON)

- (NSString *)JSONString {
    NSData *data = [NSJSONSerialization dataWithJSONObject:self options:kNilOptions error:nil];
    return [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
}

+ (NSArray *)arrayWithJSONString:(NSString *)string {
    if (string == nil || string.length == 0) {
        return nil;
    }
    NSArray *array = [NSJSONSerialization JSONObjectWithData:[string dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingAllowFragments error:nil];
    
    return array;
}

@end
