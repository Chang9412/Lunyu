//
//  NSDictionary+JSON.h
//  iWhy
//
//  Created by zhengqiang zhang on 2018/12/17.
//  Copyright © 2018 上海宝云网络. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDictionary (JSON)

+ (NSDictionary *)dictionWithJSONString:(NSString *)string;

- (NSString *)JSONString;

@end
