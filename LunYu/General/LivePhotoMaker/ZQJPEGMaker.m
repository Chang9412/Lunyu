//
//  ZQJPEGMaker.m
//  LivePhotoMaker_test
//
//  Created by zhengqiang zhang on 2019/3/12.
//  Copyright © 2019 chang. All rights reserved.
//

#import "ZQJPEGMaker.h"
#import <UIKit/UIKit.h>
#import <CoreServices/CoreServices.h>

static NSString * const kZQAppleMakeLiveKey_AssetIdentifier = @"17";


@interface ZQJPEGMaker ()

@end

@implementation ZQJPEGMaker


+ (void)writeImage:(UIImage *)image dest:(NSString *)dest assetIdentifier:(NSString *)assetIdentifier result:(void(^)(BOOL res))result {
    CGImageDestinationRef ref = CGImageDestinationCreateWithURL((__bridge CFURLRef)[NSURL fileURLWithPath:dest], kUTTypeJPEG, 1, nil);
    if (!ref) {
        if (result) {
            result(NO);
        }
        return;
    }
    NSData *imageData = UIImageJPEGRepresentation(image, 0.5);
    CGImageSourceRef imageSource = CGImageSourceCreateWithData((__bridge CFDataRef)imageData, nil);
    if (!imageSource) {
        if (result) {
            result(NO);
        }
        return;
    }
    NSMutableDictionary * metadata = [CFBridgingRelease(CGImageSourceCopyPropertiesAtIndex(imageSource, 0, nil)) mutableCopy];
    if (!metadata) {
        if (result) {
            result(NO);
        }
        return;
    }
    //存储image
    NSMutableDictionary * makerNote = [[NSMutableDictionary alloc] init];
    [makerNote setObject:assetIdentifier forKey:kZQAppleMakeLiveKey_AssetIdentifier];
    [metadata setObject:makerNote forKey:(__bridge NSString *)kCGImagePropertyMakerAppleDictionary];
    //存储图片 设置一些属性
    CGImageDestinationAddImageFromSource(ref, imageSource, 0, (__bridge CFDictionaryRef)metadata);
    CFRelease(imageSource);
    CGImageDestinationFinalize(ref);
    if (result) {
        result(YES);
    }
}


@end
