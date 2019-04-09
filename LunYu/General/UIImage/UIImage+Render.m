//
//  UIImage+Render.m
//  WallPaper
//
//  Created by zhengqiang zhang on 2019/3/13.
//  Copyright © 2019 上海宝云网络. All rights reserved.
//

#import "UIImage+Render.h"

@implementation UIImage (Render)

+ (UIImage *)screenshotsMP4WithCurrentTime:(CMTime)currentTime videoUrl:(NSURL *)url {
    AVURLAsset * asset = [[AVURLAsset alloc] initWithURL:url options:nil];
    AVAssetImageGenerator * gen = [[AVAssetImageGenerator alloc] initWithAsset:asset];
    gen.appliesPreferredTrackTransform = YES;
    gen.requestedTimeToleranceAfter = kCMTimeZero;
    gen.requestedTimeToleranceBefore = kCMTimeZero;
    CMTime time = CMTimeMakeWithSeconds(CMTimeGetSeconds(currentTime), 600);
    NSError * error = nil;
    CMTime actualTime;
    CGImageRef imageRef = [gen copyCGImageAtTime:time actualTime:&actualTime error:&error];
    UIImage * image = [[UIImage alloc] initWithCGImage:imageRef];
    CGImageRelease(imageRef);
    return image;
}


+ (UIImage *)screenshotsm3u8WithCurrentTime:(CMTime)currentTime playerItemVideoOutput:(AVPlayerItemVideoOutput *)output{
    
    CVPixelBufferRef pixelBuffer = [output copyPixelBufferForItemTime:currentTime itemTimeForDisplay:nil];
    CIImage *ciImage = [CIImage imageWithCVPixelBuffer:pixelBuffer];
    CIContext *temporaryContext = [CIContext contextWithOptions:nil];
    CGImageRef videoImage = [temporaryContext createCGImage:ciImage
                                                   fromRect:CGRectMake(0, 0,
                                                                       CVPixelBufferGetWidth(pixelBuffer),
                                                                       CVPixelBufferGetHeight(pixelBuffer))];
    UIImage *frameImg = [UIImage imageWithCGImage:videoImage];
    CGImageRelease(videoImage);
    CVBufferRelease(pixelBuffer);
    return frameImg;
}
@end
