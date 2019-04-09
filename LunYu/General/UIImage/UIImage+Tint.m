//
//  UIImage+Tint.m
//  ImageBlend
//
//  Created by 王 巍 on 13-4-29.
//  Copyright (c) 2013年 OneV-s-Den. All rights reserved.
//

#import "UIImage+Tint.h"

@implementation UIImage (Tint)

- (UIImage *)imageWithTintColor:(UIColor *)tintColor {
    return [self imageWithTintColor:tintColor blendMode:kCGBlendModeDestinationIn];
}

- (UIImage *)imageWithGradientTintColor:(UIColor *)tintColor {
    return [self imageWithTintColor:tintColor blendMode:kCGBlendModeOverlay];
}

- (UIImage *)imageWithTintColor:(UIColor *)tintColor blendMode:(CGBlendMode)blendMode {
    //We want to keep alpha, set opaque to NO; Use 0.0f for scale to use the scale factor of the device’s main screen.
    UIGraphicsBeginImageContextWithOptions(self.size, NO, 0.0f);
    [tintColor setFill];
    CGRect bounds = CGRectMake(0, 0, self.size.width, self.size.height);
    UIRectFill(bounds);
    
    //Draw the tinted image in context
    [self drawInRect:bounds blendMode:blendMode alpha:1.0f];
    
    if (blendMode != kCGBlendModeDestinationIn) {
        [self drawInRect:bounds blendMode:kCGBlendModeDestinationIn alpha:1.0f];
    }
    
    UIImage *tintedImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return tintedImage;
}

- (UIImage *)imageWithAnotherImage:(UIImage *)anotherImage imageAlignment:(BYImageAlignment)alignment {
    return [self imageWithAnotherImage:anotherImage imageAlignment:alignment blendMode:kCGBlendModeOverlay];
}

- (UIImage *)grayImage {
    CGImageRef  imageRef;
    imageRef = self.CGImage;
    
    size_t width  = CGImageGetWidth(imageRef) ;
    size_t height = CGImageGetHeight(imageRef) ;
    
    // ピクセルを構成するRGB各要素が何ビットで構成されている
    size_t                  bitsPerComponent;
    bitsPerComponent = CGImageGetBitsPerComponent(imageRef);
    
    // ピクセル全体は何ビットで構成されているか
    size_t                  bitsPerPixel;
    bitsPerPixel = CGImageGetBitsPerPixel(imageRef);
    
    // 画像の横1ライン分のデータが、何バイトで構成されているか
    size_t                  bytesPerRow;
    bytesPerRow = CGImageGetBytesPerRow(imageRef);
    
    // 画像の色空間
    CGColorSpaceRef         colorSpace;
    colorSpace = CGImageGetColorSpace(imageRef);
    
    // 画像のBitmap情報
    CGBitmapInfo            bitmapInfo;
    bitmapInfo = CGImageGetBitmapInfo(imageRef);
    
    // 画像がピクセル間の補完をしているか
    bool                    shouldInterpolate;
    shouldInterpolate = CGImageGetShouldInterpolate(imageRef);
    
    // 表示装置によって補正をしているか
    CGColorRenderingIntent  intent;
    intent = CGImageGetRenderingIntent(imageRef);
    
    // 画像のデータプロバイダを取得する
    CGDataProviderRef   dataProvider;
    dataProvider = CGImageGetDataProvider(imageRef);
    
    // データプロバイダから画像のbitmap生データ取得
    CFDataRef   data;
    UInt8*      buffer;
    data = CGDataProviderCopyData(dataProvider);
    buffer = (UInt8*)CFDataGetBytePtr(data);
    
    // 1ピクセルずつ画像を処理
    NSUInteger  x, y;
    for (y = 0; y < height; y++) {
        for (x = 0; x < width; x++) {
            UInt8*  tmp;
            tmp = buffer + y * bytesPerRow + x * 4; // RGBAの4つ値をもっているので、1ピクセルごとに*4してずらす
            
            // RGB値を取得
            UInt8 red,green,blue;
            red = *(tmp + 0);
            green = *(tmp + 1);
            blue = *(tmp + 2);
            
            UInt8 brightness;
            

            brightness = (77 * red + 28 * green + 151 * blue) / 256;
            
            *(tmp + 0) = brightness;
            *(tmp + 1) = brightness;
            *(tmp + 2) = brightness;

        }
    }
    
    // 効果を与えたデータ生成
    CFDataRef   effectedData;
    effectedData = CFDataCreate(NULL, buffer, CFDataGetLength(data));
    
    // 効果を与えたデータプロバイダを生成
    CGDataProviderRef   effectedDataProvider;
    effectedDataProvider = CGDataProviderCreateWithCFData(effectedData);
    
    // 画像を生成
    CGImageRef  effectedCgImage;
    UIImage*    effectedImage;
    effectedCgImage = CGImageCreate(
                                    width, height,
                                    bitsPerComponent, bitsPerPixel, bytesPerRow,
                                    colorSpace, bitmapInfo, effectedDataProvider,
                                    NULL, shouldInterpolate, intent);
    effectedImage = [[UIImage alloc] initWithCGImage:effectedCgImage];
    
    // データの解放
    CGImageRelease(effectedCgImage);
    CFRelease(effectedDataProvider);
    CFRelease(effectedData);
    CFRelease(data);
    UIGraphicsBeginImageContext(CGSizeMake(width/2, height/2));
    // 绘制改变大小的图片
    [effectedImage drawInRect:CGRectMake(0, 0, width/2, height/2)];
    // 从当前context中创建一个改变大小后的图片
    UIImage* scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    // 使当前的context出堆栈
    UIGraphicsEndImageContext();
    // 返回新的改变大小后的图片
    return scaledImage;
}

- (UIImage *)imageWithAnotherImage:(UIImage *)anotherImage imageAlignment:(BYImageAlignment)alignment blendMode:(CGBlendMode)mode {
    UIGraphicsBeginImageContextWithOptions(self.size, NO, 0.0f);
    CGRect bounds = CGRectMake(0, 0, self.size.width, self.size.height);
    [self drawInRect:bounds blendMode:kCGBlendModeNormal alpha:1.0f];
    CGRect anotherBounds;
    switch (alignment) {
        case BYImageAlignmentLeftTop:
            anotherBounds = CGRectMake(0, 0, anotherImage.size.width, anotherImage.size.height);
            break;
        case BYImageAlignmentLeftMiddle:
            anotherBounds = CGRectMake(0, (self.size.height - anotherImage.size.height) / 2.0f, anotherImage.size.width, anotherImage.size.height);
            break;
        case BYImageAlignmentLeftBottom:
            anotherBounds = CGRectMake(0, self.size.height - anotherImage.size.height, anotherImage.size.width, anotherImage.size.height);
            break;
        case BYImageAlignmentCenter:
            anotherBounds = CGRectMake((self.size.width - anotherImage.size.width) / 2.0f, (self.size.height - anotherImage.size.height) / 2.0f, anotherImage.size.width, anotherImage.size.height);
            break;
        case BYImageAlignmentMiddleTop:
            anotherBounds = CGRectMake((self.size.width - anotherImage.size.width) / 2.0f, 0, anotherImage.size.width, anotherImage.size.height);
            break;
        case BYImageAlignmentMiddleBottom:
            anotherBounds = CGRectMake((self.size.width - anotherImage.size.width) / 2.0f, self.size.height - anotherImage.size.height, anotherImage.size.width, anotherImage.size.height);
            break;
        case BYImageAlignmentRightTop:
            anotherBounds = CGRectMake(self.size.width - anotherImage.size.width, 0, anotherImage.size.width, anotherImage.size.height);
            break;
        case BYImageAlignmentRightMiddle:
            anotherBounds = CGRectMake(self.size.width - anotherImage.size.width, (self.size.height - anotherImage.size.height) / 2.0f, anotherImage.size.width, anotherImage.size.height);
            break;
        case BYImageAlignmentRightBottom:
            anotherBounds = CGRectMake(self.size.width - anotherImage.size.width, self.size.height - anotherImage.size.height, anotherImage.size.width, anotherImage.size.height);
            break;
        case BYImageAlignmentScaleToFill:
            anotherBounds = bounds;
            break;
        case BYImageAlignmentScaleAspectFit: {
            CGSize finalSize;
            if (self.size.width / self.size.height > anotherImage.size.width / self.size.height) {
                float scale = self.size.height / anotherImage.size.height;
                finalSize = CGSizeMake(anotherImage.size.width * scale, anotherImage.size.height * scale);
            } else {
                float scale = self.size.width / anotherImage.size.width;
                finalSize = CGSizeMake(anotherImage.size.width * scale, anotherImage.size.height * scale);
            }
            anotherBounds = CGRectMake((self.size.width - finalSize.width) / 2.0f, (self.size.height - finalSize.height) / 2.0f, finalSize.width, finalSize.height);
        }
            break;
        case BYImageAlignmentScaleAspectFill: {
            CGSize finalSize;
            if (self.size.width / self.size.height < anotherImage.size.width / self.size.height) {
                float scale = self.size.height / anotherImage.size.height;
                finalSize = CGSizeMake(anotherImage.size.width * scale, anotherImage.size.height * scale);
            } else {
                float scale = self.size.width / anotherImage.size.width;
                finalSize = CGSizeMake(anotherImage.size.width * scale, anotherImage.size.height * scale);
            }
            anotherBounds = CGRectMake((self.size.width - finalSize.width) / 2.0f, (self.size.height - finalSize.height) / 2.0f, finalSize.width, finalSize.height);
            
        }
            break;
        default:
            anotherBounds = CGRectMake(0, 0, anotherImage.size.width, anotherImage.size.height);
            break;
    }
    
    [anotherImage drawInRect:anotherBounds blendMode:mode alpha:1.0f];
    UIImage *finalImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return finalImage;
}
@end
