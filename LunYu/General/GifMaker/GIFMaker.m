//
//  GIFMaker.m
//  MakeGIF
//
//  Created by zhengqiang zhang on 2019/1/9.
//  Copyright © 2019 上海宝云网络. All rights reserved.
//

#import "GIFMaker.h"
//#import <CoreGraphics/CoreGraphics.h>
#import <UIKit/UIKit.h>
#import <MobileCoreServices/MobileCoreServices.h>

@implementation GIFMaker

+ (void)makeGifToPath:(NSString *)path images:(NSArray *)images {
    
    CGImageDestinationRef destination;
    CFURLRef url = CFURLCreateWithFileSystemPath(kCFAllocatorDefault, (CFStringRef)path, kCFURLPOSIXPathStyle, NO);
    destination = CGImageDestinationCreateWithURL(url, kUTTypeGIF, images.count, nil);
    NSDictionary *frameProperties = [NSDictionary dictionaryWithObject:[NSMutableDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithFloat:0.18],(NSString *)kCGImagePropertyGIFDelayTime, nil, nil] forKey:(NSString *)kCGImagePropertyGIFDictionary];
    
    //设置gif信息
    
    NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithCapacity:2];
    
    [dict setObject:[NSNumber numberWithBool:YES] forKey:(NSString *)kCGImagePropertyGIFImageColorMap];
    
    [dict setObject:(NSString *)kCGImagePropertyColorModelRGB forKey:(NSString *)kCGImagePropertyColorModel];
    
    [dict setObject:[NSNumber numberWithInt:8] forKey:(NSString *)kCGImagePropertyDepth];
    [dict setObject:[NSNumber numberWithInteger:NSIntegerMax] forKey:(NSString *)kCGImagePropertyGIFLoopCount];
    NSDictionary *gifProperties = [NSDictionary dictionaryWithObject:dict forKey:(NSString *)kCGImagePropertyGIFDictionary];
    for (UIImage *dImg in images)
    {
        CGImageDestinationAddImage(destination, dImg.CGImage, (__bridge CFDictionaryRef)frameProperties);
    }
    CGImageDestinationSetProperties(destination, (__bridge CFDictionaryRef)gifProperties);
    CGImageDestinationFinalize(destination);
    CFRelease(destination);
}

@end
