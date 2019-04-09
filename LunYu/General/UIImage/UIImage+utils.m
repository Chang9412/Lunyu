//
//  UIImage+utils.m
//  iTing_rebuild
//
//  Created by zhengqiang zhang on 2018/9/7.
//  Copyright © 2018年 上海宝云网络. All rights reserved.
//

#import "UIImage+utils.h"

@implementation UIImage (utils)

- (UIImage *)imagesRenderingOriginal {
    return [self imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
}

+ (UIImage *)imageWithColor:(UIColor *)color {
    CGRect rect = CGRectMake(0, 0, 1, 1);
    UIGraphicsBeginImageContextWithOptions(rect.size, false, 0);
    [color setFill];
    UIRectFill(rect);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

+ (UIImage *)imageWithGradientColors:(NSArray *)colors locations:(CGFloat *)locatoions startPoint:(CGPoint)startPoint endPoint:(CGPoint)endPoint {
    CGRect rect = CGRectMake(0, 0, 1, 1);
    UIGraphicsBeginImageContextWithOptions(rect.size, false, 0);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGColorSpaceRef space = CGColorSpaceCreateDeviceRGB();
//    CGFloat compents[colors.count * 4];
//
//    for (UIColor *color in colors) {
//        color.CGColor.
//    }
    CFArrayRef colorArray = CFArrayCreate(kCFAllocatorDefault, (const void*[]){(__bridge const void *)(colors)}, colors.count, nil);
    CGGradientRef gradient = CGGradientCreateWithColors(space, colorArray, locatoions);
    CGContextDrawLinearGradient(context, gradient, startPoint, endPoint, kCGGradientDrawsAfterEndLocation);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}


@end
