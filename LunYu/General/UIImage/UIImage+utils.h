//
//  UIImage+utils.h
//  iTing_rebuild
//
//  Created by zhengqiang zhang on 2018/9/7.
//  Copyright © 2018年 上海宝云网络. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (utils)

- (UIImage *)imagesRenderingOriginal;

+ (UIImage *)imageWithColor:(UIColor *)color ;

+ (UIImage *)imageWithGradientColors:(NSArray *)colors locations:(CGFloat *)locatoions startPoint:(CGPoint)startPoint endPoint:(CGPoint)endPoint;


@end
