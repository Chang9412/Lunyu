//
//  UIImage+Tint.h
//  ImageBlend
//
//  Created by 王 巍 on 13-4-29.
//  Copyright (c) 2013年 OneV-s-Den. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, BYImageAlignment) {
    BYImageAlignmentLeftTop      = 0,
    BYImageAlignmentLeftMiddle,
    BYImageAlignmentLeftBottom,
    BYImageAlignmentCenter,
    BYImageAlignmentMiddleTop,
    BYImageAlignmentMiddleBottom,
    BYImageAlignmentRightTop,
    BYImageAlignmentRightMiddle,
    BYImageAlignmentRightBottom,
    BYImageAlignmentScaleToFill,
    BYImageAlignmentScaleAspectFit,
    BYImageAlignmentScaleAspectFill
};

@interface UIImage (Tint)

- (UIImage *)imageWithTintColor:(UIColor *)tintColor;
- (UIImage *)imageWithGradientTintColor:(UIColor *)tintColor;
- (UIImage *)imageWithAnotherImage:(UIImage *)anotherImage imageAlignment:(BYImageAlignment)alignment;
- (UIImage *)imageWithAnotherImage:(UIImage *)anotherImage imageAlignment:(BYImageAlignment)alignment blendMode:(CGBlendMode)mode;
@end
