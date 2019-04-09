//
//  UIImage+Resize.h
//  VideoCompress
//
//  Created by zhengqiang zhang on 2019/3/12.
//  Copyright © 2019 chang. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface UIImage (Resize)

- (UIImage *)fitResize:(CGSize)size;
- (UIImage *)fitResize:(CGSize)size backgroundColor:(UIColor *)color;

@end

