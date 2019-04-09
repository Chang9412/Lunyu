//
//  LYParagraph+Like.m
//  LunYu
//
//  Created by zhengqiang zhang on 2019/3/29.
//  Copyright © 2019 chang. All rights reserved.
//

#import "LYParagraph+Like.h"
#import <objc/runtime.h>

@implementation LYParagraph (Like)

- (void)setIsLike:(BOOL)isLike {
    objc_setAssociatedObject(self, @selector(isLike), @(isLike), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (BOOL)isLike {
    return [objc_getAssociatedObject(self, _cmd) boolValue];
}

- (void)setLikeTime:(NSInteger)likeTime {
    objc_setAssociatedObject(self, @selector(likeTime), @(likeTime), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSInteger)likeTime {
    return [objc_getAssociatedObject(self, _cmd) integerValue];
}

@end
