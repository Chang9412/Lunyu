//
//  ZQQuickTimeMovMaker.h
//  LivePhotoMaker_test
//
//  Created by zhengqiang zhang on 2019/3/12.
//  Copyright © 2019 chang. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ZQQuickTimeMovMaker : NSObject

+ (void)writeVideoUrl:(NSURL *)videoUrl dest:(NSString *)dest assetIdentifier:(NSString *)assetIdentifier result:(void(^)(BOOL res))result;

@end

NS_ASSUME_NONNULL_END
