//
//  UIImage+Resize.m
//  VideoCompress
//
//  Created by zhengqiang zhang on 2019/3/12.
//  Copyright © 2019 chang. All rights reserved.
//

#import "UIImage+Resize.h"

@implementation UIImage (Resize)

- (UIImage *)fitResize:(CGSize)size  {
    return [self fitResize:size backgroundColor:[UIColor blackColor]];
}

- (UIImage *)fitResize:(CGSize)size backgroundColor:(UIColor *)color {
    UIGraphicsBeginImageContextWithOptions(size, false, 0);
    [color setFill];
    UIRectFill(CGRectMake(0, 0, size.width, size.height));
    
    CGFloat originWidth = self.size.width;
    CGFloat originHeight = self.size.height;
    
    CGFloat widthRatio = size.width / originWidth;
    CGFloat heightRatio = size.height / originHeight;
    CGFloat targetRatio = MIN(widthRatio, heightRatio); // 以小比例为准
    CGFloat targetWidth = originWidth * targetRatio;
    CGFloat targetHeight = originHeight * targetRatio;
    
    CGFloat x = (size.width - targetWidth) / 2;
    CGFloat y = (size.height - targetHeight) / 2;
    [self drawInRect:CGRectMake(x, y, targetWidth, targetHeight) blendMode:kCGBlendModeNormal alpha:1];
//    [self drawInRect:CGRectMake(x, y, targetWidth, targetHeight) blendMode:kCGBlendModeDestinationIn alpha:1];

    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}

@end
