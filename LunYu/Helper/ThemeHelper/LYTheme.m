//
//  LYTheme.m
//  LunYu
//
//  Created by zhengqiang zhang on 2019/4/1.
//  Copyright © 2019 chang. All rights reserved.
//

#import "LYTheme.h"

@implementation LYTheme

- (instancetype)initWithDict:(NSDictionary *)dict {
    if (self = [super init]) {
        _name = dict[@"name"];
        
        NSInteger c1  = strtol([dict[@"c1"] UTF8String], 0, 16);
        _c1 = [UIColor colorWithRGB:c1];
        
        NSInteger c2  = strtol([dict[@"c2"] UTF8String], 0, 16);
        _c2 = [UIColor colorWithRGB:c2];
        
        NSInteger c3  = strtol([dict[@"c3"] UTF8String], 0, 16);
        _c3 = [UIColor colorWithRGB:c3];
        
        NSInteger c4  = strtol([dict[@"c4"] UTF8String], 0, 16);
        _c4 = [UIColor colorWithRGB:c4];
        
        NSInteger backgroundColor  = strtol([dict[@"backgroundColor"] UTF8String], 0, 16);
        _backgroundColor = [UIColor colorWithRGB:backgroundColor];
    }
    return self;
}

@end
