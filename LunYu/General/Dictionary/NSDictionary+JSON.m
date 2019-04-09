//
//  NSDictionary+JSON.m
//  iWhy
//
//  Created by zhengqiang zhang on 2018/12/17.
//  Copyright © 2018 上海宝云网络. All rights reserved.
//

#import "NSDictionary+JSON.h"

@implementation NSDictionary (JSON)

- (NSString *)JSONString {
    NSData *data = [NSJSONSerialization dataWithJSONObject:self options:kNilOptions error:nil];
    return [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
}

+ (NSDictionary *)dictionWithJSONString:(NSString *)string {
    NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:[string dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingAllowFragments error:nil];
    
    return dict;
}

@end
