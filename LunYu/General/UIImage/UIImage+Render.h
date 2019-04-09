//
//  UIImage+Render.h
//  WallPaper
//
//  Created by zhengqiang zhang on 2019/3/13.
//  Copyright © 2019 上海宝云网络. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIImage (Render)

+(UIImage *)screenshotsm3u8WithCurrentTime:(CMTime)currentTime playerItemVideoOutput:(AVPlayerItemVideoOutput *)output;

+ (UIImage *)screenshotsMP4WithCurrentTime:(CMTime)currentTime videoUrl:(NSURL *)url;

@end

NS_ASSUME_NONNULL_END
