//
//  GCDHelper.m
//  iWhy
//
//  Created by zhengqiang zhang on 2018/11/12.
//  Copyright © 2018 上海宝云网络. All rights reserved.
//

#import "GCDHelper.h"

@implementation GCDHelper

+ (void)main:(dispatch_block_t)block {
    dispatch_async(dispatch_get_main_queue(), ^{
        if (block) {
            block();
        }
    });
}

+ (void)back:(dispatch_block_t)block {
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        if (block) {
            block();
        }
    });
}


@end
