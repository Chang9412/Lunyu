//
//  ZQLivePhotoMaker.h
//  LivePhotoMaker_test
//
//  Created by zhengqiang zhang on 2019/3/12.
//  Copyright © 2019 chang. All rights reserved.
//

#import <Foundation/Foundation.h>

@class UIImage;
typedef void(^kCompletion)(NSError *error, NSURL *imageUrl, NSURL *videoUrl);

@interface ZQLivePhotoMaker : NSObject

+ (void)livePhotoMakeWithImage:(UIImage *)image videoURL:(NSURL * _Nonnull)videoURL toImagePath:(NSString *)toImagePath toVideoPath:(NSString *)toVideoPath tmpImagePath:(NSString *)tmpImagePath completion:(kCompletion)completion;

+ (void)livePhotoMakeWithImage:(UIImage *)image videoURL:(NSURL * _Nonnull)videoURL completion:(kCompletion)completion;

+ (void)saveLivePhotoWithVideoUrl:(NSURL *)videoPath imageUrl:(NSURL *)imagePath success:(void(^)(BOOL isSuccess))successHandler;

@end

