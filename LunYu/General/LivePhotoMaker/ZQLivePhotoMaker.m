//
//  ZQLivePhotoMaker.m
//  LivePhotoMaker_test
//
//  Created by zhengqiang zhang on 2019/3/12.
//  Copyright © 2019 chang. All rights reserved.
//

#import "ZQLivePhotoMaker.h"
#import <UIKit/UIKit.h>
#import "ZQJPEGMaker.h"
#import "ZQQuickTimeMovMaker.h"
#import <Photos/Photos.h>

@implementation ZQLivePhotoMaker

+ (void)load {
    NSLog(@"%@", [self dirPath]);
    [[NSFileManager defaultManager] createDirectoryAtPath:[self dirPath] withIntermediateDirectories:YES attributes:nil error:nil];
}

+ (NSString *)dirPath {
    return  [NSHomeDirectory() stringByAppendingPathComponent:@"tmp/livephoto"];
}

+ (void)livePhotoMakeWithImage:(UIImage *)image videoURL:(NSURL * _Nonnull)videoURL completion:(kCompletion)completion {
    [self livePhotoMakeWithImage:image videoURL:videoURL toImagePath:nil toVideoPath:nil tmpImagePath:nil completion:completion];
}

+ (void)livePhotoMakeWithImage:(UIImage *)image videoURL:(NSURL * _Nonnull)videoURL toImagePath:(NSString *)toImagePath toVideoPath:(NSString *)toVideoPath tmpImagePath:(NSString *)tmpImagePath completion:(kCompletion)completion {
    NSString * assetIdentifier = [[NSUUID UUID] UUIDString];
    // 如果没有给临时存储路径，默认为沙盒/tmp文件下
    if (tmpImagePath.length<1) {
        tmpImagePath = [[self dirPath] stringByAppendingPathComponent:@"tmpCover.jpg"];
    }
    // 如果没有给最终存储图片地址，则默认Document文件下
    if (toImagePath.length<1) {
        toImagePath = [[self dirPath] stringByAppendingPathComponent:@"toCover.jpg"];
    }
    // 如果没有给最终存储视频地址，则默认Document文件下
    if (toVideoPath.length<1) {
        toVideoPath = [[self dirPath] stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.mov", [[videoURL lastPathComponent] stringByDeletingPathExtension]]];
    }
    
    NSData *imageData = UIImageJPEGRepresentation(image, 0.5);
    BOOL isok = [imageData writeToFile:tmpImagePath atomically:YES];
    if (!isok) {
        NSLog(@"图片写入错误！！");
        NSError *error = [NSError errorWithDomain:@"makelivephoto" code:7001 userInfo:@{NSLocalizedFailureReasonErrorKey:@"图片写入错误"}];
        completion(error, nil, nil);
        return;
    }
    //1.先把旧文件移除
    [[NSFileManager defaultManager] removeItemAtPath:tmpImagePath error:nil];
    [[NSFileManager defaultManager] removeItemAtPath:toImagePath error:nil];
    [[NSFileManager defaultManager] removeItemAtPath:toVideoPath error:nil];
    
    NSLog(@"制作中....");
    
    dispatch_group_t group = dispatch_group_create();
    dispatch_queue_t globle = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    //任务一 写入 图片
    __block BOOL writeImageResult;
    dispatch_group_async(group, globle, ^{
        [ZQJPEGMaker writeImage:image dest:toImagePath assetIdentifier:assetIdentifier result:^(BOOL res) {
            NSString *str = res ? @"图片写入成功" : @"图片写入失败";
            NSLog(@"%@", str);
            writeImageResult = res;
        }];

    });
    //任务二 写入 视频
    __block BOOL writeVideoResult;
    dispatch_group_async(group, globle, ^{
        [ZQQuickTimeMovMaker writeVideoUrl:videoURL dest:toVideoPath assetIdentifier:assetIdentifier result:^(BOOL res) {
            NSString *str = res ? @"视频写入成功" : @"视频写入失败";
            NSLog(@"%@", str);
            writeVideoResult = res;
        }];
       
    });
    
    dispatch_group_notify(group, dispatch_get_main_queue(), ^{
        if (!writeImageResult) {
            NSError *error = [NSError errorWithDomain:@"makelivephoto" code:7001 userInfo:@{NSLocalizedFailureReasonErrorKey:@"图片写入错误"}];
            completion(error, nil, nil);
            return ;
        }
        if (!writeVideoResult) {
            NSError *error = [NSError errorWithDomain:@"makelivephoto" code:7001 userInfo:@{NSLocalizedFailureReasonErrorKey:@"视频写入错误"}];
            completion(error, nil, nil);
            return ;
        }
        completion(nil, [NSURL fileURLWithPath:toImagePath], [NSURL fileURLWithPath:toVideoPath]);
    });
}

#pragma mark - save
+ (void)saveLivePhotoWithVideoUrl:(NSURL *)videoPath imageUrl:(NSURL *)imagePath success:(void(^)(BOOL isSuccess))successHandler {
    [PHPhotoLibrary requestAuthorization:^(PHAuthorizationStatus status) {
        if (status == PHAuthorizationStatusAuthorized) {
            //已经授权,直接保存
            [[PHPhotoLibrary sharedPhotoLibrary] performChanges:^{
                PHAssetCreationRequest * request = [PHAssetCreationRequest creationRequestForAsset];
                [request addResourceWithType:PHAssetResourceTypePhoto fileURL:imagePath options:nil];
                [request addResourceWithType:PHAssetResourceTypePairedVideo fileURL:videoPath options:nil];
            } completionHandler:^(BOOL success, NSError * _Nullable error) {
                NSString *str = success ? @"livephoto合成成功" : @"livephoto合成失败";
                NSLog(@"%@", str);
                if (successHandler) {
                    successHandler(success);
                    [[NSFileManager defaultManager] removeItemAtPath:imagePath.relativePath error:nil];
                    [[NSFileManager defaultManager] removeItemAtPath:videoPath.relativePath error:nil];
                }
            }];
        }else {
            //未授权，给一个提示框
            UIAlertController * alertCon = [UIAlertController alertControllerWithTitle:@"提示" message:@"App需要访问你的相册才能将数据写入相册，是否现在开启权限？" preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction * cancel = [UIAlertAction actionWithTitle:@"NO" style:UIAlertActionStyleDefault handler:nil];
            UIAlertAction * action = [UIAlertAction actionWithTitle:@"YES" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                NSURL * URL = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
                if ([[UIApplication sharedApplication] canOpenURL:URL]) {
                    [[UIApplication sharedApplication] openURL:URL options:@{} completionHandler:nil];
                }
            }];
            [alertCon addAction:cancel];
            [alertCon addAction:action];
            [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:alertCon animated:YES completion:nil];
        }
    }];
}

@end
