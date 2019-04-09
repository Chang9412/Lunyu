//
//  UIView+Render.m
//  HanjuTV
//
//  Created by patrick on 17/5/8.
//  Copyright © 2017年 上海宝云网络. All rights reserved.
//

#import "UIView+Render.h"

@implementation UIView (Render)

- (UIView *)customSnapshot {
    UIGraphicsBeginImageContextWithOptions(self.bounds.size, NO, 0);
    [self.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    UIView *snapshot = [[UIImageView alloc] initWithImage:image];
    return snapshot;
}

- (UIImage *)capture {
    UIGraphicsBeginImageContextWithOptions(self.bounds.size, NO, 0);
    [self.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

- (UIImage *)presentationLayerCapture {
    UIGraphicsBeginImageContextWithOptions(self.bounds.size, NO, 0);
    [self.layer.presentationLayer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

- (UIImage *)screenshotsMP4WithCurrentTime:(CMTime)currentTime videoUrl:(NSString *)url{
    AVURLAsset * asset = [[AVURLAsset alloc] initWithURL:[NSURL URLWithString:url] options:nil];
    AVAssetImageGenerator * gen = [[AVAssetImageGenerator alloc] initWithAsset:asset];
    gen.appliesPreferredTrackTransform = YES;
    gen.requestedTimeToleranceAfter = kCMTimeZero;
    gen.requestedTimeToleranceBefore = kCMTimeZero;
    CMTime time = CMTimeMakeWithSeconds(CMTimeGetSeconds(currentTime), 600);
    NSError * error = nil;
    CMTime actualTime;
    CGImageRef imageRef = [gen copyCGImageAtTime:time actualTime:&actualTime error:&error];
    UIImage * image = [[UIImage alloc] initWithCGImage:imageRef];
    return image;
}

- (UIImage *)screenshotsm3u8WithCurrentTime:(CMTime)currentTime playerItemVideoOutput:(AVPlayerItemVideoOutput *)output{
    
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
