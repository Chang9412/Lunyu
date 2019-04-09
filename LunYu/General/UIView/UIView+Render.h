//
//  UIView+Render.h
//  HanjuTV
//
//  Created by patrick on 17/5/8.
//  Copyright © 2017年 上海宝云网络. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>

@interface UIView (Render)

- (UIView *)customSnapshot;

- (UIImage *)presentationLayerCapture;

- (UIImage *)capture;

- (UIImage *)screenshotsm3u8WithCurrentTime:(CMTime)currentTime playerItemVideoOutput:(AVPlayerItemVideoOutput *)output;

- (UIImage *)screenshotsMP4WithCurrentTime:(CMTime)currentTime videoUrl:(NSString *)url;
@end
