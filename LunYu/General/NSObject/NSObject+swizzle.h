//
//  NSObject+swizzle.h
//  WallPaper
//
//  Created by zhengqiang zhang on 2019/2/27.
//  Copyright © 2019 上海宝云网络. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSObject (swizzle)

+ (BOOL)swizzleInstanceMethod:(SEL)oriSelector withNewMethod:(SEL)newSelector;
+ (BOOL)swizzleClassMethod:(SEL)origSelector withMethod:(SEL)newSelector;

@end

NS_ASSUME_NONNULL_END
