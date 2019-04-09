//
//  GCDHelper.h
//  iWhy
//
//  Created by zhengqiang zhang on 2018/11/12.
//  Copyright © 2018 上海宝云网络. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GCDHelper : NSObject

+ (void)main:(dispatch_block_t)block;
+ (void)back:(dispatch_block_t)block;

@end
