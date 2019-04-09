//
//  UIColor+utils.m
//  iTing_rebuild
//
//  Created by zhengqiang zhang on 2018/9/7.
//  Copyright © 2018年 上海宝云网络. All rights reserved.
//

#import "UIColor+utils.h"

@implementation UIColor (utils)

+ (UIColor *)colorWithRGB:(NSInteger)rgb alpha:(CGFloat)alpha {
    NSInteger r = (rgb & 0xFF0000) >> 16;
    NSInteger g = (rgb & 0xFF00) >> 8;
    NSInteger b = (rgb & 0xFF) ;
    return [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:alpha];
}

+ (UIColor *)colorWithRGB:(NSInteger)rgb {
    return [self colorWithRGB:rgb alpha:1];
}

+ (UIColor *)random {
    NSInteger r = arc4random_uniform(255);
    NSInteger g = arc4random_uniform(255);
    NSInteger b = arc4random_uniform(255) ;
    return [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:1];
}

+ (UIColor *)navBarColor {
    static UIColor *color;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (color == nil) {
            color = [UIColor colorWithRGB:0x00a9ff];
        }
    });
    return color;
}

+ (UIColor *)segmentColor {
    static UIColor *color;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (color == nil) {
            color = [UIColor colorWithRGB:0xf4f4f4];
        }
    });
    return color;
}
+ (UIColor *)separatorLineColor {
    static UIColor *color;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (color == nil) {
            color = [UIColor colorWithRGB:0xe6e6e6];
        }
    });
    return color;
}

+ (UIColor *)color333 {
    static UIColor *color;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (color == nil) {
            color = [UIColor colorWithRGB:0x333333];
        }
    });
    return color;
}

+ (UIColor *)color666 {
    static UIColor *color;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (color == nil) {
            color = [UIColor colorWithRGB:0x666666];
        }
    });
    return color;
}

+ (UIColor *)color999 {
    static UIColor *color;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (color == nil) {
            color = [UIColor colorWithRGB:0x999999];
        }
    });
    return color;
}
@end
