//
//  NSObject+swizzle.m
//  WallPaper
//
//  Created by zhengqiang zhang on 2019/2/27.
//  Copyright © 2019 上海宝云网络. All rights reserved.
//

#import "NSObject+swizzle.h"
#import <objc/runtime.h>

@implementation NSObject (swizzle)


+ (BOOL)swizzleInstanceMethod:(SEL)oriSelector withNewMethod:(SEL)newSelector {
    Method oriMethod = class_getInstanceMethod(self, oriSelector);
    Method newMethod = class_getInstanceMethod(self, newSelector);

    if (oriMethod && newMethod) {
        if (class_addMethod(self, oriSelector, method_getImplementation(newMethod), method_getTypeEncoding(newMethod))) {
            class_replaceMethod(self, newSelector, method_getImplementation(oriMethod), method_getTypeEncoding(oriMethod));
        } else {
            method_exchangeImplementations(oriMethod, newMethod);
        }
        return YES;
    }
    return NO;
}

+ (BOOL)swizzleClassMethod:(SEL)origSelector withMethod:(SEL)newSelector {
    Class metaClass = object_getClass(self);
    return [metaClass swizzleInstanceMethod:origSelector withNewMethod:newSelector];
}

@end
